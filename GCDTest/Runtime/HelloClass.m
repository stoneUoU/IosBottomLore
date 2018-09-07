//
//  HelloClass.m
//  GCDTest
//
//  Created by test on 2018/6/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HelloClass.h"
#import <objc/message.h>
#import "NoneClass.h"
#import "SecondClass.h"
@implementation HelloClass
+(void)load
{
    //STLog(@"HelloClass _cmd: %@", NSStringFromSelector(_cmd));
}
- (instancetype)init
{
    self = [super init];
    return self;
}

void functionForMethod(id self, SEL _cmd)
{
    NSLog(@"我被转发到这个方法了哈 ========= %@",NSStringFromSelector(_cmd));
}
void selfComeMethod(id self, SEL _cmd,NSString *paras)
{
    STLog(@"我被转发到这个方法了哈 ========= %@,携带参数 =========== %@",NSStringFromSelector(_cmd),paras);
}

Class functionForClassMethod(id self, SEL _cmd)
{
    NSLog(@"Hi!");
    return [HelloClass class];
}
#pragma mark - 1、动态方法解析
+ (BOOL)resolveClassMethod:(SEL)sel
{
    STLog(@"resolveClassMethod");
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"hi"])
    {
        Class metaClass = objc_getMetaClass("HelloClass");
        class_addMethod(metaClass, @selector(hi), (IMP)functionForClassMethod, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    STLog(@"resolveInstanceMethod");
    NSString *selStr = NSStringFromSelector(sel);
    if([selStr isEqualToString:@"testV:"]){
        class_addMethod(self, @selector(testV:), (IMP)selfComeMethod, "v@:");
        return YES;
    }else if ([selStr isEqualToString:@"hello:"]){
        class_addMethod(self, @selector(hello:), (IMP)functionForMethod, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

//系统给了个将这个SEL转给其他对象的机会。返回参数是一个对象，如果这个对象非nil、非self的话，系统会将运行的消息转发给这个对象执行。否则，继续查找其他流程。
-(id)forwardingTargetForSelector:(SEL)aSelector{
    STLog(@"forwardingTargetForSelector");
    NoneClass *none = [[NoneClass alloc] init];
    if ([none respondsToSelector: aSelector]) {
        return none;
    }
    return [super forwardingTargetForSelector:aSelector];
}
//这个函数和后面的forwardInvocation:是最后一个寻找IML的机会。这个函数让重载方有机会抛出一个函数的签名，再由后面的forwardInvocation:去执行
//#pragma mark - 3、完整消息转发
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    SecondClass *secondClass = [[SecondClass alloc] init];
    if ([secondClass respondsToSelector: aSelector]) {
        signature = [secondClass methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //拿到函数名
    NSString *selStr = NSStringFromSelector([anInvocation selector]);
    STLog(@"%@",selStr);
    SecondClass *secondClass = [[SecondClass alloc] init];
    if ([secondClass respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:secondClass];
    }
}
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    
}
@end
