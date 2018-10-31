//
//  TableViewController.m
//  clms
//
//  Created by ljkj on 2018/9/30.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "TableViewController.h"
#import "config.h"

static NSString *cellId = @"cellid";
@interface TableViewController ()


@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:LJDisplayViewClickOrScrollDidFinshNote object:self];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)loadData {
    
    [self.refreshControl beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"结束刷新");
        [self.refreshControl endRefreshing];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行 --------%@",indexPath.row,self.title];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

@end
