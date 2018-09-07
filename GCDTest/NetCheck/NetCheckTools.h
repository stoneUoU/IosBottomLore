//
//  NetCheckTools.h
//  GCDTest
//
//  Created by test on 2018/6/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetCheckTools : AFHTTPSessionManager
/** 设置全局变量的属性. */
@property (nonatomic, assign)BOOL isNetUseful;

+ (instancetype)sharedIns;
@end
