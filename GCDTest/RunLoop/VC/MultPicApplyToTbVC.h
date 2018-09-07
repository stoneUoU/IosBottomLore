//
//  MultPicApplyToTbVC.h
//  GCDTest
//
//  Created by test on 2018/6/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultPicApplyToTbV.h"
@interface MultPicApplyToTbVC : UIViewController<MultPicApplyToTbVDel>

@property (nonatomic,strong)MultPicApplyToTbV *multPicApplyToTbV; //将strong 改成-> weak  会在页面销毁时走dealloc方法

@end
