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

//- (void)setupTableView {
//    self.tableView = [[UITableView alloc]initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    if (@available(iOS 11.0,*)) {
//        
//        UITableView.appearance.estimatedRowHeight = 0;
//        UITableView.appearance.estimatedSectionFooterHeight = 0;
//        UITableView.appearance.estimatedSectionHeaderHeight = 0;
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        
//    }else {
//        
//        self.automaticallyAdjustsScrollViewInsets = false;
//    }
//    
//    CGFloat bottom = self.tabBarController.tabBar.bounds.size.height;
//    if ([self isKindOfClass:[HomeViewController class]]) {
//        
//        self.tableView.contentInset = UIEdgeInsetsMake(NavBarHeight+44, 0, bottom, 0);
//    }else {
//        self.tableView.contentInset = UIEdgeInsetsMake(NavBarHeight, 0, bottom, 0);
//    }
//    [self.view insertSubview:self.tableView belowSubview:self.navigationBar];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return [UITableViewCell new];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 0;
//}

@end
