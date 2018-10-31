//
//  HomeViewController.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "HomeViewController.h"
#import "ChildViewController.h"
#import "LJCommendViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor brownColor];
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextAction)];
    
    self.navItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"table" style:UIBarButtonItemStylePlain target:self action:@selector(tableAction)];    
}

- (void)nextAction {
    
    [self.navigationController pushViewController:[ChildViewController new] animated:YES];
}

- (void)tableAction {
    
    [self.navigationController pushViewController:[LJCommendViewController new] animated:YES];
}

@end
