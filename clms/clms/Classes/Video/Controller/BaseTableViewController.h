//
//  BaseTableViewController.h
//  clms
//
//  Created by ljkj on 2018/10/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LJRefreshControl.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong) LJRefreshControl *refreshControl;


@property (nonatomic, strong) UITableView *tableView;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end
