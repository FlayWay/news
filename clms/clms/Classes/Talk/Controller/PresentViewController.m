//
//  PresentViewController.m
//  clms
//
//  Created by ljkj on 2018/10/16.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "PresentViewController.h"
#import "PresentFlowLayout.h"
#import "PreCell.h"
#import "AddNormalCell.h"
#import "CollectionHeaderView.h"
#import "LJPtModel.h"
#import "CollectionSpecialView.h"

static CGFloat itemHeight = 40;
static CGFloat margin = 20;
static CGFloat colCount = 3;
static CGFloat itemWith = 80;

@interface PresentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)  CollectionHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArr1;
@property (nonatomic, strong) NSMutableArray *dataArr2;

@end

@implementation PresentViewController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)dataArr1 {
    if (!_dataArr1) {
        _dataArr1 = [NSMutableArray array];
    }
    return _dataArr1;
}

- (NSMutableArray *)dataArr2 {
    if (!_dataArr2) {
        _dataArr2 = [NSMutableArray array];
    }
    return _dataArr2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cz_randomColor;
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navItem.title = @"所有栏目";
    NSArray *array1 = @[
                       @{@"str":@"关注"},@{@"str":@"头条"},@{@"str":@"视频"},
                       @{@"str":@"娱乐"},@{@"str":@"体育"},@{@"str":@"新时代"},
                       @{@"str":@"要闻"},@{@"str":@"段子"},@{@"str":@"杭州"},
                       @{@"str":@"公开课"},@{@"str":@"财经"},@{@"str":@"科技"},
                       @{@"str":@"汽车"},@{@"str":@"网易号"},@{@"str":@"军事"}];
    self.dataArr = [[NSArray yy_modelArrayWithClass:[LJPtModel class] json:array1] mutableCopy];
    NSArray *array2 =  @[
                         @{@"str":@"萌宠"},@{@"str":@"天猫"},@{@"str":@"星座"},
                         @{@"str":@"双创"},@{@"str":@"京东"},@{@"str":@"法院"},
                         @{@"str":@"艺术"},@{@"str":@"女人"},@{@"str":@"佛学"},
                         @{@"str":@"二次元"},@{@"str":@"亲子"},@{@"str":@"酒香"},
                         @{@"str":@"读书"},@{@"str":@"旅游"},@{@"str":@"易城"}];
    
    self.dataArr2 = [[NSArray yy_modelArrayWithClass:[LJPtModel class] json:array2] mutableCopy];
    
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeAction)];
    
    [self.collectionView registerClass:[PreCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[AddNormalCell class] forCellWithReuseIdentifier:@"addNormal"];


    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.collectionView registerClass:[CollectionSpecialView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"special"];

    
    UILongPressGestureRecognizer *presTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:presTap];
    
}

#pragma mark --- 手势
- (void)longPressAction:(UILongPressGestureRecognizer *)gesture {
    
    if ([self.headerView.editBtn.titleLabel.text isEqualToString:@"完成"]) {
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan:
            {
                
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
                
                if (selectIndexPath != nil) {
                
                    [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                    
                }
                
                
            }
                break;
            case UIGestureRecognizerStateChanged:
            {


                [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
                
            }
                break;
            case UIGestureRecognizerStateEnded:
            {
                
                [self.collectionView endInteractiveMovement];
            }
                break;
            default: [self.collectionView cancelInteractiveMovement];
                break;
        }
        
    }else {
        
        [self.dataArr enumerateObjectsUsingBlock:^(LJPtModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            model.isEditor = YES;
        }];
        [self.headerView.editBtn setTitle:@"完成" forState:UIControlStateNormal];

        [self.collectionView reloadData];
    }
    
    
    
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (touch.view != self.collectionView) {
        
        return NO;
    }
    return YES;
}



- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
   
        CGFloat rowMargin = (self.view.bounds.size.width - margin * 2 - itemWith * colCount) / (colCount - 1);
        layout.minimumInteritemSpacing = rowMargin;
        layout.minimumLineSpacing = 20;
        layout.itemSize = CGSizeMake(itemWith, 30);
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavBarHeight, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - NavBarHeight) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        
    }
    
    return _collectionView;
}

#pragma mark --- UICollectionViewCellDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AddNormalCell *addCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addNormal" forIndexPath:indexPath];

    if (indexPath.section == 0) {
        
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }else if (indexPath.section == 1) {
        
        addCell.model = self.dataArr1[indexPath.row];
        return addCell;
    } else if (indexPath.section == 2) {
        addCell.model = self.dataArr2[indexPath.row];
        return addCell;
    }
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
    
        return self.dataArr.count;
        
    }else if (section == 1) {
        
        return self.dataArr1.count;
        
    }else if (section == 2) {
        
        return self.dataArr2.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

- (void)closeAction {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section == 0) {
        
        if (kind == UICollectionElementKindSectionHeader) {
            
            CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            reusableview = headerView;
            self.headerView = headerView;
            [self.headerView.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            return reusableview;
        }
    }else {
        if (kind == UICollectionElementKindSectionHeader) {
            CollectionSpecialView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"special" forIndexPath:indexPath];
            reusableview = headerView;
            return reusableview;
        }
    }
    return nil;
}

#pragma mark ---编辑事件
- (void)editBtnAction:(UIButton *)editBtn {
    
        
    NSLog(@"%s-------%@",__func__,editBtn);
    if ([editBtn.titleLabel.text isEqualToString:@"编辑"]) {
        [editBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.dataArr enumerateObjectsUsingBlock:^(LJPtModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            model.isEditor = YES;
        }];
        [self.collectionView reloadData];
        
        
    }else {
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.dataArr enumerateObjectsUsingBlock:^(LJPtModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            model.isEditor = NO;
        }];
        [self.collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return CGSizeMake(self.view.bounds.size.width, 60);
    }else if (section == 1) {
        
        if (self.dataArr1.count == 0) {
            return  CGSizeMake(0, 0);
        }else {
            return CGSizeMake(self.view.bounds.size.width, 60);
        }
        
    }else if (section == 2) {
     
        if (self.dataArr2.count == 0) {
            return  CGSizeMake(0, 0);
        }else {
            
            return CGSizeMake(self.view.bounds.size.width, 60);
        }
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s",__func__);
    
    if (indexPath.section == 0) {
        
        if ([self.headerView.editBtn.titleLabel.text isEqualToString:@"编辑"]) {
            
            [self.dataArr enumerateObjectsUsingBlock:^(LJPtModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                model.isEditor = YES;
            }];
            [self.headerView.editBtn setTitle:@"完成" forState:UIControlStateNormal];
            
        }else {
            
            [self.dataArr1 addObject:self.dataArr[indexPath.item]];
            [self.dataArr removeObjectAtIndex:indexPath.item];
            
        }
    }else if (indexPath.section == 1){
        
        LJPtModel *model = self.dataArr1[indexPath.item];
        model.isEditor = YES;
        [self.dataArr addObject:model];
        [self.dataArr1 removeObjectAtIndex:indexPath.item];
        
    }else if (indexPath.section == 2) {
        LJPtModel *model = self.dataArr2[indexPath.item];
        model.isEditor = YES;
        [self.dataArr addObject:model];
        [self.dataArr2 removeObjectAtIndex:indexPath.item];
        
    }
    
    [self.collectionView reloadData];
    
   

}

#pragma mark --ios9支持
- (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

// 在开始移动时会调用此代理方法，
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

// 在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  
    NSString *str = self.dataArr[sourceIndexPath.item];
    [self.dataArr removeObjectAtIndex:sourceIndexPath.item];
    [self.dataArr insertObject:str atIndex:destinationIndexPath.item];
}

-(NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
    
    /* 两个indexpath参数, 分别代表源位置, 和将要移动的目的位置*/
    //-1 是为了不让最后一个可以交换位置
    if (proposedIndexPath.section) {
        
        return originalIndexPath;
    }
    if (proposedIndexPath.item == 1 ){
        //初始位置
        return originalIndexPath;
    } else {
        //-1 是为了不让最后一个可以交换位置
        if (originalIndexPath.item == 1) {
            return originalIndexPath;
        }
        //      移动后的位置
        return proposedIndexPath;
    }
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


@end
