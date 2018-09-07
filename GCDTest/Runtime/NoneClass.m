//
//  NoneClass.m
//  GCDTest
//
//  Created by test on 2018/6/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "NoneClass.h"

@implementation NoneClass
+(void)load
{
    //STLog(@"NoneClass _cmd: %@", NSStringFromSelector(_cmd));
}

- (void) noneClassMethod:(NSString *)paras andStr:(NSString *)str
{
    STLog(@"_cmd: %@  =============  携带第一个参数   %@      携带第二个参数  %@", NSStringFromSelector(_cmd),paras,str);
}

@end
