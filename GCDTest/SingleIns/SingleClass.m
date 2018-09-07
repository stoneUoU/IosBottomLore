//
//  SingleClass.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//


#import "SingleClass.h"
//单例模式
@implementation SingleClass

static SingleClass *_shareIns = nil;

+(id)shareIns{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareIns = [[super allocWithZone:NULL] init];
    });
    return _shareIns;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    return [SingleClass shareIns];
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return [SingleClass shareIns];
}

@end

//class SingleClass: NSObject {
//    //使用全局变量
//    static let singleClass = SingleClass()
//    //swift  结构体返回单例
//    class func shareDefault()->SingleClass{
//        struct single{
//            static var singleDefault = SingleClass()
//        }
//        return single.singleDefault
//    }
//    private override init(){}
//}
