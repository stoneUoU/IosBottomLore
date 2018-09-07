//
//  ReSolveMsgVC.m
//  GCDTest
//
//  Created by test on 2018/6/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
//  消息转发
#import "ReSolveMsgVC.h"
#import "HelloClass.h"
#import <objc/message.h>
@interface ReSolveMsgVC ()

@end

@implementation ReSolveMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    HelloClass *helloClass = [[HelloClass alloc] init];
    objc_msgSend(helloClass, @selector(testV:),@"参数");  //动态方法解析resolveInstanceMethod resolveClassMethod
    objc_msgSend(helloClass, @selector(noneClassMethod:andStr:),@"参数s",@"Stone");//备用接收者forwordingTargetForSelector
    objc_msgSend(helloClass, @selector(forwardInvocationMethod));//完整转发 forwardInvocation

    [helloClass performSelector:@selector(testV:) withObject:@"参数===testV"];

    [helloClass performSelector:@selector(noneClassMethod:andStr:) withObject:@"参数===testV" withObject:@"参数===testV"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end





//师兄，我毕业后的工资还是直接从财务发我卡上吧，我把卡号发你
//在工资方面，说实话：我信任不了我叔，我怕他还会像以前一样扣我工资，到现在我根本都不知道公司实际发了多少钱给我
//他跟我说发立购是为了资金周转，我不相信，毕竟他有这样做过，没有必要经过他手
//户名：林磊
//银行卡号：6217994210000990314
//收款行：中国邮政储蓄银行(江西南昌市北京西路支行)
