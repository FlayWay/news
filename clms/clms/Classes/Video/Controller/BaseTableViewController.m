//
//  BaseTableViewController.m
//  clms
//
//  Created by ljkj on 2018/10/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "BaseTableViewController.h"


@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.tableView belowSubview:self.navigationBar];
    self.tableView.contentInset = UIEdgeInsetsMake(NavBarHeight, 0, 0, 0);
    
    if (@available(iOS 11.0,*)) {

        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    self.refreshControl = [[LJRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)loadData {
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
