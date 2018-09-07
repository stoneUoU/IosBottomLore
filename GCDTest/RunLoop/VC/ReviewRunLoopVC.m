//
//  ReviewRunLoopVC.m
//  GCDTest
//
//  Created by test on 2018/8/6.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "ReviewRunLoopVC.h"

@interface ReviewRunLoopVC ()

@property (strong, nonatomic)   NSTimer  *timer;  /**< 时间 */

@end

@implementation ReviewRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTest];
}


-(void)setTest{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:@{@"name":@"stone"} repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

//    if (@available(iOS 10.0, *)) {
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            STLog(@"嘀嗒嘀嗒");
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    } else {
//        // Fallback on earlier versions
//    }

//    SEL action = @selector(setDesc:);
//    NSInvocation* invo = [NSInvocation invocationWithMethodSignature:[[self class]   instanceMethodSignatureForSelector:action]];
//    [invo setTarget:self];
//    [invo setSelector:action];
//    //NSString *str = @"invo测试环境";
//    NSDictionary *dict = @{@"name":@"石头呢"};
//    [invo setArgument:&dict atIndex:2];
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 invocation:invo repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:@{@"name":@"666666"} repeats:YES];

//    if (@available(iOS 10.0, *)) {
//        [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            STLog(@"嘀嗒嘀嗒");
//        }];
//    } else {
//        // Fallback on earlier versions
//    }

//    SEL action = @selector(setDesc:);
//    NSInvocation* invo = [NSInvocation invocationWithMethodSignature:[[self class]   instanceMethodSignatureForSelector:action]];
//    [invo setTarget:self];
//    [invo setSelector:action];
//    NSDictionary *dict = @{@"name":@"石头呢"};
//    [invo setArgument:&dict atIndex:2];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 invocation:invo repeats:YES];

    //IOS延时执行:
    //[self performSelector:@selector(setStr:) withObject:NSStringFromSelector(_cmd) afterDelay:2.0];

//    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(desc:) userInfo:@{@"para":@"参数值丫"} repeats:NO];

//    [NSThread sleepForTimeInterval:2.0];
//    [self setStr:NSStringFromSelector(_cmd)];

//    __weak typeof(self)weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf setStr:NSStringFromSelector(_cmd)];
//    });

//    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(desc:) userInfo:@{@"para":@"Stone"} repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    //[self performSelector:@selector(funcWithNoParas) withObject:nil afterDelay:2.0];
//    [self performSelectorOnMainThread:@selector(funcWithNoParas) withObject:nil waitUntilDone:NO];
//    STLog(@"99999999999");
    //    这里如果waitUntilDone:NO 即不用等待desc执行完成，直接执行下面的代码
    //    如果waitUntilDone:YES即需要等待desc执行完成后，子线程才会继续执行后面的代码
//    [self performSelector:@selector(setStr:) onThread:[NSThread currentThread] withObject:@"Str" waitUntilDone:YES modes:@[NSRunLoopCommonModes]];
//    STLog(@"IIIIIII");

    //创建子线程：
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(setStr:) object:@"Str2"];
//    // 启动
//    [thread start];

    //[NSThread detachNewThreadSelector:@selector(setStr:) toTarget:self withObject:@"Str2"];

//    [self setStr:@"林磊"];

//    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(longrun) object:nil];
//    [thread start];
//
//    if (@available(iOS 10.0, *)) {
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [self performSelector:@selector(runmethod) onThread:thread withObject:nil waitUntilDone:YES modes:@[NSDefaultRunLoopMode]];
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
}

-(void)longrun{
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    //为了防止runloop退出，添加一个端口。
    [runLoop addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [runLoop runUntilDate:[NSDate distantFuture]];
}
-(void)runmethod
{
    NSLog(@"%@ 辅助线程上执行的代码",[NSThread currentThread]);
}

-(void)desc:(NSTimer *)timer{
    STLog(@"++倒计时走起来++++++++++++%@",timer.userInfo);
}

-(void)setStr:(NSString *)str{
    STLog(@"当前线程-------------%@",[NSThread currentThread]);
    STLog(@"++倒计时走起来++++++++++++%@",str);
}

-(void)setDesc:(NSDictionary *)dict{
    STLog(@"++倒计时走起来++++++++++++%@",[dict objectForKey:@"name"]);
}

-(void)funcWithNoParas{
//    sleep(3);
    STLog(@"++倒计时走起来++++++++++++%@",NSStringFromSelector(_cmd));
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
