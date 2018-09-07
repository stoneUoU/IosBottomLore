//
//  Person+AttrAdd.m
//  GCDTest
//
//  Created by test on 2018/6/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "Person+AttrAdd.h"
// 使用运行时，需要导入头文件
#import <objc/runtime.h>
@implementation Person (AttrAdd)
- (void)setAge:(NSInteger)age{
    // 使用运行时关联对象，person对象(self)强引用age对象，并且设置标记为"age"(可以根据该标记来获取引用的对象age，标记可以为任意字符，只要setter和getter中的标记一致就可以)
    // 参数1：源对象
    // 参数2：关联时用来标记属性的key(因为可能要添加很多属性)
    // 参数3：关联的对象
    // 参数4：关联策略
    objc_setAssociatedObject(self, @"age", @(age), OBJC_ASSOCIATION_ASSIGN);   //@"age":随意value，但set与get要相同
}

- (NSInteger)age{
    // 根据“age”标识取person对象(self)强引用的age对象
    // 参数1：源对象
    // 参数2：关联时用来标记属性的key(因为可能要添加很多属性)
    return [objc_getAssociatedObject(self, @"age") integerValue];
}


-(void)setStrName:(NSString *)strName{
    objc_setAssociatedObject(self, @"strName", strName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)strName{
    return objc_getAssociatedObject(self, @"strName");
}

@end
