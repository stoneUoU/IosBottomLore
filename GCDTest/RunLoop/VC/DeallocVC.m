//
//  DeallocVC.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "DeallocVC.h"
#import "NSTimer+Pluto.h"
#import "NextVC.h"
#import "STWeakProxy.h"
@interface DeallocVC ()
@property(nonatomic,strong) NSTimer *timer;

@property (strong, nonatomic)   UIButton  *testBtn;  /**< 打印Btn */
@end

@implementation DeallocVC
- (id)init
{
    self = [super init ];//当前对象self
    if (self !=nil)//如果对象初始化成功，才有必要进行接下来的初始化
    {
        _deallocV = [[DeallocV alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 320)]; //对MyUIView进行初始化
        _deallocV.backgroundColor = [UIColor blueColor];
        _deallocV.delegate = self; //将SecondVC自己的实例作为委托对象
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];

    //    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        STLog(@"定时器调用+1");
    //    }];
    //    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            STLog(@"定时器调用+2");
        }];

    //    [NSTimer scheduledTimerWithTimeInterval:1.0
    //                                     target:self
    //                                   selector:@selector(updateTime:)
    //                                   userInfo:nil
    //                                    repeats:YES];   //这样就不会走dealloc方法了

    //[NSTimer stScheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil];
    
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:[STWeakProxy proxyWithTarget:self] selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

-(void)setUI{
    [self.view addSubview:_deallocV];
    _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _testBtn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width-120)/2, 480, 120, 60);
    _testBtn.backgroundColor = [UIColor redColor];
    [_testBtn setTitle:@"跳转界面" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_testBtn addTarget:self action:@selector(toPrint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];
}
-(void)toPrint:(UIButton *)sender{
    //方式一：
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:[[NextVC alloc] init] animated:YES];
    });

}
-(void)updateTime:(NSString *)str{
    STLog(@"定时器调用+3");
}
-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
    STLog(@"88888888888");
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

- (void)toDo {
    STLog(@"77777");
}
@end
