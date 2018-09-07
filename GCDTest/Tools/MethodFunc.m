//
//  MethodFunc.m
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MethodFunc.h"
//#import "SmsLoginVC.h"
@implementation MethodFunc
+ (void)presentToCommVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC animate:(BOOL )animateBool{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC presentViewController:destVC animated:animateBool completion:nil];
    });
}


+ (void)presentToNaviVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC animate:(BOOL )animateBool{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC presentViewController:[[UINavigationController alloc] initWithRootViewController:destVC] animated:animateBool completion:nil];
    });
}

+ (void)dismissCurrVC:(UIViewController *)selfVC animate:(BOOL )animateBool{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC dismissViewControllerAnimated:animateBool completion:nil];
    });
}

+ (void)pushToNextVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController pushViewController:destVC animated:YES];
    });
}

+ (void)popToPrevVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popViewControllerAnimated:YES];
    });
}

+ (void)popToSpecialVC:(UIViewController *)selfVC specialVC:(id )specialVC{
    for(UIViewController *ctrl in selfVC.navigationController.viewControllers) {
        if([ctrl isKindOfClass:specialVC]) {
            [selfVC.navigationController popToViewController:ctrl animated:YES];
        }
    }
}

+ (void)popToRootVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popToRootViewControllerAnimated:YES];
    });
}

+ (void)backToMarketVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MethodFunc popToSpecialVC:selfVC specialVC:[TabBarVC class]];
    });
    //[TabBarVC sharedVC].selectedIndex = 0;  //不能将这行代码放到主线程中执行
}
+ (void)backToMineVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MethodFunc popToSpecialVC:selfVC specialVC:[TabBarVC class]];
    });
    //[TabBarVC sharedVC].selectedIndex = 1;  //不能将这行代码放到主线程中执行
}
+ (UIViewController *)getCurrVC{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;  
}

+ (UIViewController *)getPresentedVC
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }

    return topVC;
}
+ (void)toMissAuthos:(UIViewController *)selfVC tipInfo:(NSString *)tipInfo{
    [HudTips showToast:tipInfo showType:StToastShowTypeTop animationType:StToastAnimationTypeScale];
    //清空用户信息
//    [UICKeyChainStore keyChainStore][@"orLogin"] = @"false";
//    [UICKeyChainStore keyChainStore][@"authos"] = @"";
//    //Mark:弹出登录视图，登录失效是:status_code:0
//    SmsLoginVC * smsLoginV = [[SmsLoginVC alloc] init];
//    smsLoginV.pass_Vals = @{@"status_code":@"0",@"selfVC":selfVC};
//    [MethodFunc presentToNaviVC:selfVC destVC:smsLoginV animate:YES];
}

@end
