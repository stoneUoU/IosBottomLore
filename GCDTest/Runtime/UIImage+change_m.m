//
//  UIImage+change_m.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "UIImage+change_m.h"
#import <objc/runtime.h>
@implementation UIImage(change_m)

+(void)load{
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(st_imageNamed:));
    method_exchangeImplementations(m1, m2);
}

+(UIImage *)st_imageNamed:(NSString *)name{
    return [UIImage st_imageNamed:[NSString stringWithFormat:@"%@",name]];
}
@end

