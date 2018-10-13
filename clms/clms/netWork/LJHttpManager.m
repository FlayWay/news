//
//  LJHttpManager.m
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJHttpManager.h"

static LJHttpManager *manager = nil;

@implementation LJHttpManager

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LJHttpManager alloc]init];
    });
    return manager;
}

- (void)requesetMethods:(LJHttpMethod)method url:(NSString *)urlString params:(NSMutableDictionary *)params completion:(void(^)(id result,BOOL isSuccess))completion {
    
    void (^success)(NSURLSessionDataTask *task, id respons) = ^(NSURLSessionDataTask *task, id response){
        
        completion(response,YES);
    };
    
    void (^failure)(NSURLSessionDataTask *task,id response) = ^(NSURLSessionDataTask *task,NSError *error){
        
        completion(nil,NO);
    };
    
    if (method == GET) {
        
        [manager GET:urlString parameters:params progress:nil success:success failure:failure];
    }else {
        
        [manager POST:urlString parameters:params progress:nil success:success failure:failure];
    }
    
}

@end
