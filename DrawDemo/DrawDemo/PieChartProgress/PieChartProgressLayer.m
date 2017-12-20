//
//  PieChartProgressLayer.m
//  stlc
//
//  Created by Andrew Shen on 2017/8/7.
//  Copyright © 2017年 杭州溢鼎科技有限公司. All rights reserved.
//

#import "PieChartProgressLayer.h"

@interface PieChartProgressLayer()
@property (nonatomic, assign)  CGFloat  percentage; // <##>
@end
@implementation PieChartProgressLayer

- (void)configPercentage:(CGFloat)percentage {
    
    self.percentage = percentage;
    
    [self setNeedsDisplay];

}

- (void)drawInContext:(CGContextRef)ctx {
    
    [self.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *pathTemp = [UIBezierPath bezierPathWithArcCenter:self.position radius:self.frame.size.width * 0.5 startAngle:0 endAngle:M_PI * 2  clockwise:YES];
    CAShapeLayer *shapeLayerTemp = [self shapeLayerWithStrokeColor:self.progressColor.CGColor fillColor:nil path:pathTemp.CGPath lineWidth:0.5];
    [self addSublayer:shapeLayerTemp];

    if (self.percentage > 0) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:self.position];
        [path addArcWithCenter:self.position radius:self.frame.size.width * 0.5 startAngle:-M_PI_2 endAngle:-M_PI_2 + M_PI * 2 * self.percentage clockwise:YES];
        CAShapeLayer *shapeLayer = [self shapeLayerWithStrokeColor:self.progressColor.CGColor fillColor:self.progressColor.CGColor path:path.CGPath lineWidth:0.5];
        [self addSublayer:shapeLayer];
    }
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
    
}

- (CAShapeLayer *)shapeLayerWithStrokeColor:(CGColorRef)strokeColor fillColor:(CGColorRef)fillColor path:(CGPathRef)path lineWidth:(CGFloat)lineWidth{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path;
    shapeLayer.strokeColor = strokeColor;
    shapeLayer.fillColor = fillColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    
    return shapeLayer;
}

- (UIColor *)progressColor {
    if (!_progressColor) {
        _progressColor = [UIColor cyanColor];
    }
    return _progressColor;
}
@end
