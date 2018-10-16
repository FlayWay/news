//
//  LJMeiRefreshView.m
//  clms
//
//  Created by ljkj on 2018/10/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJMeiRefreshView.h"

@interface LJMeiRefreshView ()

@property (weak, nonatomic) IBOutlet UIImageView *buildingIconView;
@property (weak, nonatomic) IBOutlet UIImageView *earthIconView;
@property (weak, nonatomic) IBOutlet UIImageView *kangarooIconView;

@end

@implementation LJMeiRefreshView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
       
        
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // 房子
    UIImage *bImage1 = [UIImage imageNamed:@"icon_building_loading_1"];
    UIImage *bimage2 = [UIImage imageNamed:@"icon_building_loading_2"];
    self.buildingIconView.animationImages = @[bImage1,bimage2];
    self.buildingIconView.animationDuration = 0.5;
    self.buildingIconView.animationRepeatCount = 0;
    [self.buildingIconView startAnimating];
    
    // 地球
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = @(- 2 * M_PI);
    anim.repeatCount = MAXFLOAT;
    anim.duration = 5;
    [anim setRemovedOnCompletion:false];
    [self.earthIconView.layer addAnimation:anim forKey:nil];
    
    // 袋鼠
    self.kangarooIconView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.kangarooIconView.layer.anchorPoint = CGPointMake(0.5, 1);
    
    CGFloat centerX = self.bounds.size.width * 0.5;
    CGFloat centerY = self.bounds.size.height  - 23;
    self.kangarooIconView.center = CGPointMake(centerX, centerY);
}

- (void)setParentViewHeight:(CGFloat)parentViewHeight {
    
//    _parentViewHeight = parentViewHeight;
    if (parentViewHeight < 23) {
        return;
    }
    
    CGFloat scale;
    
    if (parentViewHeight > 126) {
        scale = 1;
    }else {
        scale = 1 - (126 - parentViewHeight) / (126 -23);
    }
    self.kangarooIconView.transform = CGAffineTransformMakeScale(scale, scale);
    
    
}

@end
