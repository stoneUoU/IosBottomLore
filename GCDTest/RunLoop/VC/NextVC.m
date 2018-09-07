//
//  NextVC.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
// 演示一个买票的系统：
#import "NextVC.h"

@interface NextVC ()
@property(nonatomic,strong)UILabel *uiLabel;

@property(nonatomic,strong)UIImageView *uIMV;
@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.

    [self setUI];

    //[NSThread detachNewThreadSelector:@selector(goFunc) toTarget:self withObject:nil];

//    __weak typeof(self)weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        STLog(@"%@",[NSThread currentThread]);
//        weakSelf.uiLabel.text = @"linlei";
//        weakSelf.uIMV.image = [UIImage imageNamed:@"pic_dayin_shouju"];
//    });
//    STLog(@"%@",[NSThread currentThread]);
//    dispatch_queue_t queue = dispatch_queue_create("com.youlu.gcdTest", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        STLog(@"%@",[NSThread currentThread]);
//        [self performSelector:@selector(toDoes) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
//    });

//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(toDoes:) object:@"alloc"];
//    // 手动启动线程,子线程
//    [thread start];

    // 设置余票数
    self.tickets = 10;
}
//-(void)goFunc{
//   // [self performSelector:@selector(toDoes) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
////    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
////    [runLoop run];
//}
//
//-(void)toDoes:(NSString *)str{
//    STLog(@"%@",[NSThread currentThread]);
//    _uiLabel.text = str;
//    _uIMV.image = [UIImage imageNamed:@"pic_dayin_shouju"];
//}

-  (void)saleTickets
{
    // while 循环保证每个窗口都可以单独把所有的票卖完
    while (YES) {

        // 模拟网络延迟
        [NSThread sleepForTimeInterval:1.0];
        // 添加互斥锁
        @synchronized(self) {
            // 判断是否有票
            if (self.tickets>0) {
                // 有票就卖
                self.tickets--;
                // 卖完一张票就提示用户余票数
                NSLog(@"剩余票数 => %zd %@",self.tickets,[NSThread currentThread]);
            } else {
                // 没有就提示用户
                NSLog(@"没票了");
                // 此处要结束循环,不然会死循环
                break;
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 售票口 A
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    thread1.name = @"售票口 A";
    [thread1 start];

    // 售票口 B
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    thread2.name = @"售票口 B";
    [thread2 start];

}

//互斥锁:如果发现有其他线程正在执行锁定的代码,线程会进入休眠状态,等待其他线程执行完毕,打开锁之后,线程会重新进入就绪状态.等待被CPU重新调度.
//自旋锁:如果发现有其他线程正在执行锁定的代码,线程会以死循环的方式,一直等待锁定代码执行完成.
-(void)setUI{
    _uiLabel = [[UILabel alloc] init];
    _uiLabel.text = @"愿你三冬暖，愿你春不寒";
    _uiLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_uiLabel];
    [_uiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

    _uIMV = [[UIImageView alloc] init];
    _uIMV.image = [UIImage imageNamed:@"spaceship"];
    _uIMV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_uIMV];
    [_uIMV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.uiLabel.mas_bottom).offset(32);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];
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
