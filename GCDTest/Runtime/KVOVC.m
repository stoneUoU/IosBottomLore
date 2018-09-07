//
//  KVOVC.m
//  GCDTest
//
//  Created by test on 2018/6/30.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "KVOVC.h"

@interface BB : NSObject
@property(nonatomic,assign) int age;
@end
@implementation BB
@end

@interface KVOVC ()
@property (strong, nonatomic)   UIButton  *testBtn;  /**< 打印Btn */
@property (strong, nonatomic)   BB  *B;  /** B **/
@end

@implementation KVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _B=[[BB alloc] init];

    _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _testBtn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width-120)/2, 450, 120, 60);
    _testBtn.backgroundColor = [UIColor redColor];
    [_testBtn setTitle:@"KVO测试" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_testBtn addTarget:self action:@selector(toChangeVals:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];
    [_B addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];

    //[_B addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];

//    [_B addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|
//     NSKeyValueObservingOptionNew context:nil];
}
-(void)toChangeVals:(UIButton *)sender{
    _B.age = _B.age + 1;
}
/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
//                       change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    // 判断是否为_B的属性“age”:
//    if([keyPath isEqualToString:@"age"] && object == _B) {
//        // 响应变化处理：UI更新（label文本改变）
//        STLog(@"%@",[NSString stringWithFormat:@"当前的num值为：%@",
//                     [change valueForKey:@"new"]]);
//        //change的使用：上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
//        STLog(@"\\noldnum:%@ newnum:%@",[change valueForKey:@"old"],
//              [change valueForKey:@"new"]);
//    }
//}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    STLog(@"%@",keyPath);
    STLog(@"%@",object == _B?@"YES":@"NO");
}
-(void)dealloc{
    /* 3.移除KVO */
    [_B removeObserver:self forKeyPath:@"age" context:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
