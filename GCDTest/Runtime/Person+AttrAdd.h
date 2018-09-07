//
//  Person+Extension.h
//  GCDTest
//
//  Created by test on 2018/6/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "Person.h"

@interface Person (AttrAdd)

// 分类中声明属性，只会生成setter和getter方法的声明，不会生成带“_”的成员变量和setter和getter方法的实现
@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *strName;

@end
