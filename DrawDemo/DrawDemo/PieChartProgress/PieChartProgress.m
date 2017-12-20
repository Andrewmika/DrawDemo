//
//  PieChartProgress.m
//  stlc
//
//  Created by Andrew Shen on 2017/8/7.
//  Copyright © 2017年 杭州溢鼎科技有限公司. All rights reserved.
//

#import "PieChartProgress.h"
#import "PieChartProgressLayer.h"

@interface PieChartProgress ()
@property (nonatomic, strong)  PieChartProgressLayer  *chartLayer; // <##>

@end

@implementation PieChartProgress

+ (Class)class {
    return [PieChartProgressLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        [self.layer addSublayer:self.chartLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self.layer addSublayer:self.chartLayer];
        [self.chartLayer setFrame:self.bounds];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled = NO;
        [self.layer addSublayer:self.chartLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.chartLayer setFrame:self.bounds];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.chartLayer.progressColor = progressColor;
}
#pragma mark - Interface

- (void)configPercentage:(CGFloat)percentage {
    [self.chartLayer configPercentage:percentage];
}

#pragma mark - Init

- (PieChartProgressLayer *)chartLayer {
    if (!_chartLayer) {
        _chartLayer = [PieChartProgressLayer layer];
        _chartLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _chartLayer;
}
@end
