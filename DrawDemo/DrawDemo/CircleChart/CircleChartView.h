//
//  AccountTotalAssetsChartView.h
//  stlc
//
//  Created by Andrew Shen on 2017/4/11.
//  Copyright © 2017年 杭州溢鼎科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleChartView : UIView

- (void)configAmountArray:(NSArray<NSNumber *> *)amountArray totalAssets:(CGFloat)totalAssets colorsArray:(NSArray<UIColor *> *)colorsArray lineWidth:(CGFloat)lineWidth;

- (void)updateAnimation;

@end
