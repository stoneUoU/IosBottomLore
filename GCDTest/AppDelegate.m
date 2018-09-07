//
//  AppDelegate.m
//  GCDTest
//
//  Created by test on 2018/6/12.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AppDelegate.h"
#import "GCDTestVC.h"
#import "NSOperationQueueVC.h"
#import "MsgSendVC.h"
#import "ReSolveMsgVC.h"
#import "SingleClassVC.h"
#import "TestPrintVC.h"
#import "MethodExVC.h"
#import "RunLoopVC.h"
#import "MultPicApplyToTbVC.h"
#import "NextVC.h"  //测试线程
#import "ReGCDVC.h"
#import "ReNSOperationVC.h"
#import "NetCheckVC.h"
#import "KVOVC.h"
#import "ReviewRunLoopVC.h"
#import "ReViewKVOVC.h"
#import "AgainGCDVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    [self.window.layer addAnimation:anim forKey:nil];
    [self.window makeKeyAndVisible];
    // afn网络中间类
    [NetCheckTools sharedIns];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[AgainGCDVC alloc] init]];

    //关闭设置为NO, 默认值为NO.  键盘监听
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

//打卡,今日复习了：
//ios runtime 技术：
//为类动态添加成员变量（objc_setAssociatedObject  objc_getAssociatedObject）
//为类动态添加类方法、成员方法 (resolveInstanceMethod resolveClassMethod)
//class_addMethod(self, sel, (IMP)comeMethod, "v@:@");     void comeMethod(id self, SEL _cmd, NSString *vals,NSString *otherVals) {};
//class_addMethod(objc_getMetaClass("Person"), sel, (IMP)funcArchieve, "v@:@:@");     void funcArchieve(id self, SEL _cmd, NSString *vals,NSString *otherVals,NSInteger ids){};
//完全了解ios的消息转发机制（1.动态方法解析，2.备用接收者，3.完整转发，4.未找到方法实现）
//1.resolveInstanceMethod resolveClassMethod
//2.forwardingTargetForSelector
//3.methodSignatureForSelector  forwardInvocation   invokeWithTarget
//方法交换
//class_getClassMethod   class_getInstanceMethod  method_exchangeImplementations
//
//ios单例的实现:
//static SingleClass *_shareIns = nil;
//static dispatch_once_t onceToken;
//dispatch_once(&onceToken, ^{
//    _shareIns = [[super allocWithZone:NULL] init];
//});
//allocWithZone:(struct _NSZone *)zone
//copyWithZone:(struct _NSZone *)zone
