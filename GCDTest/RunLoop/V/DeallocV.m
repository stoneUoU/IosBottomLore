//
//  DeallocV.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "DeallocV.h"

@implementation DeallocV
- (id)init
{
    // 情景二：采用网络图片实现
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _logoIMV = [[UIImageView alloc] initWithFrame:CGRectMake(40, 120, 120, 60)];
    _logoIMV.image = [UIImage imageNamed:@"home_pic_guaguagou"];
    [self addSubview:_logoIMV];
}

//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toDo ];
}

@end

