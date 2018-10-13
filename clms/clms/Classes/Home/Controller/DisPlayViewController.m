//
//  DisPlayViewController.m
//  clms
//
//  Created by ljkj on 2018/9/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "DisPlayViewController.h"
#import "config.h"
#import "LJFlowLayout.h"
#import "TableViewController.h"

@interface DisPlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

/// 标题宽度
@property (nonatomic, assign) CGFloat titleWidth;
/// 标题间距
@property (nonatomic, assign) CGFloat titleMargin;
/// 标题宽度数组
@property (nonatomic, strong) NSMutableArray *titleWidths;
/// 标题控件数组
@property (nonatomic, strong) NSMutableArray *titleLabels;
/// 标题scrollview
@property (nonatomic, strong) UIScrollView *titleScrollView;
/// 整体内容view 包括标题视图和滚动视图
@property (nonatomic, strong) UIView *contentView;
/// 当前选中标题
@property (nonatomic, assign) NSInteger selectedIndex;
/// 下表视图
@property (nonatomic, strong) UIView *underLine;
/// 记录下表视图位置
@property (nonatomic, assign) CGFloat lastOffsetX;
/// 设置蒙版阴影
@property (nonatomic, strong) UIView *coverView;
/// 内容滚动视图
@property (nonatomic, strong) UICollectionView *contentScrollView;
/// 点击标题标记
@property (nonatomic, assign) BOOL isClickTitle;
/// 初始化标记
@property (nonatomic, assign) BOOL isInitial;


/**
 开始颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat startR;

@property (nonatomic, assign) CGFloat startG;

@property (nonatomic, assign) CGFloat startB;

/**
 完成颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat endR;

@property (nonatomic, assign) CGFloat endG;

@property (nonatomic, assign) CGFloat endB;

@end

@implementation DisPlayViewController

- (NSMutableArray *)titleWidths {
    if (!_titleWidths) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIScrollView *)titleScrollView {
    
    if (!_titleScrollView) {
        
        UIScrollView *titleScrollView = [[UIScrollView alloc]init];
        titleScrollView.scrollsToTop = NO;
        titleScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        [self.contentView addSubview:titleScrollView];
        _titleScrollView = titleScrollView;
    }
    return _titleScrollView;
}

- (UIView *)underLine {
    
    if (_underLine == nil) {
        
        UIView *underLine = [[UIView alloc]init];
        underLine.backgroundColor = [UIColor blueColor];
        [self.titleScrollView addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

- (UIView *)coverView {
    if (!_coverView) {
        
        UIView *coverView = [[UIView alloc]init];
        coverView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        coverView.layer.cornerRadius = 10;
        [self.titleScrollView insertSubview:coverView atIndex:0];
        _coverView = coverView;
    }
    return _coverView;
}

- (UIView *)contentView {
    
    if (!_contentView) {
        
        UIView *contentView = [[UIView alloc]init];
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (UICollectionView *)contentScrollView {
    
    if (!_contentScrollView) {
        
        LJFlowLayout *layout = [[LJFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentScrollView = collectionView;
        
        // 设置contentView内容
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.dataSource = self;
        _contentScrollView.scrollsToTop = NO;
        
        [_contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _contentScrollView.backgroundColor = self.view.backgroundColor;
        [self.contentView insertSubview:collectionView belowSubview:self.titleScrollView];
    }
    
    return _contentScrollView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
     
        [self setupTitleWidth];
        [self setupAllTitles];
        [self setupStartColor];
        [self setupEndColor];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 设置所有标题
 */
- (void)setupAllTitles {
    
    // 遍历所有的子控制器
    NSUInteger count = self.childViewControllers.count;
    
    // 设定标题frame
    CGFloat labelW = self.titleWidth;
    CGFloat labelH = YZTitleScrollViewH;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i=0; i<count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        UILabel *lab = [[UILabel alloc]init];
        lab.userInteractionEnabled = YES;
        lab.tag = i;
        lab.textColor = UIColor.darkGrayColor;
        lab.font = [UIFont systemFontOfSize:15];
        lab.text = vc.title;
        labelW = [self.titleWidths[i] floatValue];
        UILabel *lastLab = self.titleLabels.lastObject;
        labelX = self.titleMargin + CGRectGetMaxX(lastLab.frame);
        lab.frame = CGRectMake(labelX, labelY, labelW, YZTitleScrollViewH);
        [self.titleScrollView addSubview:lab];
        [self.titleLabels addObject:lab];
        
        // 监听事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [lab addGestureRecognizer:tap];
        if (i == 0) {
            [self titleClick:tap];
        }
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    
    
}

#pragma mark -- 计算标题宽度
- (void)setupTitleWidth {

    // 判断能否占用整个屏幕
    NSUInteger count = self.childViewControllers.count;
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    CGFloat totalWidth = 0;
    
    // 计算所有标题宽度
    for (NSString *title in titles) {
        
        CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        CGFloat width = rect.size.width;
        totalWidth += width;
        // 宽度添加到数组中
        [self.titleWidths addObject:@(width)];
    }
    
    if (totalWidth > UIScreen.mainScreen.bounds.size.width) {
        
        _titleMargin = margin;
        self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
        return;
    }
    
    CGFloat titleMargin = (UIScreen.mainScreen.bounds.size.width - totalWidth) / (count + 1);
    
    _titleMargin = titleMargin < margin ? margin : titleMargin;
    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    _isInitial = YES;
    if (self.contentView.frame.size.height == 0) {
        
        self.contentView.frame = CGRectMake(0, NavBarHeight, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - NavBarHeight);
    }
    // 顶部view的frame
    self.titleScrollView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, YZTitleScrollViewH);
    
    // contentScrollView的frame
    CGFloat contentScrollY = CGRectGetMaxY(self.titleScrollView.frame);
    CGFloat contentScrollH = _contentView.height - contentScrollY;
    self.contentScrollView.frame = CGRectMake(0, contentScrollY, self.view.width, contentScrollH);
    
}

#pragma mark --- title点击事件
- (void)titleClick:(UITapGestureRecognizer *)tap {
    
    _isClickTitle = YES;
    // 获取label
    UILabel *label = (UILabel *)tap.view;
    // 获取tag
    NSInteger i = label.tag;
    [self selectedLabel:label];

    // 滚动视图
    CGFloat offsetX = i * UIScreen.mainScreen.bounds.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
    _selectedIndex = i;
    // 记录下表线位置
    _lastOffsetX = offsetX;
    _isClickTitle = NO;
    
}

#pragma mark --- 设置选中的label
- (void)selectedLabel:(UILabel *)label {
    
    
    for (UILabel *lab in self.titleLabels) {
        
        if (lab == label) {
            continue;
        }
        lab.textColor = [UIColor darkGrayColor];
    }
    
    label.textColor = [UIColor redColor];
    
    // 设置选中标题居中
    [self setLabelTitleCenter:label];
    
    // 设置下标线
    [self setupUnderLine:label];
    
    // 设置阴影
//    [self setupCoverView:label];
    
    
}

#pragma mark -- 设置标题居中
- (void)setLabelTitleCenter:(UILabel *)label {
    
    // 设置偏移量
    CGFloat offsetX = label.center.x - UIScreen.mainScreen.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 计算最大的标题视图滚动区域
    CGFloat maxOffSetX = self.titleScrollView.contentSize.width - UIScreen.mainScreen.bounds.size.width + _titleMargin;
    
    if (maxOffSetX < 0) {
        maxOffSetX = 0;
    }
    if (offsetX > maxOffSetX) {
        offsetX = maxOffSetX;
    }
    // 滚动
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
}

#pragma mark --- 设置下标线
- (void)setupUnderLine:(UILabel *)label {
    
    // 获取文字尺寸
    CGFloat labelW = [self.titleWidths[label.tag] floatValue];
    CGFloat underLineH = YZUnderLineH;
    self.underLine.y = label.height - YZUnderLineH;
    self.underLine.height = underLineH;
    
    // 起始位置 无动画
    if (self.underLine.x == 0) {
        
        self.underLine.width = labelW;
        self.underLine.centerX = label.centerX;
        return;
    }
    
    // 点击滑动动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.width = labelW;
        self.underLine.centerX = label.centerX;
    }];
}

#pragma mark --- 设置蒙版阴影
- (void)setupCoverView:(UILabel *)label {
    
    // 获取文字尺寸
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    
    CGFloat border = 7;
    CGFloat coverH = rect.size.height + 2 * border;
    CGFloat coverW = rect.size.width + 2 * border;
    
    self.coverView.y = (label.height - coverH) * 0.5;
    self.coverView.height = coverH;
    
    // 起始位置 无动画
    if (self.coverView.x == 0) {
        
        self.coverView.width = coverW;
        self.coverView.centerX = label.centerX;
        return;
    }
    
    // 点击滑动动画
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.width = coverW;
        self.coverView.centerX = label.centerX;
    }];
}

#pragma mark ---UICollectionViewDatasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // 移除子控件
//    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加控制器
    TableViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0,0, self.contentScrollView.width, self.contentScrollView.height);
    vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.titleScrollView.frame)+NavBarHeight, 0);
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.childViewControllers.count;
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    NSInteger offsetXInt = offsetX;
    NSInteger screenWidthInt = screenWidth;
    NSInteger extre = offsetXInt % screenWidthInt;
    
    if (extre > 0.5 * screenWidth) {
        
        // 向右偏移
        offsetXInt = offsetX + screenWidth - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
    }else if (extre < 0.5 * screenWidth && extre > 0) {
        
        // 向左偏移
        offsetX = offsetX - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
    }
    
    // 标题偏移 取小标
    NSInteger i = offsetX / screenWidth;
    // 选中标题
    [self selectedLabel:self.titleLabels[i]];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    // 获取左边下标
    NSInteger leftIndex = offsetX / screenWidth;
    // 左边label
    UILabel *leftLabel = self.titleLabels[leftIndex];
    // 右边下标
    NSInteger rightIndex = leftIndex + 1;
    // 右边label
    UILabel *rightLabel = nil;
    if (rightIndex < self.titleLabels.count) {
        
        rightLabel = self.titleLabels[rightIndex];
    }
    // 字体放大
//    [self setUpTitleScaleWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 线条偏移
    [self setUpUnderLineOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    [self setUpTitleColorGradientWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 记录上一次的偏移量
    _lastOffsetX = offsetX;
}

#pragma mark --- 字体变化
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    // 获取右边缩放
    CGFloat rightScale = offsetX / screenWidth - leftLabel.tag;
    CGFloat leftScale = 1 - rightScale;
    CGFloat scaleTransform = YZTitleTransformScale;
    scaleTransform -= 1;
    
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform + 1);
    
}

// 设置下标偏移
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
    if (_isClickTitle == YES) {
        
        return;
    }
    
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    // 获取两个标题
    CGFloat centerDelta = rightLabel.x - leftLabel.x;
    // 获取标题宽度差
    CGFloat widthDelta = [self.titleWidths[rightLabel.tag] floatValue] - [self.titleWidths[leftLabel.tag] floatValue];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    // 计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / screenWidth;
    // 宽度递增变量
    CGFloat underLineWidth = offsetDelta * widthDelta / screenWidth;
    self.underLine.x += underLineTransformX;
    self.underLine.width +=  underLineWidth;
    
}

/// 设置标题颜色渐变
- (void)setUpTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
    NSInteger screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat rightScale = offsetX / screenWidth - leftLabel.tag;
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat r = _endR - _startR;
    CGFloat g = _endG - _startG;
    CGFloat b = _endB - _startB;
    
    // rightColor
    // 1 0 0
    UIColor *rightColor = [UIColor colorWithRed:_startR + r * rightScale green:_startG + g * rightScale blue:_startB + b * rightScale alpha:1];
    
    // 0.3 0 0
    // 1 -> 0.3
    // leftColor
    UIColor *leftColor = [UIColor colorWithRed:_startR +  r * leftScale  green:_startG +  g * leftScale  blue:_startB +  b * leftScale alpha:1];
    
    // 右边颜色
    rightLabel.textColor = rightColor;
    
    // 左边颜色
    leftLabel.textColor = leftColor;
    
    
    
}

- (void)setupStartColor
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:[UIColor darkGrayColor]];
    
    _startR = components[0];
    _startG = components[1];
    _startB = components[2];
}

- (void)setupEndColor
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:[UIColor redColor]];
    
    _endR = components[0];
    _endG = components[1];
    _endB = components[2];
}

/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

@end
