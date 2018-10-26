//
//  TestPViewController.m
//  clms
//
//  Created by ljkj on 2018/10/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "TestPViewController.h"
#import "TestCell.h"
#import "TestPFlowLayout.h"
#import "LJShopModel.h"




@interface TestPViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TestPFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation TestPViewController

- (NSMutableArray *)shops {
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        TestPFlowLayout *flowLayout = [[TestPFlowLayout alloc]init];
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
       _collectionView.contentInset = UIEdgeInsetsMake(NavBarHeight, 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
    
}

- (void)setupLayout {
    
    [self.view insertSubview:self.collectionView belowSubview:self.navigationBar];
    [self.collectionView registerClass:[TestCell class] forCellWithReuseIdentifier:@"cell"];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
    }
}

- (void)setupRefresh {

    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRrefresh)];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
     self.collectionView.footer.hidden = YES;
}

#pragma mark -- 刷新
- (void)loadNewRrefresh {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *plistArr = [NSArray arrayWithContentsOfFile:path];
        NSArray *listShops = [NSArray yy_modelArrayWithClass:[LJShopModel class] json:plistArr];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:listShops];
        [self.collectionView reloadData];

        [self.collectionView.mj_header endRefreshing];
    });
}


- (void)loadMoreShops {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *plistArr = [NSArray arrayWithContentsOfFile:path];
        NSArray *listShops = [NSArray yy_modelArrayWithClass:[LJShopModel class] json:plistArr];
        [self.shops addObjectsFromArray:listShops];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        
    });
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark - <TestPFlowLayoutDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (CGFloat)waterflowLayout:(TestPFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    
    LJShopModel *shop = self.shops[index];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)columnCountInWaterflowLayout:(TestPFlowLayout *)waterflowLayout {
    return 2;
}

- (CGFloat)columnMarginInWaterflowLayout:(TestPFlowLayout *)waterflowLayout {
    
    return 20;
}

- (CGFloat)rowMarginInWaterflowLayout:(TestPFlowLayout *)waterflowLayout {
    
    return 20;
}


@end
