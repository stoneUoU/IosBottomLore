//
//  CTMediator+FreshsActions.m
//  GCDTest
//
//  Created by test on 2018/7/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CTMediator+FreshsActions.h"

@implementation CTMediator (FreshsActions)

- (UIViewController *)st_mediator_toVCWithParams:(NSDictionary *)dict {
    UIViewController *viewController = [self performTarget:@"Freshs" action:@"ToAnoherVC" params:dict shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    } else {
        return [[UIViewController alloc] init];
    }
}
@end
