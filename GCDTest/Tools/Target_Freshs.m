//
//  Target_Freshs.m
//  GCDTest
//
//  Created by test on 2018/7/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "Target_Freshs.h"
#import "MGJRouterVC.h"

@implementation Target_Freshs

- (UIViewController *)Action_ToAnoherVC:(NSDictionary *)params {
    MGJRouterVC *mGJRouterV = [[MGJRouterVC alloc] init];
    if (params) {
        mGJRouterV.pass_vals = params;
    }
    return mGJRouterV;
}
@end
