//
//  NSTimer+Pluto.h
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Pluto)
/**
 *  创建一个不会造成循环引用的循环执行的Timer
 */
+ (instancetype)stScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo;
@end
