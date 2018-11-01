//
//  LJRightModel.h
//  clms
//
//  Created by ljkj on 2018/11/1.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJRightModel : NSObject

/**头像*/
@property (nonatomic, copy) NSString *header;
/**粉丝数*/
@property (nonatomic, copy) NSString *fans_count;
/**昵称*/
@property (nonatomic, copy) NSString *screen_name;


@end

NS_ASSUME_NONNULL_END
