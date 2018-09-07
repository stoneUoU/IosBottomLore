//
//  MethodFunc.h
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodFunc : NSObject
//present普通视图
+ (void)presentToCommVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC animate:(BOOL )animateBool;

//present导航栏视图
+ (void)presentToNaviVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC animate:(BOOL )animateBool;


//dissmiss 被present的视图
+ (void)dismissCurrVC:(UIViewController *)selfVC animate:(BOOL )animateBool;

//push导航栏视图
+ (void)pushToNextVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC;

//pop到前一个视图
+ (void)popToPrevVC:(UIViewController *)selfVC;

//pop到特定的视图
+ (void)popToSpecialVC:(UIViewController *)selfVC specialVC:(id )specialVC;

//pop到根视图
+ (void)popToRootVC:(UIViewController *)selfVC;

//直接返回到MarketVC
+ (void)backToMarketVC:(UIViewController *)selfVC;

//直接返回到MineVC
+ (void)backToMineVC:(UIViewController *)selfVC;

//获取当前屏幕显示的视图
+ (UIViewController *)getCurrVC;
//获取当前屏幕中present出来的viewcontroller
+ (UIViewController *)getPresentedVC;
//统一处理登录失效的问题
+ (void)toMissAuthos:(UIViewController *)selfVC tipInfo:(NSString *)tipInfo;
@end
