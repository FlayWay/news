//
//  VideoViewController.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "VideoViewController.h"
#import "TestViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextAction)];
    
}

- (void)nextAction {
    
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
