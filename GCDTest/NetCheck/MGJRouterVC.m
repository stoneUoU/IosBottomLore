//
//  MGJRouterVC.m
//  GCDTest
//
//  Created by test on 2018/7/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MGJRouterVC.h"

@interface MGJRouterVC ()

@end

@implementation MGJRouterVC
-(instancetype)init{
    self = [super init ];//当前对象self
    if (self !=nil){//如果对象初始化成功，才有必要进行接下来的初始化
        [MGJRouter registerURLPattern:@"mgj://market/detail?id=:id&&demoID=:demoID" toHandler:^(NSDictionary *routerParams) {
//            DeallocVC *deallocV = [[DeallocVC alloc]init];
//            deallocV.pass_vals = routerParams;
//            [MethodFunc pushToNextVC:self destVC:deallocV];
        }];
        [MGJRouter registerURLPattern:@"mgj://uiView" toObjectHandler:^id(NSDictionary *routerParams) {
            UIView *uiView = [[UIView alloc] init];
            return uiView;
        }];
        [MGJRouter registerURLPattern:@"mgj://market/demo" toHandler:^(NSDictionary *routerParas) {
            STLog(@"%@",[NSString stringWithFormat:@"%@", [[routerParas objectForKey:@"MGJRouterParameterUserInfo"] objectForKey:@"user_name"]]);
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *demoV = [MGJRouter objectForURL:@"mgj://uiView"];
    demoV.backgroundColor = [UIColor redColor];
    STLog(@"%@",_pass_vals[@"林磊"]);
    [self.view addSubview:demoV];
    [demoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(ScreenW);
    }];
    //[MGJRouter openURL:@"mgj://market/detail?id=7&&demoID=林磊"];
    //[MGJRouter openURL:@"mgj://market/demo" withUserInfo:@{@"user_name": @"林磊"} completion:nil];
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
