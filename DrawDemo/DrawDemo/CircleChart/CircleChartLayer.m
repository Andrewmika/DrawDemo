//
//  ASAssetsChartLayer.m
//  stlc
//
//  Created by Andrew Shen on 2017/4/11.
//  Copyright © 2017年 杭州溢鼎科技有限公司. All rights reserved.
//

#import "CircleChartLayer.h"

static NSString *const kAnimationKey = @"animationKey";

@interface CircleChartLayer ()<CAAnimationDelegate>
@property (nonatomic, copy)  NSArray<NSNumber *>  *amountArray; // <##>
@property (nonatomic, copy)  NSArray<UIColor *>  *colorsArray; // <##>
@property (nonatomic, assign)  CGFloat  totalAssets; // <##>
@property (nonatomic, assign)  CGFloat  lineWidth; // <##>

@property (nonatomic, strong)  NSMutableDictionary  *dictStrokeEndLayer; // <##>
@property (nonatomic)  CGPoint  newPosition; // <##>
@property (nonatomic, assign)  CGFloat  insideR; // <##>

@end

@implementation CircleChartLayer


#pragma mark - Interface

- (void)configAmountArray:(NSArray<NSNumber *> *)amountArray totalAssets:(CGFloat)totalAssets colorsArray:(NSArray<UIColor *> *)colorsArray lineWidth:(CGFloat)lineWidth {
    _amountArray = amountArray; // <##>
    _colorsArray = colorsArray; // <##>
    _totalAssets = totalAssets; // <##>
    _lineWidth = lineWidth; // <##>
    [self setNeedsDisplay];
}

- (void)updateAnimation {
    [self setNeedsDisplay];
    
}

- (void)drawInContext:(CGContextRef)ctx {
    [self removeAllAnimations];
    [self.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    __block CGFloat lastEndAngle = 0;
    [self.amountArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat startAngle = lastEndAngle;
        CGFloat endAngle = M_PI * 2 * (self.totalAssets == 0 ? 1 : (self.amountArray[idx].floatValue / self.totalAssets)) + startAngle;
        lastEndAngle = endAngle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.newPosition radius:self.insideR + self.lineWidth * 0.5 startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        CAShapeLayer *shapeLayer = [self shapeLayerWithStrokeColor:self.colorsArray[idx].CGColor path:path.CGPath lineWidth:self.lineWidth];
        self.dictStrokeEndLayer[@(idx)] = shapeLayer;
        if (self.totalAssets == 0) {
            *stop = YES;
        }
    }];
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
    
    [self beginAnimation];

}

#pragma mark - Private Method
- (void)beginAnimation {
    
    [self startStrokeEndAnimationWithKey:@(0) dictLayer:self.dictStrokeEndLayer percentage:(self.amountArray.firstObject.floatValue / (self.totalAssets))];
}

- (void)startStrokeEndAnimationWithKey:(id)layerKey dictLayer:(NSDictionary *)dict percentage:(CGFloat)percentage {
    
    [self addSublayer:dict[layerKey]];
    [dict[layerKey] addAnimation:[self strokeEndAnimationWithDurationPercentage:percentage keyValue:layerKey] forKey:nil];
}

// 绘制动画动画
- (CABasicAnimation *)strokeEndAnimationWithDurationPercentage:(CGFloat)percentage keyValue:(NSString *)keyValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.0f * percentage;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:keyValue forKey:kAnimationKey];
    animation.delegate = self;
    
    return animation;
}

- (CAShapeLayer *)shapeLayerWithStrokeColor:(CGColorRef)strokeColor path:(CGPathRef)path lineWidth:(CGFloat)lineWidth{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path;
    shapeLayer.strokeColor = strokeColor;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    shapeLayer.shadowColor = [UIColor blackColor].CGColor;
    return shapeLayer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSNumber *keyValue = [anim valueForKey:kAnimationKey];
    NSInteger idx = keyValue.integerValue;
    if (idx < self.amountArray.count - 1) {
        [self startStrokeEndAnimationWithKey:@(idx + 1) dictLayer:self.dictStrokeEndLayer percentage:(self.amountArray[idx + 1].floatValue / (self.totalAssets))];

    }
}


#pragma mark - Init

- (NSMutableDictionary *)dictStrokeEndLayer {
    if (!_dictStrokeEndLayer) {
        _dictStrokeEndLayer = [NSMutableDictionary dictionary];
    }
    return _dictStrokeEndLayer;
}

- (CGPoint)newPosition {
    return _newPosition = CGPointMake(self.position.x, self.position.y);
}

- (CGFloat)insideR {
    return MIN(self.frame.size.width, self.frame.size.height) * 0.5 - self.lineWidth;
}

@end
