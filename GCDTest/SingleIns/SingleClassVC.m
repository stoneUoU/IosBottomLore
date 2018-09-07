//
//  SingleClassVC.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SingleClassVC.h"

@interface SingleClassVC ()

@end

@implementation SingleClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    SingleClass *singleCls1 = [SingleClass shareIns];
    SingleClass *singleCls2 = [SingleClass shareIns];
    SingleClass *singleCls3 = [SingleClass shareIns];
    STLog(@"%@",singleCls1);
    STLog(@"%@",singleCls2);
    STLog(@"%@",singleCls3);

    UIView *uiView1 = [[UIView alloc] init];
    UIView *uiView2 = [[UIView alloc] init];
    UIView *uiView3 = [[UIView alloc] init];
    STLog(@"%@",uiView1);
    STLog(@"%@",uiView2);
    STLog(@"%@",uiView3);
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
