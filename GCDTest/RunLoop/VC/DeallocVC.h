//
//  DeallocVC.h
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeallocV.h"
@interface DeallocVC : UIViewController<DeallocVDel>

@property (nonatomic,strong)DeallocV *deallocV; //将strong 改成-> weak  会在页面销毁时走dealloc方法

@end
