//
//  UIButton+STExtra.h
//  GCDTest
//
//  Created by test on 2018/6/14.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^STBtnActCallBack)(UIButton *button);

@interface UIButton (STExtraBtn)


/**
 *  @brief replace the method 'addTarget:forControlEvents:'
 */
- (void)addStCallBackAct:(STBtnActCallBack)callBack forControlEvents:(UIControlEvents)controlEvents;

/**
 *  @brief replace the method 'addTarget:forControlEvents:UIControlEventTouchUpInside'
 *  the property 'alpha' being 0.5 while 'UIControlEventTouchUpInside'
 */
- (void)addStClickAct:(STBtnActCallBack)callBack;

- (void)setStCallBack:(STBtnActCallBack)callBack;
- (STBtnActCallBack)getMHCallBack;

@end
