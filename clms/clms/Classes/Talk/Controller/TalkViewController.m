//
//  TalkViewController.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "TalkViewController.h"
#import "TalkListViewController.h"

@interface TalkViewController ()

@end

@implementation TalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextAction)];
    
}

- (void)nextAction {
    
    [self.navigationController pushViewController:[TalkListViewController new] animated:YES];
    
}
@end
