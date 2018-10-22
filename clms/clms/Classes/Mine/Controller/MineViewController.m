//
//  MineViewController.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "MineViewController.h"
#import "TestPViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(nextAction)];
    
}

- (void)nextAction {
    
    [self.navigationController pushViewController:[TestPViewController new] animated:true];
}

@end
