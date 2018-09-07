//
//  MultPicApplyToTbCells.m
//  GCDTest
//
//  Created by test on 2018/6/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MultPicApplyToTbCells.h"

@implementation MultPicApplyToTbCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)title {
    if(_title== nil) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = [UIColor blueColor];
        _title.numberOfLines = 0;
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.right.mas_equalTo(self);
        }];
    }
    return _title;
}

- (UIImageView *)leftIMV {
    if(_leftIMV== nil) {
        _leftIMV = [[UIImageView alloc] init];
        [self addSubview:_leftIMV];
        [_leftIMV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).offset(0);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo((ScreenW - 40)/3);
            make.height.mas_equalTo((ScreenW - 40)/3);
        }];
    }
    return _leftIMV;
}

- (UIImageView *)midIMV {
    if(_midIMV== nil) {
        _midIMV = [[UIImageView alloc] init];
        [self addSubview:_midIMV];
        [_midIMV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).offset(0);
            make.left.equalTo(self.leftIMV.mas_right).offset(10);
            make.width.mas_equalTo((ScreenW - 40)/3);
            make.height.mas_equalTo((ScreenW - 40)/3);
        }];
    }
    return _midIMV;
}
- (UIImageView *)rightIMV {
    if(_rightIMV== nil) {
        _rightIMV = [[UIImageView alloc] init];
        [self addSubview:_rightIMV];
        [_rightIMV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).offset(0);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo((ScreenW - 40)/3);
            make.height.mas_equalTo((ScreenW - 40)/3);
        }];
    }
    return _rightIMV;
}
- (UILabel *)infos {
    if(_infos== nil) {
        _infos = [[UILabel alloc] init];
        _infos.font = [UIFont systemFontOfSize:14];
        _infos.textColor = [UIColor greenColor];
        _infos.numberOfLines = 0;
        [self addSubview:_infos];
        [_infos mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightIMV.mas_bottom).offset(0);
            make.left.right.bottom.mas_equalTo(self);
        }];
    }
    return _infos;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
