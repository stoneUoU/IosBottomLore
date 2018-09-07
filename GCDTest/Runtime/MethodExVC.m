//
//  MethodExVC.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MethodExVC.h"
#import "UIImage+change_m.h"
@interface MethodExVC ()

@end

@implementation MethodExVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    UIImageView *IMV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW - 200)/2, (ScreenH - 200)/2, 200, 200)];
    IMV.image = [UIImage imageNamed:@"appUpdate_bg"];
    [self.view addSubview:IMV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
