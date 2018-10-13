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
    
    
    
}

@end
