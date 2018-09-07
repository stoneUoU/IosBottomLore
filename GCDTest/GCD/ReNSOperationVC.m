//
//  ReNSOperationVC.m
//  GCDTest
//
//  Created by test on 2018/6/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "ReNSOperationVC.h"

@interface ReNSOperationVC ()

@end

@implementation ReNSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self testJianShu];
}
-(void)testJianShu{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;   //串行队列  //如果将NSOperation添加到NSOperationQueue（操作队列）中，系统会自动异步执行NSOperation中的操作  串行+异步 开一条线程
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 执行完 for 循环，开始执行跌各个添加操作
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
    STLog(@"%@",[NSThread currentThread]);

    // 1.创建 NSInvocationOperation 对象
//    NSInvocationOperation *oprate = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
//
//    // 2.调用 start 方法开始执行操作
//    [oprate start];

//    NSBlockOperation * operate = [NSBlockOperation blockOperationWithBlock:^{
//        // 在主线程
//        STLog(@"同步，在主线程中------%@", [NSThread currentThread]);
//    }];
//    [operate addExecutionBlock:^{
//        STLog(@"%@", [NSThread currentThread]);  //这些操作（包括 blockOperationWithBlock 中的操作）可以在不同的线程中同时（并发）执行
//    }];
//    [operate start];

    // - 凡是添加到主队列中的任务（NSOperation），都会放到主线程中执行 [NSOperationQueue mainQueue];
    // 同时包含了：串行、并发功能 - 添加到这种队列中的任务（NSOperation），就会自动放到子线程中执行 [[NSOperationQueue alloc] init]
//    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 1;
//    for ( int i= 0 ; i<100; i++){
//        [queue addOperationWithBlock:^{
//            STLog(@"异步，开启新线程------%@", [NSThread currentThread]);
//        }];
//        //异步 串行只能保证 任务是顺序执行的，至于在哪个线程执行 队列内部有调度机制
//    }
    //即使设置 最大并发操作数 设置为1，也不一定只是开启一条线程。
    //一个操作并不一定是在同一个线程里执行的。
    //就会出现你上边代码中的结果


//    NSBlockOperation * opr = [NSBlockOperation blockOperationWithBlock:^{
//        // 在主线程
//        STLog(@"异步，开启新线程------%@", [NSThread currentThread]);
//    }];
//    [queue addOperation:opr];


}

-(void)test{
    STLog(@"%@",[NSThread currentThread]);
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
