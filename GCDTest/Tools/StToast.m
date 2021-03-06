//
//  StToast.m
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "StToast.h"

@interface StToast () <StToastAnimationDelegate>

@property (nonatomic, strong) StToastAnimation *toastAnimation;

@end

static CFTimeInterval const kDefaultForwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultBackwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultWaitAnimationDuration = 1.5;

static CGFloat const kDefaultTopMargin = 50.0;
static CGFloat const kDefaultBottomMargin = 50.0;
static CGFloat const kDefalultTextInset = 10.0;

@implementation StToast

+ (instancetype)toastWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

+ (instancetype)toastWithText:(NSString *)text animationType:(StToastAnimationType)animationType
{
    return [[self alloc] initWithText:text animationType:animationType];
}

- (instancetype)initWithText:(NSString *)text
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        self.text = text;
        [self sizeToFit];
        _animationType = StToastAnimationTypeAlpha;
        _toastAnimation = [StToastAnimation toastAnimation];
        _toastAnimation.delegate = self;
    }

    return self;
}

- (instancetype)initWithText:(NSString *)text animationType:(StToastAnimationType)animationType
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        self.text = text;
        [self sizeToFit];
        _animationType = animationType;
        _toastAnimation = [StToastAnimation toastAnimation];
        _toastAnimation.delegate = self;
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration;
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration;
        self.waitAnimationDuration = kDefaultWaitAnimationDuration;

        self.textInsets = UIEdgeInsetsMake(kDefalultTextInset, kDefalultTextInset, kDefalultTextInset, kDefalultTextInset);
        self.maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20.0;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14.0];
    }

    return self;
}

#pragma mark - Show Method

- (void)show
{
    [self showInView:[self currentWindow]];
}

- (void)showWithType:(StToastShowType)type
{
    [self showInView:[self currentWindow] showType:type];
}

- (void)showInView:(UIView *)view
{
    [self addAnimationGroup];
    CGPoint point = view.center;
    point.y = CGRectGetHeight(view.bounds)- kDefaultBottomMargin;
    self.center = point;
    [view addSubview:self];
}

- (void)showInView:(UIView *)view showType:(StToastShowType)type
{
    [self addAnimationGroup];

    CGPoint point = view.center;
    switch (type) {
        case StToastShowTypeTop:
            point.y = kDefaultTopMargin;
            break;

        case StToastShowTypeBottom:
            point.y = CGRectGetHeight(view.bounds)- kDefaultBottomMargin;
            break;

        default:
            break;
    }
    self.center = point;
    [view addSubview:self];
}

#pragma mark - Window

- (UIWindow *)currentWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tempWindow in windows)
        {
            if(tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }

    return window;
}

#pragma mark - Animation

- (void)addAnimationGroup
{
    self.toastAnimation.forwardAnimationDuration = self.forwardAnimationDuration;
    self.toastAnimation.backwardAnimationDuration = self.backwardAnimationDuration;
    self.toastAnimation.waitAnimationDuration = self.waitAnimationDuration;
    [self.layer addAnimation:[self.toastAnimation animationWithType:_animationType] forKey:@"animation"];
}

#pragma mark - StToastAnimationDelegate

- (void)toastAnimationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag)
    {
        [self.layer removeAllAnimations];
        [self removeFromSuperview];
    }
}

#pragma mark - Text Configurate

- (void)sizeToFit
{
    [super sizeToFit];
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(self.bounds) + self.textInsets.left + self.textInsets.right;
    frame.size.width = width > self.maxWidth? self.maxWidth : width;
    frame.size.height = CGRectGetHeight(self.bounds) + self.textInsets.top + self.textInsets.bottom;
    self.frame = frame;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right,
                                                             CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;

    return bounds;
}

@end
