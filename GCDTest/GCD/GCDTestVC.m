//
//  GCDTestVC.m
//  GCDTest
//
//  Created by test on 2018/6/12.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "GCDTestVC.h"

@interface GCDTestVC ()

@end

@implementation GCDTestVC

//任务：就是执行操作的意思，换句话说就是你在线程中执行的那段代码，也就是GCD 中的block代码片段

//同步执行(sync):同步添加任务到指定的队列中，在添加的任务执行结束之前，会一直等待，直到队列里面的任务完成之后再继续执行 只能在当前线程中执行任务，不具备开启新线程的能力

//异步执行(async):异步添加任务到指定的队列中，它不会做任何等待，可以继续执行任务  可以在新的线程中执行任务，具备开启新线程的能力

//异步执行(async):虽然具有开启新线程的能力，但是并不一定开启新线程

//队列(Dispatch Queue):这里的队列指执行任务的等待队列，即用来存放任务的队列。队列是一种特殊的线性表，采用 FIFO（先进先出）的原则，即新任务总是被插入到队列的末尾，而读取任务的时候总是从队列的头部开始读取

//串行队列和并发队列 两者都符合 FIFO（先进先出）的原则  主要区别:执行顺序不同，以及开启线程数不同

//串行队列(Serial Dispatch Queue):每次只有一个任务被执行。让任务一个接着一个地执行。（只开启一个线程，一个任务执行完毕后，再执行下一个任务）

//并发队列(Concurrent Dispatch Queue):可以让多个任务并发（同时）执行。（可以开启多个线程，并且同时执行任务）

//并发队列的并发功能只有在异步（dispatch_async）函数下才有效

//串行队列，GCD 提供了的一种特殊的串行队列：主队列（Main Dispatch Queue）
//对于并发队列，GCD 默认提供了全局并发队列（Global Dispatch Queue）

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //[self syncMain];

    //[self createCommonM];

//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"111111111111111111");
//    });
}


-(void)setQueue{
    // 串行队列的创建方法
    dispatch_queue_t serialQ = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    // 并发队列的创建方法
    dispatch_queue_t concurrentQ = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    // 主队列的获取方法
    dispatch_queue_t mainQ = dispatch_get_main_queue();

    // 全局并发队列的获取方法
    dispatch_queue_t gobalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

-(void)setTask{
    dispatch_queue_t mainQ = dispatch_get_main_queue();

    // 同步执行任务创建方法
    dispatch_sync(mainQ, ^{
        // 这里放同步执行任务代码
    });
    // 异步执行任务创建方法
    dispatch_async(mainQ, ^{
        // 这里放异步执行任务代码
    });
}

//同步执行 + 并发队列      没有开启新线程，串行执行任务
//异步执行 + 并发队列      有开启新线程，并发执行任务
//同步执行 + 串行队列      没有开启新线程，串行执行任务
//异步执行 + 串行队列      有开启新线程(1条)，串行执行任务
//同步执行 + 主队列        主线程调用：死锁卡住不执行    其他线程调用：没有开启新线程，串行执行任务
//异步执行 + 主队列        没有开启新线程，串行执行任务



//GCD 信号量：dispatch_semaphore
//dispatch_semaphore_create：创建一个Semaphore并初始化信号的总量
//dispatch_semaphore_signal：发送一个信号，让信号总量加1
//dispatch_semaphore_wait：可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行。


/**
 * semaphore 线程同步
 */
- (void)semaphoreSync {
    NSLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---1"); // 打印当前线程
        number = 100;
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);
}
//semaphore---end 是在执行完  number = 100; 之后才打印的。而且输出结果 number 为 100。
//这是因为异步执行不会做任何等待，可以继续执行任务。异步执行将任务1追加到队列之后，不做等待，接着执行dispatch_semaphore_wait方法。此时 semaphore == 0，当前线程进入等待状态。然后，异步任务1开始执行。任务1执行到dispatch_semaphore_signal之后，总信号量，此时 semaphore == 1，dispatch_semaphore_wait方法使总信号量减1，正在被阻塞的线程（主线程）恢复继续执行。最后打印semaphore---end,number = 100。这样就实现了线程同步，将异步执行任务转换为同步执行任务。

/**
 * 队列组 dispatch_group_wait
 */
- (void)groupWait {
    NSLog(@"group---begin");

    dispatch_group_t group =  dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });

    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    NSLog(@"group---end");
}

//队列组：dispatch_group_async
-(void)createGroup{

    dispatch_group_t group =  dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        NSLog(@"1---1");      // 打印当前线程
    });

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        NSLog(@"2---2");      // 打印当前线程
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        NSLog(@"6---6");
        NSLog(@"结束");
    });

//    dispatch_group_t groupQ = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//    dispatch_group_enter(groupQ);
//    dispatch_async(queue, ^{
//        sleep(2);//[NSThread sleepForTimeInterval:2];
//        // 追加任务1
//        NSLog(@"1---1");
//        dispatch_group_leave(groupQ);
//    });
//
//    dispatch_group_enter(groupQ);
//    dispatch_async(queue, ^{
//        // 追加任务2
//        sleep(8);
//        NSLog(@"2---2");
//        dispatch_group_leave(groupQ);
//    });
//    dispatch_group_notify(groupQ, queue, ^{
//        NSLog(@"任务完成");
//    });
}

-(void)createCommonM{
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        // 追加任务1
        NSLog(@"3---3");
    });

    dispatch_async(queue, ^{
        // 追加任务2
        NSLog(@"4---4");
    });
}

/**
 * 栅栏方法 dispatch_barrier_async
 */
- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        // 追加任务1
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_barrier_async(queue, ^{
        // 追加任务 barrier
        NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务3
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
}
/**
 * 快速迭代方法 dispatch_apply
 */
- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
}


/**
 * 延时执行方法 dispatch_after
 */
- (void)after {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
}
/**
 * 线程间通信
 */
- (void)communicationQ {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();

    dispatch_async(queue, ^{
        // 异步追加任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }

        // 回到主线程
        dispatch_sync(mainQueue, ^{
            // 追加在主线程中执行的任务
            //[NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        });
        NSLog(@"88888888888888888");
    });
}
/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncMain {

    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncMain---begin");

    dispatch_queue_t queue = dispatch_get_main_queue();

    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    NSLog(@"syncMain---end");
}


/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
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

/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
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

/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (void)asyncConcurrent {
    //NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
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


/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
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
