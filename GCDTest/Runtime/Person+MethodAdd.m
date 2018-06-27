//
//  Person+MethodAdd.m
//  GCDTest
//
//  Created by test on 2018/6/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "Person+MethodAdd.h"

@implementation Person (MethodAdd)
// 没有返回值,也没有参数   动态给类添加方法
// void,(id,SEL)
void comeMethod(id self, SEL _cmd, NSString *vals,NSString *otherVals) {

    NSLog(@"去了哪个城市地点玩耍%@--------%@", vals,otherVals);

}
// 任何方法默认都有两个隐式参数,self,_cmd（_cmd代表方法编号，打印结果为当前执行的方法名）
// 什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法,进行处理
// 作用:动态添加方法,处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // [NSStringFromSelector(sel) isEqualToString:@"eat"];
    if (sel == NSSelectorFromString(@"toDo:")) {
        // eat
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名
        // type: 方法类型：void用v来表示，id参数用@来表示，SEL用:来表示
        //aaa不会生成方法列表
        class_addMethod(self, sel, (IMP)comeMethod, "v@:@");

        return YES;
    }

    return [super resolveInstanceMethod:sel];

}
@end
