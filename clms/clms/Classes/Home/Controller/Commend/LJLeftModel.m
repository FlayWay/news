//
//  LJLeftModel.m
//  clms
//
//  Created by ljkj on 2018/11/1.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJLeftModel.h"
#import <YYModel.h>

@implementation LJLeftModel

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"categoryId":@"id"
             };
}

@end
