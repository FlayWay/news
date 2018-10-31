//
//  LJCommendViewController.m
//  clms
//
//  Created by ljkj on 2018/10/31.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJCommendViewController.h"
#import <AFNetworking.h>

@interface LJCommendViewController ()<NSURLSessionDelegate>

@end

@implementation LJCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    // 显示指示器
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"a" forKey:@"category"];
    [params setValue:@"c" forKey:@"subscribe"];
    [[AFHTTPSessionManager manager] GET:@"http://5345345" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        NSLog(@"responseObject===%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
    }];
    

}


@end
