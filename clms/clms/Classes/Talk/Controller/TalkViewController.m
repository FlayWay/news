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
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 40);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor brownColor];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn {
    
    NSLog(@"%s------%@",__func__,btn);
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
    }else {
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
    }
}

- (void)nextAction {
    
    [self.navigationController pushViewController:[TalkListViewController new] animated:YES];
    
}
@end
