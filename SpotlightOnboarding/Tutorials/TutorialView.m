//
//  TutorialView.m
//  DoggyDating
//
//  Created by Ritu Raj on 20/12/16.
//  Copyright © 2016 Acknown Technologies. All rights reserved.
//

#import "TutorialView.h"

@implementation TutorialView

//CGMutablePathRef previousMutablePath, previousFocusPath;

int count;

#define CIRCLE_RADIUS CGRectGetWidth(self.rectToSpotlight)/2+10

CAShapeLayer *focusLayer;

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
//    self.alpha = 0.5;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.maskLayer = [CAShapeLayer layer];
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.rectToSpotlight), CGRectGetMidY(self.rectToSpotlight));
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:CIRCLE_RADIUS startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [circlePath setUsesEvenOddFillRule:YES];
    
    CGPathRef cgPath = circlePath.CGPath;
    
    CGMutablePathRef  mutablePath = CGPathCreateMutableCopy(cgPath);
    
    CGPathAddRect(mutablePath, nil, self.bounds);
    
    self.maskLayer.path = mutablePath;
    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    // Release the path since it's not covered by ARC.
    CGPathRelease(mutablePath);
    
    self.layer.mask = self.maskLayer;
    self.clipsToBounds = YES;
    
    if (focusLayer) {
        [focusLayer removeFromSuperlayer];
    }
    
    focusLayer = [CAShapeLayer layer];
    
    UIBezierPath *focusPath = [self createPathFromPoint:[self.spotlightStartPoint CGPointValue] onRect:self.rectToSpotlight];
    
    [focusLayer setPath:focusPath.CGPath];
    
    [focusLayer setFillColor:[UIColor lightGrayColor].CGColor];
    
    [self.layer insertSublayer:focusLayer atIndex:0];
    
}

//-(void)layoutSubviews{
//    
//    [super layoutSubviews];
//    
//    //    self.alpha = 0.5;
//    
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    
//    self.maskLayer = [CAShapeLayer layer];
//    
//    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.rectToSpotlight), CGRectGetMidY(self.rectToSpotlight));
//    
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:CIRCLE_RADIUS startAngle:0 endAngle:2*M_PI clockwise:YES];
//    
//    [circlePath setUsesEvenOddFillRule:YES];
//    
//    CGPathRef cgPath = circlePath.CGPath;
//    
//    CGMutablePathRef  mutablePath = CGPathCreateMutableCopy(cgPath);
//    
//    CGPathAddRect(mutablePath, nil, self.bounds);
//    
//    self.maskLayer.path = mutablePath;
//    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
//    
//    if (previousMutablePath!=nil) {
//        //        [self.maskLayer setPath:mutablePath];
//        
//        CABasicAnimation *trans = [CABasicAnimation animationWithKeyPath:@"path"];
//        trans.duration = 1;
//        trans.fromValue = (__bridge id _Nullable)(previousMutablePath);
//        trans.toValue = (__bridge id _Nullable)(mutablePath);
//        [trans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//        [trans setFillMode:kCAFillModeBoth];
//        [trans setRemovedOnCompletion:NO];
//        [self.maskLayer addAnimation:trans forKey:@"path"];
//        
//    }
//    
//    // Release the path since it's not covered by ARC.
//    //    CGPathRelease(mutablePath);
//    
//    self.layer.mask = self.maskLayer;
//    self.clipsToBounds = YES;
//    
//    
//    
//    if (!focusLayer) {
//        //        [focusLayer removeFromSuperlayer];
//        focusLayer = [CAShapeLayer layer];
//    }
//    
//    
//    UIBezierPath *focusPath = [self createPathFromPoint:[self.spotlightStartPoint CGPointValue] onRect:self.rectToSpotlight];
//    
//    CGMutablePathRef fPath = CGPathCreateMutableCopy(focusPath.CGPath);
//    
//    [focusLayer setPath:fPath];
//    
//    if (previousFocusPath!=nil) {
//        //        [self.maskLayer setPath:mutablePath];
//        
//        CABasicAnimation *trans1 = [CABasicAnimation animationWithKeyPath:@"focus_path"];
//        trans1.duration = 1;
//        trans1.fromValue = (__bridge id _Nullable)(previousFocusPath);
//        trans1.toValue = (__bridge id _Nullable)(fPath);
//        [trans1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//        [trans1 setFillMode:kCAFillModeBoth];
//        [trans1 setRemovedOnCompletion:NO];
//        [focusLayer addAnimation:trans1 forKey:@"focus_path"];
//        
//    }
//    
//    [focusLayer setFillColor:[UIColor grayColor].CGColor];
//    
//    [self.layer insertSublayer:focusLayer atIndex:0];
//    
//    
//    previousMutablePath = mutablePath;
//    previousFocusPath = fPath;
//}

-(UIBezierPath *)createPathFromPoint:(CGPoint)point onRect:(CGRect)spotlightRect {
    
    NSArray *pointsArr = [self getTangentialPointsFromPoint:point onRect:spotlightRect];
    
    UIBezierPath *focusPath = [UIBezierPath bezierPath];
    [focusPath moveToPoint:point];
    
    for (id obj in pointsArr) {
        
        [focusPath addLineToPoint:[obj CGPointValue]];
    }
    
    [focusPath closePath];
    
    return focusPath;
    
}

-(NSArray*)getTangentialPointsFromPoint:(CGPoint)point onRect:(CGRect)spotlightRect {
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(spotlightRect), CGRectGetMidY(spotlightRect));
    float radius = CIRCLE_RADIUS;
    CGPoint outerPoint = point;
    
    float dx = centerPoint.x - outerPoint.x;
    float dy = centerPoint.y - outerPoint.y;
    float dd = sqrt(dx*dx + dy*dy);
    float a = asinf(radius / dd);
    float b = atan2f(dy, dx);
    float t1 = b - a;
    CGPoint tangentPoint1 = CGPointMake(centerPoint.x + radius*sinf(t1),
                                        centerPoint.y + radius*-cosf(t1));
    
    float t2 = b + a;
    CGPoint tangentPoint2 = CGPointMake(centerPoint.x + radius*-sinf(t2),
                                        centerPoint.y + radius*cosf(t2));
    
    NSArray *points = @[
                        [NSValue valueWithCGPoint:tangentPoint1],
                        [NSValue valueWithCGPoint:tangentPoint2]
                        ];
    return points;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
