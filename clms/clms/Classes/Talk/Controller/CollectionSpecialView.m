
//
//  CollectionSpecialView.m
//  clms
//
//  Created by ljkj on 2018/10/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "CollectionSpecialView.h"

@interface CollectionSpecialView ()

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *nameDetailLab;


@end

@implementation CollectionSpecialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor darkGrayColor];
        
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.text = @"我的栏目";
        //        self.nameLab.backgroundColor = [UIColor redColor];
        [self addSubview:self.nameLab];
        
        self.nameDetailLab = [[UILabel alloc]init];
        //        self.nameDetailLab.backgroundColor = [UIColor brownColor];
        self.nameDetailLab.text = @"点击进入栏目";
        self.nameDetailLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameDetailLab];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(10, 10, 100, self.bounds.size.height-20);
    
    self.nameDetailLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame), 10, 100, self.bounds.size.height -20);
    
}

@end
