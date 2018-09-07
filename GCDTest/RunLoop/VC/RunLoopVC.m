//
//  RunLoopVC.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "RunLoopVC.h"
#import "DeallocVC.h"


@interface RunLoopVC ()
@property (strong, nonatomic)   UIButton  *testBtn;  /**< 打印Btn */

@property (strong, nonatomic)   NSTimer  *timer;  /**< 时间 */
@end

@implementation RunLoopVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setUI];

    //Foundation
    //STLog(@"%@",[NSRunLoop currentRunLoop]); // 获得当前线程的RunLoop对象
    //STLog(@"%@",[NSRunLoop mainRunLoop]); // 获得主线程的RunLoop对象

//    ###Core Foundation中关于RunLoop的5个类
//    CFRunLoopRef  //获得当前RunLoop和主RunLoop
//    CFRunLoopModeRef  //运行模式，只能选择一种，在不同模式中做不同的操作
//    CFRunLoopSourceRef  //事件源，输入源
//    CFRunLoopTimerRef //定时器时间
//    CFRunLoopObserverRef //观察者


//    2.CFRunLoopMode的类型
//    1. kCFRunLoopDefaultMode
//       App的默认Mode，通常主线程是在这个Mode下运行
//    2. UITrackingRunLoopMode：
//       界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
//    3. UIInitializationRunLoopMode:
//       在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用
//    >4. GSEventReceiveRunLoopMode:
//       接受系统事件的内部 Mode，通常用不到
//    >5. kCFRunLoopCommonModes:
//       这是一个占位用的Mode，作为标记kCFRunLoopDefaultMode和UITrackingRunLoopMode用，并不是一种真正的Mode

//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

//    if (@available(iOS 10.0, *)) {
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            STLog(@"嘀嗒嘀嗒");
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    }else {
//    // Fallback on earlier versions
//    }

//    SEL action = @selector(desc:);
//    NSInvocation* invo = [NSInvocation invocationWithMethodSignature:[[self class]   instanceMethodSignatureForSelector:action]];
//    [invo setTarget:self];
//    [invo setSelector:action];
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 invocation:invo repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    NSInvocation *invo = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(desc:)]];
//    [invo setTarget:self];
//    [invo setSelector:@selector(desc:)];
//    NSString *str = @"invo测试环境";
//    [invo setArgument:&str atIndex:2];
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 invocation:invo repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

     //NSTimer *timerStart = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:nil repeats:YES];

//    NSTimer *timeStart = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        STLog(@"嘀嗒嘀嗒");
//    }];
//    SEL action = @selector(desc:);
//    NSInvocation* invo = [NSInvocation invocationWithMethodSignature:[[self class]   instanceMethodSignatureForSelector:action]];
//    [invo setTarget:self];
//    [invo setSelector:action];
//    NSTimer *timeStart = [NSTimer scheduledTimerWithTimeInterval:1.0 invocation:invo repeats:YES];

    //IOS延时执行:
//    [self performSelector:@selector(desc:) withObject:NSStringFromSelector(_cmd) afterDelay:2.0];
//
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timerDesc:) userInfo:@{@"para":@"参数值丫"} repeats:NO];
//
//    [NSThread sleepForTimeInterval:1.0];
//    [self desc:NSStringFromSelector(_cmd)];
//
//    __weak typeof(self)weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf desc:NSStringFromSelector(_cmd)];
//    });

//    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(timerDesc:) userInfo:@{@"para":@"Stone"} repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    //[self performSelector:@selector(desc:) withObject:nil afterDelay:2.0];
    //[self performSelectorOnMainThread:@selector(desc:) withObject:nil waitUntilDone:YES];
//    这里如果waitUntilDone:NO 即不用等待desc执行完成，直接执行下面的代码
//    如果waitUntilDone:YES即需要等待desc执行完成后，子线程才会继续执行后面的代码
    //[self performSelector:@selector(desc:) onThread:[NSThread currentThread] withObject:@"Str" waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
    //STLog(@"IIIIIII");

    // 创建
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(desc:) object:@"Str2"];
//    // 启动
//    [thread start];
//
//    [NSThread detachNewThreadSelector:@selector(desc:) toTarget:self withObject:@"Str2"];

//    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(longrun) object:nil];
//    [thread start];
//    if (@available(iOS 10.0, *)) {
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [self performSelector:@selector(runmethod) onThread:thread withObject:nil waitUntilDone:YES modes:@[NSDefaultRunLoopMode]];
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
    //异步开启子线程运行相应的代码
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSTimer * timer = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
//            static int count = 0;
//            [NSThread sleepForTimeInterval:2];
//            //休息一秒钟，模拟耗时操作
//            NSLog(@"===========%d",count++);
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//        [[NSRunLoop currentRunLoop] run];
//    });
}

//-(void)longrun{
//    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
//    //为了防止runloop退出，添加一个端口。
//    [runLoop addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
//    [runLoop runUntilDate:[NSDate distantFuture]];
//}
//-(void)runmethod
//{
//    NSLog(@"%@ 辅助线程上执行的代码",[NSThread currentThread]);
//}

-(void)setUI{
    _scrollerV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, ScreenW, 300)];
    _scrollerV.showsVerticalScrollIndicator = YES;
    _scrollerV.contentSize = CGSizeMake(ScreenW, ScreenH);
    _scrollerV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_scrollerV];

    _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _testBtn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width-120)/2, 480, 120, 60);
    _testBtn.backgroundColor = [UIColor redColor];
    [_testBtn setTitle:@"打印" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_testBtn addTarget:self action:@selector(toPrint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];
}
-(void)toPrint:(UIButton *)sender{
    //[MGJRouter openURL:@"mgj://market/detail?id=7&&demoID=林磊"];
    [MGJRouter openURL:@"mgj://market/demo" withUserInfo:@{@"user_Name": @"林磊"} completion:nil];
}
-(void)timerDesc:(NSTimer *)timer{
    STLog(@"++倒计时走起来++++++++++++%@",[timer.userInfo objectForKey:@"para"]);
}
-(void)desc:(NSString *)str{
    sleep(2);
    STLog(@"++倒计时走起来++++++++++++%@",str);
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
