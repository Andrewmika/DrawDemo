//
//  PieChartProgress.h
//  stlc
//
//  Created by Andrew Shen on 2017/8/7.
//  Copyright © 2017年 杭州溢鼎科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartProgress : UIView
@property (nonatomic, strong)  UIColor  *progressColor; // <##>

- (void)configPercentage:(CGFloat)percentage;

@end
