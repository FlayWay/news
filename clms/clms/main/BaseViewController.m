//
//  BaseViewController.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeViewController.h"


@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation BaseViewController

- (NavigationBar *)navigationBar {
    if (!_navigationBar) {
        
        _navigationBar = [[NavigationBar alloc]init];
    }
    return _navigationBar;
}

- (UINavigationItem *)navItem {
    if (!_navItem) {
        _navItem = [[UINavigationItem alloc]init];
    }
    return _navItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setNavigationBar];
//    self.view.backgroundColor = [UIColor cz_randomColor];
//    [self setupTableView];
}

- (void)setNavigationBar {
    
    [self.view addSubview:self.navigationBar];
    self.navigationBar.items = @[self.navItem];
    self.navItem.title = self.title;
    self.navigationBar.barTintColor = [UIColor cz_colorWithHex:0xF6F6F6];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.orangeColor}];
    self.navigationBar.tintColor = UIColor.orangeColor;
    
}

@end
