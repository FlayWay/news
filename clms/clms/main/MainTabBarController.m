//
//  MainTabBarController.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "VideoViewController.h"
#import "TalkViewController.h"
#import "MineViewController.h"
#import "NavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setupChildControllers];
    
    
}

- (void)setupChildControllers {
    
    NSArray *array = @[
                       @{@"clsName":@"HomeViewController",@"title":@"首页",@"imageName":@"home"},
                       @{@"clsName":@"VideoViewController",@"title":@"视频",@"imageName":@"home"},
                       @{@"clsName":@"TalkViewController",@"title":@"讲讲",@"imageName":@"home"},
                       @{@"clsName":@"MineViewController",@"title":@"我的",@"imageName":@"home"},
                       ];
    
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        BaseViewController *vc = (BaseViewController *)[self viewcontroller:dict];
        [controllers addObject:vc];
    }
    self.viewControllers = controllers;
    [self.tabBar showBadgeOnItemIndex:0];
    [self.tabBar showBageOnItemWithIndex:1 value:@"2"];
    
}

- (UIViewController *)viewcontroller:(NSDictionary *)dict {
    
    NSString *clsName = dict[@"clsName"];
    NSString *title = dict[@"title"];
    NSString *imageName = dict[@"imageName"];
    Class class = NSClassFromString(clsName);
    BaseViewController *vc = [[class alloc]init];
    vc.title = title;
    NSString *normalImage = [NSString stringWithFormat:@"tabbar_%@",imageName];
    NSString *selectImage = [NSString stringWithFormat:@"tabbar_%@_selected",imageName];
    vc.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.orangeColor} forState:UIControlStateHighlighted];
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:vc];
    
    return nav;
}

@end
