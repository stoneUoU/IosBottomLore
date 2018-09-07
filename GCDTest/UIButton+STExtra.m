//
//  UIButton+STExtra.m
//  GCDTest
//
//  Created by test on 2018/6/14.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "UIButton+STExtra.h"
#import <objc/runtime.h>

@implementation UIButton (STBtnActCallBack)

static STBtnActCallBack _callBack;

- (void)setStCallBack:(STBtnActCallBack)callBack {
    objc_setAssociatedObject(self, &_callBack, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (STBtnActCallBack)getMHCallBack {
    return (STBtnActCallBack)objc_getAssociatedObject(self, &_callBack);
}

@end;


@implementation UIButton (MHExtra)

/**
 *  @brief replace the method 'addTarget:forControlEvents:UIControlEventTouchUpInside'
 *  the property 'alpha' being 0.5 while 'UIControlEventTouchUpInside'
 */
- (void)addStClickAct:(STBtnActCallBack)callBack{
    [self addStCallBackAct:callBack forControlEvents:(UIControlEventTouchUpInside)];
    [self addTarget:self action:@selector(stTouchDownAct:) forControlEvents:(UIControlEventTouchDown)];
    [self addTarget:self action:@selector(stTouchUpAct:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragOutside)];
}

/**
 *  @brief replace the method 'addTarget:forControlEvents:'
 */
- (void)addStCallBackAct:(STBtnActCallBack)callBack forControlEvents:(UIControlEvents)controlEvents{
    [self setStCallBack:callBack];
    [self addTarget:self action:@selector(stBtnAct:) forControlEvents:controlEvents];
}

- (void)stBtnAct:(UIButton *)btn {
    self.getMHCallBack(btn);
}

- (void)stTouchDownAct:(UIButton *)btn {
    btn.enabled = NO;
    btn.alpha = 0.5f;
}

- (void)stTouchUpAct:(UIButton *)btn {
    btn.enabled = YES;
    btn.alpha = 1.0f;
}

@end

