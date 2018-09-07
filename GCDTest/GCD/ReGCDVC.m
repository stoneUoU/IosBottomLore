//
//  ReGCDVC.m
//  GCDTest
//
//  Created by test on 2018/6/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "ReGCDVC.h"

@interface ReGCDVC ()

@end

@implementation ReGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    任务：就是执行操作的意思，换句话说就是你在线程中执行的那段代码。在 GCD 中是放在 block 中的。执行任务有两种方式：同步执行（sync）和异步执行（async）。两者的主要区别是：是否等待队列的任务执行结束，以及是否具备开启新线程的能力
//    同步执行（sync）：同步添加任务到指定的队列中，在添加的任务执行结束之前，会一直等待，直到队列里面的任务完成之后再继续执行。只能在当前线程中执行任务，不具备开启新线程的能力
//    异步执行（async）：异步添加任务到指定的队列中，它不会做任何等待，可以继续执行任务。可以在新的线程中执行任务，具备开启新线程的能力。
//    异步执行（async）虽然具有开启新线程的能力，但是并不一定开启新线程
//
//    串行队列和并发队列。两者都符合 FIFO（先进先出）的原则
//    串行队列（Serial Dispatch Queue）：只开启一个线程，一个任务执行完毕后，再执行下一个任务
//    并发队列（Concurrent Dispatch Queue）：可以让多个任务并发（同时）执行。（可以开启多个线程，并且同时执行任务）
    // 串行队列的创建方法
    dispatch_queue_t serialQ = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    // 并发队列的创建方法
    dispatch_queue_t concurrentQ = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    // 主队列（Main Dispatch Queue）
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    // 全局并发队列（Global Dispatch Queue）
    dispatch_queue_t gobalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //[self syncConcurrent];
    //[self asyncConcurrent];
    //[self syncSerial];
    //[self asyncSerial];
    //[self syncMain];
    //[NSThread detachNewThreadSelector:@selector(toAsync) toTarget:self withObject:nil];
    [self communication];

//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //dispatch_get_main_queue
//
//    NSLog(@"apply---begin");
//    NSLog(@"---%@",[NSThread currentThread]);
//    NSLog(@"apply---end");

//    信号量: dispatch_semaphore
//     Dispatch Semaphore 中，使用计数来完成这个功能，计数为0时等待，不可通过。计数为1或大于1时，计数减1且不等待，可通过。
//
//    dispatch_semaphore_create：创建一个Semaphore并初始化信号的总量
//    dispatch_semaphore_signal：发送一个信号，让信号总量加1
//    dispatch_semaphore_wait：可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行。
//    dispatch_semaphore主要作用:
//    保持线程同步，将异步执行任务转换为同步执行任务
//    保证线程安全，为线程加锁

    //[self setNets];

    //GCD中的线程同步
//    dispatch_semaphore
//    dispatch_group
//    dispatch_barrier

    //模拟网络请求
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        [self setNetOne:semaphore];
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        [self setNetTwo];
//    });
}

//-(void)setNetOne:(dispatch_semaphore_t)semaphore{
//    //以上请求的设置忽略
//    [NSThread sleepForTimeInterval:3.0];
//    STLog(@"setNetOne");
//    //成功拿到token，发送信号量:
//    dispatch_semaphore_signal(semaphore);
//}
//-(void)setNetTwo{
//    STLog(@"setTwo");
//}


//-(void)setNets{
//    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
//
//    __block long x = 0;
//    NSLog(@"0_x:%ld",x);
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        //此时信号量为0 对signal增加1 信号量变为1，
//        x = dispatch_semaphore_signal(signal);
//        NSLog(@"1_x:%ld",x);
//
//        x = dispatch_semaphore_signal(signal);
//        NSLog(@"2_x:%ld",x);
//    });
//    //  0_x 3_x waiting 1_x wait 2  4_x  waking  wait 3 2_x  5_x 6_x
//    //此时信号量为1 所以执行下边，对signal减掉1，然后信号量为0
//    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
//    NSLog(@"3_x:%ld",x);
//
//    //此时信号量为0，永远等待，在等待的时候执行block了，在等待block时候block内对信号量增加了1，然后开始执行下边，并且信号量再次减掉1 变为0
//    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
//    NSLog(@"4_x:%ld",x);
//
//    //此时信号量为0，永远等待，在等待的时候执行block了，在等待block时候block内对信号量增加了1，然后开始执行下边，并且信号量再次减掉1 变为0
//    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
//    NSLog(@"5_x:%ld",x);
//
//    dispatch_semaphore_signal(signal);
//}


-(void)setAysnc{
    // 创建队列组
//    dispatch_group_t group = dispatch_group_create();
//    // 创建信号量，并且设置值为10
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    for (int i = 0; i < 20; i++)
//    {   // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"%i",i);
//            // 每次发送信号则semaphore会+1，
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
}


/**
 * semaphore 线程同步
 */
- (void)semaphoreSync {

    NSLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        number = 100;
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);

    //这是因为异步执行不会做任何等待，可以继续执行任务。异步执行将任务1追加到队列之后，不做等待，接着执行dispatch_semaphore_wait方法。此时 semaphore == 0，当前线程进入等待状态。然后，异步任务1开始执行。任务1执行到dispatch_semaphore_signal之后，总信号量，此时 semaphore = 1，dispatch_semaphore_wait方法使总信号量减1，正在被阻塞的线程（主线程）恢复继续执行。最后打印semaphore---end,number = 100。这样就实现了线程同步，将异步执行任务转换为同步执行任务。
}

//-(void)toAsync{
//    STLog(@"%@",[NSThread currentThread]);
//}

//同步执行 + 并发队列   没有开启新线程，串行执行任务
//异步执行 + 并发队列   有开启新线程，并发执行任务
//同步执行 + 串行队列   没有开启新线程，串行执行任务
//异步执行 + 串行队列   有开启新线程(1条)，串行执行任务
//同步执行 + 主队列    主线程调用：死锁卡住不执行   其他线程调用：没有开启新线程，串行执行任务 ===== 重点`
//异步执行 + 主队列   没有开启新线程，串行执行任务 ===== 重点

//主队列：GCD自带的一种特殊的串行队列 所有放在主队列中的任务，都会放到主线程中执行

/**
 * 线程间通信
 */

- (void)communication {
    // 并行队列+异步任务嵌套
    dispatch_queue_t serialQ = dispatch_queue_create("com.youlu.serialQ", DISPATCH_QUEUE_CONCURRENT);
    STLog(@"start");
    dispatch_async(serialQ, ^{
        // 异步追加任务   任务中代码按顺序执行
        for (int i = 0; i < 1; ++i) {             // 模拟耗时操作
            sleep(2);
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_async(serialQ, ^{
            for (int i = 0; i < 1; ++i) {
                NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
            }
        });
    });
    STLog(@"end");
}
//你这个是在 第一个 block1 中啊
//虽然是异步  但是 他里边的代码是顺序执行啊
//顺序是这样的
//1. 先打印 start
//2. 异步执行并发队列中的 任务
//任务就是上图这样的
//3. 执行任务中的 for 循环
//4. 执行完 for 循环，再开启一个异步任务  打印 2---
//如果没有异步这些东西的话， 代码是不是都是顺序执行的？
//就是从上往下执行的
//然后。。。 异步 block 内的任务也是 从上往下执行的。
//如果你把第二个 异步任务 放到 block 之外的话。
//保持两个 block 按顺序平级。。而不是嵌套的话 就不一样了

//因为异步发出任务。  这样任务1 任务2 可以近似看做 同时执行。但是不知道谁先执行结束，所以导致打印结果随机。

//1. 第一种   但是里边代码肯定是 从上往下执行的  所以肯定先打印 1----。 这时候还没执行到第二个异步任务呢
//dispatch_async(queue, ^{
//    // 任务1
//    dispatch_async(queue, ^{
//    // 任务2
//    }
//}

//代码都是从上往下执行，结果顺序

//2. 第二种
//dispatch_async(queue, ^ {
//// 任务1
//}
//dispatch_async(queue, ^ {
//// 任务2
//}

//第二种:代码都是从上往下执行，但结果随机

//- (void)communication {
//    // 串行队列+2个同步任务嵌套  start 1 1 崩   死锁
//    dispatch_queue_t serialQ = dispatch_queue_create("com.youlu.serialQ", DISPATCH_QUEUE_SERIAL);
//    STLog(@"start");
//    dispatch_sync(serialQ, ^{
//        // 异步追加任务
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//        dispatch_sync(serialQ, ^{
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//    });
//    STLog(@"end");
//}

//- (void)communication {
//    // 并行队列+同步任务嵌套  start 1 1 2 end
//    dispatch_queue_t serialQ = dispatch_queue_create("com.youlu.serialQ", DISPATCH_QUEUE_CONCURRENT);
//    STLog(@"start");
//    dispatch_sync(serialQ, ^{
//        // 异步追加任务
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//        dispatch_sync(serialQ, ^{
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//    });
//    STLog(@"end");
//}

//- (void)communication {
//    // 串行队列+异步任务嵌套  start end 1 1 2
//    dispatch_queue_t serialQ = dispatch_queue_create("com.youlu.serialQ", DISPATCH_QUEUE_SERIAL);
//    STLog(@"start");
//    dispatch_async(serialQ, ^{
//        // 异步追加任务
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//        // 回到主线程
//        dispatch_async(serialQ, ^{
//            // 追加在主线程中执行的任务
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//    });
//    STLog(@"end");
//}

- (void)syncMain {

    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncMain---begin");

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    NSLog(@"syncMain---end");
}

- (void)asyncSerial {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    NSLog(@"asyncSerial---end");
}

- (void)syncSerial {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncSerial---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    NSLog(@"syncSerial---end");
}

- (void)asyncConcurrent {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            //[NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            //[NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            //[NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    NSLog(@"asyncConcurrent---end");
}



- (void)syncConcurrent {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    NSLog(@"syncConcurrent---end");
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
