//
//  LJLeftModel.h
//  clms
//
//  Created by ljkj on 2018/11/1.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJLeftModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *count;



/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@end

NS_ASSUME_NONNULL_END
