//
//  LJHttpManager+Extension.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJHttpManager+Extension.h"

@implementation LJHttpManager (Extension)

- (void)statusList:(void(^)(NSArray *result,BOOL isSuccess))completion {
    
    NSString *urlString = @"";
    
    [self requesetMethods:GET url:urlString params:nil completion:^(id result, BOOL isSuccess) {
       
        NSArray *arr =result[@"statuses"];
        completion(arr,isSuccess);
    }];
    
}


@end
