//
//  AgainGCDVC.m
//  GCDTest
//
//  Created by test on 2018/8/9.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AgainGCDVC.h"

@interface AgainGCDVC ()

@end
//任务：就是执行操作的意思，换句话说就是你在线程中执行的那段代码。在 GCD 中是放在 block 中的。执行任务有两种方式：同步执行（sync）和异步执行（async）。两者的主要区别是：是否等待队列的任务执行结束，以及是否具备开启新线程的能力

//串行队列（Serial Dispatch Queue）：
//每次只有一个任务被执行。让任务一个接着一个地执行。（只开启一个线程，一个任务执行完毕后，再执行下一个任务）

//并发队列（Concurrent Dispatch Queue）：
//可以让多个任务并发（同时）执行。（可以开启多个线程，并且同时执行任务）

//注意：并发队列的并发功能只有在异步（dispatch_async）函数下才有效

@implementation AgainGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //[self semaphoreSync];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 2.0秒后异步追加任务代码到主队列，并开始执行
//        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
//    });
    [self testMianQ];
}


-(void)testMianQ{

    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        STLog(@"%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(),^{
            STLog(@"OOOOOOO");
        });
        sleep(2.0);
        STLog(@"6666666");
    });
    STLog(@"UUUUUUU");
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        STLog(@"OOOOOOO");
    //    });
}
//-(void)setAfter{
//    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
//
//    for (int i = 0; i < 10; i++) {
//        dispatch_async(q, ^{
//            NSLog(@"%@ %d", [NSThread currentThread], i);
//        });
//    }
//    [NSThread sleepForTimeInterval:1.0];
//    NSLog(@"com here");
//}

-(void) setGCD{
    // 串行队列的创建方法
//    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
//    // 并发队列的创建方法
//    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    // 主队列的获取方法
//    dispatch_queue_t queue3 = dispatch_get_main_queue();
//
//    // 全局并发队列的获取方法
//    dispatch_queue_t queue4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    // 同步执行任务创建方法
//    dispatch_sync(queue1, ^{
//        // 这里放同步执行任务代码
//    });
//    // 异步执行任务创建方法
//    dispatch_async(queue1, ^{
//        // 这里放异步执行任务代码
//    });

    //异步+串行  串行队列只开启一个线程
}



/**
 * semaphore 线程同步
 */
- (void)semaphoreSync {

    STLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        STLog(@"----------%@",[NSThread currentThread]);      // 打印当前线程
        number = 100;
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    STLog(@"semaphore---end,number = %d",number);
}

- (void)communication {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();

    dispatch_sync(queue, ^{
        // 异步追加任务
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        STLog(@"A---%@",[NSThread currentThread]);      // 打印当前线程
        // 回到主线程
        dispatch_sync(mainQueue, ^{
            // 追加在主线程中执行的任务
            //[NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            //STLog(@"B---%@",[NSThread currentThread]);      // 打印当前线程
        });
        STLog(@"CCCCCCCCCCCCCCCC");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
