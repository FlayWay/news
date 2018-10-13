//
//  BaseViewController.h
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NavigationBar *navigationBar;
@property (nonatomic, strong) UINavigationItem *navItem;
//@property (nonatomic, strong) UITableView *tableView;
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end
