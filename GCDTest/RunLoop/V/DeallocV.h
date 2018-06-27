//
//  DeallocV.h
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeallocVDel
- (void)toDo;
@end
@interface DeallocV : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    //id<DeallocVDel> _delegate; //这个定义会在后面的解释，它是一个协议，用来实现委托。
}
@property (nonatomic ,weak)id<DeallocVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIImageView *logoIMV;

@end
