//
//  MultPicApplyToTbVC.m
//  GCDTest
//
//  Created by test on 2018/6/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MultPicApplyToTbVC.h"

#import "DeallocVC.h"

@interface MultPicApplyToTbVC ()
@end

@implementation MultPicApplyToTbVC
- (id)init
{
    self = [super init ];//当前对象self
    if (self !=nil)//如果对象初始化成功，才有必要进行接下来的初始化
    {
        _multPicApplyToTbV = [[MultPicApplyToTbV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)]; //对MyUIView进行初始化
        _multPicApplyToTbV.backgroundColor = [UIColor blueColor];
        _multPicApplyToTbV.delegate = self; //将SecondVC自己的实例作为委托对象
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];


}

-(void)setUI{
    [self.view addSubview:_multPicApplyToTbV];

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
