//
//  main.m
//  GCDTest
//
//  Created by test on 2018/6/12.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //NSLog(@"开始");
        //ios程序在这里开启了一个RunLoop循环，只会打印开始，不会打印结束
        int ids = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        //NSLog(@"结束");
        return ids;
    }
}
