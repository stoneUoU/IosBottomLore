//
//  StToastAnimation.m
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "StToastAnimation.h"

@interface StToastAnimation ()

@end

static NSString *const kScaleKeyPath = @"transform.scale";
static NSString *const kOpacityKeyPath = @"opacity";

@implementation StToastAnimation

//+ (instancetype)sharedAnimation
//{
//    static id instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//        instance = [[self alloc] init];
//    });
//
//    return instance;
//}

+ (instancetype)toastAnimation
{
    return [[self alloc] init];
}

- (CAAnimation *)animationWithType:(StToastAnimationType)animationType
{
    CABasicAnimation *forwardAnimation = nil;
    CABasicAnimation *backwardAnimation = nil;

    switch (animationType)
    {
        case StToastAnimationTypeAlpha:
            forwardAnimation = [CABasicAnimation animationWithKeyPath:kOpacityKeyPath];
            backwardAnimation = [CABasicAnimation animationWithKeyPath:kOpacityKeyPath];

            forwardAnimation.fromValue = @0.0;
            forwardAnimation.toValue = @1.0;
            backwardAnimation.fromValue = @1.0;
            backwardAnimation.toValue = @0.0;
            break;

        case StToastAnimationTypeScale:
            forwardAnimation = [CABasicAnimation animationWithKeyPath:kScaleKeyPath];
            forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
            backwardAnimation = [CABasicAnimation animationWithKeyPath:kScaleKeyPath];
            backwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
            forwardAnimation.fromValue = @0.0;
            forwardAnimation.toValue = @1.0;
            backwardAnimation.fromValue = @1.0;
            backwardAnimation.toValue = @0.0;

            break;

        case StToastAnimationTypePositionLeftToRight:

            forwardAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
            backwardAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
            forwardAnimation.fromValue = @(-CGRectGetWidth([UIScreen mainScreen].bounds));
            forwardAnimation.toValue = @(CGRectGetWidth([UIScreen mainScreen].bounds)/2);
            backwardAnimation.fromValue = @(CGRectGetWidth([UIScreen mainScreen].bounds)/2);
            backwardAnimation.toValue = @(CGRectGetWidth([UIScreen mainScreen].bounds) * 2);

            break;

        default:
            break;
    }

    forwardAnimation.duration = self.forwardAnimationDuration;
    backwardAnimation.duration = self.backwardAnimationDuration;
    backwardAnimation.beginTime = forwardAnimation.duration + self.waitAnimationDuration;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[forwardAnimation,backwardAnimation];
    animationGroup.duration = self.forwardAnimationDuration + self.backwardAnimationDuration + self.waitAnimationDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;

    return animationGroup;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(toastAnimationDidStop:finished:)])
    {
        [self.delegate toastAnimationDidStop:anim finished:flag];
    }
}

@end

