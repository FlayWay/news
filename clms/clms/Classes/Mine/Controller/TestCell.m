//
//  TestCell.m
//  clms
//
//  Created by ljkj on 2018/10/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "TestCell.h"
#import <UIImageView+WebCache.h>


@interface TestCell ()

@property (nonatomic, strong) UIImageView *bImage;
@property (nonatomic, strong) UILabel *nameLab;

@end

@implementation TestCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bImage = [[UIImageView alloc]init];
        self.bImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.bImage];

        self.nameLab = [[UILabel alloc]init];
        self.nameLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.bImage.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20);
    self.nameLab.frame = CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20);
}

- (void)setShop:(LJShopModel *)shop {
    
    [self.bImage sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = shop.price;
}

@end
