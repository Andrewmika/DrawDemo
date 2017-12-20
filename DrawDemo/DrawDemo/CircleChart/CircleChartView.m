//
//  AccountTotalAssetsChartView.m
//  stlc
//
//  Created by Andrew Shen on 2017/4/11.
//  Copyright © 2017年 杭州溢鼎科技有限公司. All rights reserved.
//

#import "CircleChartView.h"
#import "CircleChartLayer.h"

@interface CircleChartView ()
@property (nonatomic, strong)  CircleChartLayer  *chartLayer; // <##>

@end

@implementation CircleChartView

+ (Class)class {
    return [CircleChartLayer class];
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
    [self.chartLayer setFrame:self.bounds];
    [super layoutSubviews];
}

#pragma mark - Interface

- (void)configAmountArray:(NSArray<NSNumber *> *)amountArray totalAssets:(CGFloat)totalAssets colorsArray:(NSArray<UIColor *> *)colorsArray lineWidth:(CGFloat)lineWidth {
    [self.chartLayer configAmountArray:amountArray totalAssets:totalAssets colorsArray:colorsArray lineWidth:lineWidth];
}

- (void)updateAnimation {
    [self.chartLayer updateAnimation];
}

#pragma mark - Private

#pragma mark - Init
- (CircleChartLayer *)chartLayer {
    if (!_chartLayer) {
        _chartLayer = [CircleChartLayer layer];
        _chartLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _chartLayer;
}

@end
