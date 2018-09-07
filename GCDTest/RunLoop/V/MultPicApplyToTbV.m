//
//  MultPicApplyToTbV.m
//  GCDTest
//
//  Created by test on 2018/6/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "MultPicApplyToTbV.h"
#import "MultPicApplyToTbCells.h"
#import "PQRunloop.h"
@implementation MultPicApplyToTbV
- (id)init
{
    // 情景二：采用网络图片实现
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64) style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.estimatedSectionHeaderHeight = 100;
    _tableV.estimatedSectionFooterHeight = 100;
    _tableV.estimatedRowHeight = 100;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[MultPicApplyToTbCells class] forCellReuseIdentifier: @"multPicApplyToTbCells"];
    // 马上进入刷新状态
    [self addSubview:_tableV];
}

// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    return headerV;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.000001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MultPicApplyToTbCells *Cell = [tableView dequeueReusableCellWithIdentifier:@"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    multPicApplyToTbCells"];
    if (!Cell){
        Cell = [[MultPicApplyToTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"multPicApplyToTbCells"];
    }
    //先赋值将要显示的indexPath
    Cell.willShowIndexpath = indexPath;
    //Cell.title.text = [NSString stringWithFormat:@"%zd - Runloop性能优化：一次绘制一张图片。", indexPath.row];
    // 使用优化
//    [[PQRunloop shareInstance] addTask:^BOOL{
//        if (![Cell.willShowIndexpath isEqual:indexPath]) {
//            return NO;
//        }
//        Cell.leftIMV.image = [UIImage imageNamed:@"spaceship"];
//        return YES;
//    } withId:indexPath];
//
//    [[PQRunloop shareInstance] addTask:^BOOL{
//        if (![Cell.willShowIndexpath isEqual:indexPath]) {
//            return NO;
//        }
//        Cell.midIMV.image = [UIImage imageNamed:@"spaceship"];
//        return YES;
//    } withId:indexPath];
//
//    [[PQRunloop shareInstance] addTask:^BOOL{
//        if (![Cell.willShowIndexpath isEqual:indexPath]) {
//            return NO;
//        }
//        Cell.rightIMV.image = [UIImage imageNamed:@"spaceship"];
//        return YES;
//    } withId:indexPath];
//    Cell.infos.text =  [NSString stringWithFormat:@"%zd - 在Runloop中一次循环绘制所有的点，这里显示加载大图，使得绘制的点增多，从而导致Runloop的点一次循环时间增长，从而导致UI卡顿。", indexPath.row];

    Cell.title.text = [NSString stringWithFormat:@"%zd - Runloop性能优化：一次绘制一张图片。", indexPath.row];
//    Cell.leftIMV.image = [UIImage imageNamed:@"spaceship"];
//    Cell.midIMV.image = [UIImage imageNamed:@"spaceship"];
//    Cell.rightIMV.image = [UIImage imageNamed:@"spaceship"];
    Cell.infos.text =  [NSString stringWithFormat:@"%zd - 在Runloop中一次循环绘制所有的点，这里显示加载大图，使得绘制的点增多，从而导致Runloop的点一次循环时间增长，从而导致UI卡顿。", indexPath.row];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *imgDatas = [NSDictionary dictionaryWithObjectsAndKeys:
                                  indexPath, @"indexPath",
                                  @"spaceship",@"imageStr",
                                  nil];
        [self performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:imgDatas waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];


    });

    //[NSThread detachNewThreadSelector:@selector(startNetR:) toTarget:self withObject:indexPath]; // 获取图片
    return Cell;
}

-(void)startNetR:(NSIndexPath *)indexPath{
    NSDictionary *imgDatas = [NSDictionary dictionaryWithObjectsAndKeys:
                                indexPath, @"indexPath",
                                @"spaceship",@"imageStr",
                                nil];
    [self performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:imgDatas waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];


}

-(void)setImage:(id)imgDatas{
    MultPicApplyToTbCells *Cell = [_tableV cellForRowAtIndexPath:[imgDatas objectForKey:@"indexPath"]];
    //__weak typeof(self)weakSelf = self;
    Cell.leftIMV.image = [UIImage imageNamed:[imgDatas objectForKey:@"imageStr"]];
    Cell.midIMV.image = [UIImage imageNamed:[imgDatas objectForKey:@"imageStr"]];
    Cell.rightIMV.image = [UIImage imageNamed:[imgDatas objectForKey:@"imageStr"]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate toDo];
}

@end
