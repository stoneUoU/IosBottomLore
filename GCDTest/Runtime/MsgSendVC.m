//
//  MsgSendVC.m
//  GCDTest
//
//  Created by test on 2018/6/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MsgSendVC.h"
#import "Person.h"
#import <objc/message.h>
#import "Person+AttrAdd.h"
#import "Person+MethodAdd.h"
@interface MsgSendVC ()

@end

@implementation MsgSendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    Person *stone = [[Person alloc] init];

    if ([stone respondsToSelector:@selector(toPlay:andIdx:)]){
        [stone performSelector:@selector(toPlay:andIdx:) withObject:@"厦门" withObject:@"厦门大学"];
    }
    objc_msgSend(stone, @selector(toPlay:andIdx:),@"厦门",@"环岛路");
    
    objc_msgSend(stone, @selector(toDo:),@"厦门",@"鼓浪屿");

    [stone performSelector:@selector(toDo:) withObject:@"厦门" withObject:@"五缘湾"];

    objc_msgSend([Person class], @selector(toFunc:),@"toFunc",@"厦门",10);

    //给Person类动态添加属性
    stone.age = 24;
    STLog(@"%ld",(long)stone.age);

}
//点击空白处，键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//@interface NSObject <nsobject> {
//
//    Class isa  OBJC_ISA_AVAILABILITY;
//
//}
//
//@end
//
//@implementation NSObject
//
//
//typedef struct objc_class *Class;
//
//struct objc_class {
//
//    Class isa; // 指向metaclass 也就是静态的Class。一般一个Obj对象中的isa会指向普通的Class，这个Class中存储普通成员变量和对象方法，普通Class中的isa指针指向静态Class，静态Class中存储static类型成员变量和类方法

//    Class super_class ; // 指向其父类 如果这个类是根类，则为NULL。
//
//    const char *name ; // 类名
//
//    long version ; // 类的版本信息，初始化默认为0，可以通过runtime函数class_setVersion和class_getVersion进行修改、读取
//
//    long info; // 一些标识信息,如CLS_CLASS (0x1L) 表示该类为普通 class ，其中包含对象方法和成员变量;CLS_META (0x2L) 表示该类为 metaclass，其中包含类方法;
//
//    long instance_size ; // 该类的实例变量大小(包括从父类继承下来的实例变量);
//
//    struct objc_ivar_list *ivars; // 用于存储每个成员变量的地址
//
//    struct objc_method_list **methodLists ; // 与 info 的一些标志位有关,如CLS_CLASS (0x1L),则存储对象方法，如CLS_META (0x2L)，则存储类方法;
//
//    struct objc_cache *cache; // 指向最近使用的方法的指针，用于提升效率；
//
//    struct objc_protocol_list *protocols; // 存储该类遵守的协议
//
//@end

// @selector (makeText)：这是一个SEL方法选择器。SEL其主要作用是快速的通过方法名字（makeText）查找到对应方法的函数指针，然后调用其函数。SEL其本身是一个Int类型的一个地址，地址中存放着方法的名字。对于一个类中。每一个方法对应着一个SEL。所以iOS类中不能存在2个名称相同 的方法，即使参数类型不同，因为SEL是根据方法名字生成的，相同的方法名称只能对应一个SEL。


//cocoa当中的函数调用，是一种以消息的方式进行的函数调用，会涉及到三个重要的概念，class，sel，IMP

//class  每个NSObject的第一个成员变量都是class类型的成员，isa，这个isa的对象可以访问到本类的父类，也可以访问到本类的所有方法的列表
//Class 是指向类结构体的指针，该类结构体含有一个指向其父类类结构的指针
//NSObject 的class 方法就返回这样一个指向其类结构的指针。每一个类实例对象的第一个实例变量是一个指向该对象的类结构的指针，叫做isa

//SEL  方法名称的描述
//typedef struct objc_selector   *SEL
//它是一个指向 objc_selector 指针，表示方法的名字/签名。如下所示，打印出 selector

//IMP  这个是具体的方法的地址
//typedef id (*IMP)(id, SEL, ...);
//IMP 是一个函数指针，这个被指向的函数包含一个接收消息的对象id(self  指针), 调用方法的选标 SEL (方法名)，以及不定个数的方法参数，并返回一个id。也就是说 IMP 是消息最终调用的执行代码，是方法真正的实现代码
//NSObject 类中的methodForSelector：方法就是这样一个获取指向方法实现IMP 的指针，methodForSelector：返回的指针和赋值的变量类型必须完全一致，包括方法的参数类型和返回值类型

//typedef struct objc_method *Method;
//typedef struct objc_ method {
//    SEL method_name;  方法的名称
//    char *method_types;  方法参数的类型
//    IMP method_imp;  方法的具体实现的函数指针
//};

//class   返回对象的类；
//isKindOfClass 和 isMemberOfClass检查对象是否在指定的类继承体系中；
//respondsToSelector 检查对象能否相应指定的消息；
//conformsToProtocol 检查对象是否实现了指定协议类的方法；
//methodForSelector  返回指定方法实现的地址。
//performSelector:withObject 执行SEL 所指代的方法。
