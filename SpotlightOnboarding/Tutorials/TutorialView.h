//
//  TutorialView.h
//  DoggyDating
//
//  Created by Ritu Raj on 20/12/16.
//  Copyright © 2016 Acknown Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialView : UIView

@property(nonatomic) CGRect rectToSpotlight;
@property(strong, nonatomic)CAShapeLayer *maskLayer;
@property(strong, nonatomic)NSValue *spotlightStartPoint;

@end
