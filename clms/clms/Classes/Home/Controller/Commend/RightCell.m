//
//  RightCell.m
//  clms
//
//  Created by ljkj on 2018/11/1.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "RightCell.h"
#import <UIImageView+WebCache.h>

@interface RightCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UIButton *addBtn;


@end

@implementation RightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageV = [[UIImageView alloc]init];
        self.imageV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageV];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.backgroundColor = [UIColor orangeColor];
        self.titleLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLab];
        
        self.subTitleLab = [[UILabel alloc]init];
        self.subTitleLab.backgroundColor = [UIColor brownColor];
        self.subTitleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.subTitleLab];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.backgroundColor = [UIColor grayColor];
        [self.addBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.contentView addSubview:self.addBtn];
        
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat imageVY = 3;
    CGFloat imageVX = 5;
    CGFloat imageVH = self.contentView.height - 2 * imageVY;
    self.imageV.frame = CGRectMake(imageVX, imageVY, imageVH, imageVH);
    
    CGFloat titleLabX = CGRectGetMaxX(self.imageV.frame) + 10;
    CGFloat titleLabY = imageVY;
    CGFloat titleLabW = 100;
    CGFloat titleLabH = 20;
    self.titleLab.frame = CGRectMake(titleLabX, titleLabY, titleLabW, titleLabH);
    
    CGFloat subTitleLabX = titleLabX;
    CGFloat subTitleLabY = CGRectGetMaxY(self.titleLab.frame) + 10;
    CGFloat subTitleLabW = 80;
    CGFloat subTitleLabH = titleLabH;
    self.subTitleLab.frame = CGRectMake(subTitleLabX, subTitleLabY, subTitleLabW, subTitleLabH);
    
    CGFloat addBtnW = 50;
    CGFloat addBtnX = self.contentView.width - 10 - addBtnW;
    CGFloat addBtnH = 30;
    CGFloat addBtnY = (self.contentView.height - addBtnH) / 2;
    self.addBtn.frame = CGRectMake(addBtnX, addBtnY, addBtnW, addBtnH);
}

- (void)setModel:(LJRightModel *)model {
    
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.header]];
    self.titleLab.text = model.screen_name;
    self.subTitleLab.text = [NSString stringWithFormat:@"%@关注",model.fans_count];
    
}

@end
