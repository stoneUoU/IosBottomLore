//
//  NetCheckVC.m
//  GCDTest
//
//  Created by test on 2018/6/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "NetCheckVC.h"

@interface NetCheckVC ()
@property (strong, nonatomic)   UIButton  *testBtn;  /**< 打印Btn */
@property (strong, nonatomic)   UILabel  *testLab;  /**< 打印Btn */

@property (strong, nonatomic)   UILabel  *test24Lab;  /**< 打印Btn */
@end

@implementation NetCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _testBtn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width-120)/2, 450, 120, 60);
    _testBtn.backgroundColor = [UIColor redColor];
    [_testBtn setTitle:@"打印" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_testBtn addTarget:self action:@selector(toPrint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];

    _testLab = [[UILabel alloc] init];
    _testLab.text = @"测试测试测试";
    _testLab.font = [UIFont systemFontOfSize:16];
    _testLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:_testLab];
    [_testLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.mas_equalTo(15);
    }];

    _test24Lab = [[UILabel alloc] init];
    _test24Lab.text = @"测试测试测试";
    _test24Lab.font = [UIFont systemFontOfSize:24];
    _test24Lab.backgroundColor = [UIColor redColor];
    [self.view addSubview:_test24Lab];
    [_test24Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.mas_equalTo(15);
    }];
}
-(void)toPrint:(UIButton *)sender{
    //[HudTips showToast: ([NetCheckTools sharedIns].isNetUseful?@"有网":@"无网") showType:StToastShowTypeTop animationType:StToastAnimationTypeScale];
    UIViewController *vc = [[CTMediator sharedInstance] st_mediator_toVCWithParams:@{@"林磊":@"林磊"}];
    //[self.navigationController pushViewController:vc animated:YES];
    [MethodFunc pushToNextVC:self destVC:vc];
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
