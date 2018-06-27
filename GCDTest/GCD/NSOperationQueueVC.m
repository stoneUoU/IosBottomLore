//
//  NSOperationQueueVC.m
//  GCDTest
//
//  Created by test on 2018/6/12.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "NSOperationQueueVC.h"

@interface NSOperationQueueVC ()

@end

@implementation NSOperationQueueVC



// NSOperation、NSOperationQueue   基于 GCD 更高一层的封装，完全面向对象   比 GCD 更简单易用、代码可读性也更高
//为什么要使用 NSOperation、NSOperationQueue？
//
//可添加完成的代码块，在操作完成后执行。
//添加操作之间的依赖关系，方便的控制执行顺序。
//设定操作执行的优先级。
//可以很方便的取消一个操作的执行。
//使用 KVO 观察对操作执行状态的更改：isExecuteing、isFinished、isCancelled。

//NSOperation 任务(操作)   NSOperationQueue 操作队列

//NSOperation: 在 GCD 中是放在 block 中的。在 NSOperation 中，我们使用 NSOperation 子类 NSInvocationOperation、NSBlockOperation，或者自定义子类来封装操作。

//NSOperationQueue:不同于 GCD 中的调度队列 FIFO（先进先出）的原则  操作队列通过设置最大并发操作数（maxConcurrentOperationCount）来控制并发、串行。
//NSOperationQueue 为我们提供了两种不同类型的队列：主队列和自定义队列

//NSOperation 需要配合 NSOperationQueue 来实现多线程。因为默认情况下，NSOperation 单独使用时系统同步执行操作，配合 NSOperationQueue 我们能更好的实现异步执行

//NSOperation 实现多线程的使用步骤分为三步：

//创建操作：先将需要执行的操作封装到一个 NSOperation 对象中。
//创建队列：创建 NSOperationQueue 对象。
//将操作加入到队列中：将 NSOperation 对象添加到 NSOperationQueue 对象中。

//没有使用 NSOperationQueue、在主线程中单独使用使用子类

//NSInvocationOperation 执行一个操作的情况下，操作是在当前线程执行的，并没有开启新线程。
//在其他线程中单独使用子类 NSInvocationOperation，操作是在当前调用的其他线程执行的，并没有开启新线程。

//NSBlockOperation 执行一个操作的情况下，操作是在当前线程执行的，并没有开启新线程。

//NSBlockOperation 还提供了一个方法 addExecutionBlock:，通过 addExecutionBlock: 就可以为 NSBlockOperation 添加额外的操作。这些操作（包括 blockOperationWithBlock 中的操作）可以在不同的线程中同时（并发）执行。
//blockOperationWithBlock: 中的操作也可能会在其他线程（非当前线程）中执行，这是由系统决定的，并不是说添加到 blockOperationWithBlock: 中的操作一定会在当前线程中执行


//主队列
//凡是添加到主队列中的操作，都会放到主线程中执行。  NSOperationQueue *queue = [NSOperationQueue mainQueue];

//自定义队列（非主队列）  添加到这种队列中的操作，就会自动放到子线程中执行  同时包含了：串行、并发功能
//NSOperationQueue *queue = [[NSOperationQueue alloc] init];

//NSOperation 需要配合 NSOperationQueue 来实现多线程

//需要先创建操作，再将创建好的操作加入到创建好的队列中去   - (void)addOperation:(NSOperation *)op;
//使用 NSOperation 子类创建操作，并使用 addOperation: 将操作加入到操作队列后能够开启新线程，进行并发执行

//无需先创建操作，在 block 中添加操作，直接将包含操作的 block 加入到队列中  - (void)addOperationWithBlock:(void (^)(void))block;
//使用 addOperationWithBlock: 将操作加入到操作队列后能够开启新线程，进行并发执行

//NSOperationQueue 控制串行执行、并发执行   自定义队列同时具有串行、并发功能
//有个关键属性 maxConcurrentOperationCount，叫做最大并发操作数。用来控制一个特定队列中可以有多少个操作同时参与并发执行

//maxConcurrentOperationCount 默认情况下为-1，表示不进行限制，可进行并发执行。
//maxConcurrentOperationCount 为1时，队列为串行队列。只能串行执行。
//maxConcurrentOperationCount 大于1时，队列为并发队列。操作并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整为 min{自己设定的值，系统设定的默认最大值}

//NSOperation、NSOperationQueue 最吸引人的地方是它能添加操作之间的依赖关系

//- (void)addDependency:(NSOperation *)op; 添加依赖，使当前操作依赖于操作 op 的完成。
//- (void)removeDependency:(NSOperation *)op; 移除依赖，取消当前操作对操作 op 的依赖。
//@property (readonly, copy) NSArray<NSOperation *> *dependencies; 在当前操作开始执行之前完成执行的所有操作对象数组。


//NSOperation 提供了queuePriority（优先级）属性，queuePriority属性适用于同一操作队列中的操作，不适用于不同操作队列中的操作。默认情况下，所有新创建的操作对象优先级都是NSOperationQueuePriorityNormal。但是我们可以通过setQueuePriority:方法来改变当前操作在同一队列中的执行优先级。
//对于添加到队列中的操作，首先进入准备就绪的状态（就绪状态取决于操作之间的依赖关系），然后进入就绪状态的操作的开始执行顺序（非结束执行顺序）由操作之间相对的优先级决定（优先级是操作对象自身的属性）

//NSOperation、NSOperationQueue 线程间的通信  通过线程间的通信，先在其他线程中执行操作，等操作执行完了之后再回到主线程执行主线程的相应操作

//NSOperation、NSOperationQueue 常用属性和方法归纳
// NSOperation 常用属性和方法

//取消操作方法
//- (void)cancel; 可取消操作，实质是标记 isCancelled 状态。

//判断操作状态方法
//- (BOOL)isFinished; 判断操作是否已经结束。
//- (BOOL)isCancelled; 判断操作是否已经标记为取消。
//- (BOOL)isExecuting; 判断操作是否正在在运行。
//- (BOOL)isReady; 判断操作是否处于准备就绪状态，这个值和操作的依赖关系相关。

//操作同步
//- (void)waitUntilFinished; 阻塞当前线程，直到该操作结束。可用于线程执行顺序的同步。
//- (void)setCompletionBlock:(void (^)(void))block; completionBlock 会在当前操作执行完毕时执行 completionBlock。
//- (void)addDependency:(NSOperation *)op; 添加依赖，使当前操作依赖于操作 op 的完成。
//- (void)removeDependency:(NSOperation *)op; 移除依赖，取消当前操作对操作 op 的依赖。
//@property (readonly, copy) NSArray<NSOperation *> *dependencies; 在当前操作开始执行之前完成执行的所有操作对象数组。

//NSOperationQueue 常用属性和方法

//取消/暂停/恢复操作
//- (void)cancelAllOperations; 可以取消队列的所有操作。
//- (BOOL)isSuspended; 判断队列是否处于暂停状态。 YES 为暂停状态，NO 为恢复状态。
//- (void)setSuspended:(BOOL)b; 可设置操作的暂停和恢复，YES 代表暂停队列，NO 代表恢复队列。
//操作同步
//- (void)waitUntilAllOperationsAreFinished; 阻塞当前线程，直到队列中的操作全部执行完毕。
//添加/获取操作`
//- (void)addOperationWithBlock:(void (^)(void))block; 向队列中添加一个 NSBlockOperation 类型操作对象。
//- (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait; 向队列中添加操作数组，wait 标志是否阻塞当前线程直到所有操作结束
//- (NSArray *)operations; 当前在队列中的操作数组（某个操作执行结束后会自动从这个数组清除）。
//- (NSUInteger)operationCount; 当前队列中的操作数。
//获取队列
//+ (id)currentQueue; 获取当前队列，如果当前线程不是在 NSOperationQueue 上运行则返回 nil。
//+ (id)mainQueue; 获取主队列。


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.


    //[self communication];

    [self testJianShu];
}

-(void)testJianShu{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 执行完 for 循环，开始执行跌各个添加操作
        [queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            for (int i = 0; i < 2; i++) {
                NSLog(@"2");
            }
        }];

        for (int i = 0; i < 2; i++) {
            NSLog(@"1");
        }
    }];
    //Res:  是 1 1 2 2
    //异步都不会阻塞线程

    //外层block先加入队列， 然后执行外层代码块，代码块中又add新的block加入队列。等外部代码块执行了在执行内部新加入的代码块
    //串行队列是按照加入队列的顺序执行的。
    //我： 嵌套任务怎么知道执行顺序？任务1中有任务2      任务1要执行完，不得等任务2执行完了   分析成死锁了，[表情]
    //我： 串行队列又得先执行任务1再任务2
    //你的任务1中只是把任务2的block加入到队列中  queue是异步的，所以不会堵塞线程
    //queue.maxConcurrentOperationCount 这是最大并发任务数量,与同步异步没有关系,任务1的执行不依赖任务2的完成
    //我： 设置这个就是串行队列    但跟同步异步没关系是吧？
    //兄弟，addOperationWithBlock是异步的，不会互相等待的
    //如果是同步的，任务1的执行就依赖任务2的返回，但是是异步的，任务1并不需要等待任务2的返回
    //串行队列里的异步不会阻塞当前线程
    //主线程就是串行队列，在主线程中dispatch_async（dispatch_get_main_queue, … ）是不会造成死锁的
    //dispatch_sync（dispatch_get_main_queue（）, … ）就会造成死锁了
    //串行同步和串行异步区别就是 添加的任务都是顺序执行，只是异步的时候不用等待任务执行完成去进行其他操作
}

/**
 * 线程间通信
 */
- (void)communication {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1");
        }
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                NSLog(@"2");
            }
        }];
    }];
}

- (void)addDependency {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            //[NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2

    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}

/**
 * 使用子类 NSInvocationOperation
 */
- (void)useInvocationOperation {

    // 1.创建 NSInvocationOperation 对象
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
//
//    // 2.调用 start 方法开始执行操作
//    [op start];

    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 2.调用 start 方法开始执行操作
    [op start];
}

/**
 * 任务1
 */
- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
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
