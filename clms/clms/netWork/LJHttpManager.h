//
//  LJHttpManager.h
//  clms
//
//  Created by ljkj on 2018/9/25.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSUInteger,LJHttpMethod) {
    
    GET,
    POST
};

@interface LJHttpManager : AFHTTPSessionManager

+ (instancetype)shared;

- (void)requesetMethods:(LJHttpMethod)method url:(NSString *)urlString params:(NSMutableDictionary *)params completion:(void(^)(id result,BOOL isSuccess))completion;


@end
