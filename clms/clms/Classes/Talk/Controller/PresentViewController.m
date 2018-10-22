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

@interface PresentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cz_randomColor;
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navItem.title = @"所有栏目";
    
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeAction)];
    
    
    [self.collectionView registerClass:[PreCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSArray *)dataArr {
    
    return  @[
              @"关注",@"头条",@"视频",@"娱乐",@"体育",@"新时代",
              @"要闻",@"段子",@"杭州",@"公开课",@"财经",@"科技",
              @"汽车",@"网易号",@"军事",@"时尚",@"直播",@"图片",
              @"跟帖",@"NBA",@"热点",@"房产",@"股票",@"轻松一刻",
              @"历史",@"居家",@"独居",@"游戏",@"健康",@"航空",@"彩票",@"漫画",
              @"新闻学院",@"改革开放",@"影视",@"音乐",@"中国足球",
              @"国际足球",@"CBA",@"跑步",@"冬奥",@"手机",@"数码",
              @"态度公开课",@"易城",@"旅游",@"读书",@"酒香",@"教育",
              @"亲子",@"二次元",@"态度营销",@"佛学",@"女人",@"艺术",
              @"阳光法院",@"双创",@"京东",@"星座",@"天猫",@"萌宠",
              ];
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
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
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}


- (void)closeAction {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
