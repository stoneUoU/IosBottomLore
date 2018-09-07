//
//  TestPrintVC.m
//  GCDTest
//
//  Created by test on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "TestPrintVC.h"
#import "SEPrinterManager.h"
@interface TestPrintVC ()
@property (strong, nonatomic)   NSArray  *deviceArr;  /**< 蓝牙设备个数 */
@property (strong, nonatomic)   UITableView  *tableV;  /**< tableV */
@property (strong, nonatomic)   UIButton  *testBtn;  /**< 打印Btn */
@end

@implementation TestPrintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    SEPrinterManager *_manager = [SEPrinterManager sharedInstance];
    [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
        self.deviceArr = perpherals;
        [self.tableV reloadData];
    } failure:^(SEScanError error) {
        NSLog(@"error:%ld",(long)error);
    }];
}
-(void)setUI{
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 400) style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier: @"uITableViewCell"];
    [self.view addSubview:_tableV];

    _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _testBtn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width-120)/2, 450, 300, 60);
    _testBtn.backgroundColor = [UIColor redColor];
    [_testBtn setTitle:@"打印" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_testBtn addTarget:self action:@selector(toPrint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];

    [self.view bringSubviewToFront:_testBtn];
}


-(void)toPrint:(UIButton *)sender{
    //方式一：
    HLPrinter *printer = [self getPrinter];

    NSData *mainData = [printer getFinalData];
    [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
        NSLog(@"写入结：%d---错误:%@",completion,error);
    }];
}
- (HLPrinter *)getPrinter
{
    HLPrinter *printer = [[HLPrinter alloc] init];
    [printer appendText:@"收据" alignment:HLTextAlignmentCenter];
    [printer appendNewLine];
    NSString *title = @"呱呱购订单";
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    [printer appendSeperatorLine];
    [printer appendLeftText:@"数量" middleText:@"产品" rightText:@"总计" isTitle:YES];
    [printer appendSeperatorLine];
    CGFloat total = 0.0;
    NSDictionary *dict1 = @{@"name":@"Macbook Pro 13.3寸",@"amount":@"5",@"price":@"8888.00"};
    NSDictionary *dict2 = @{@"name":@"我是林磊，了解一下我是林磊，了解一下我是林磊，了解",@"amount":@"1",@"price":@"26.00"};
    NSArray *goodsArray = @[dict1, dict2];
    for (NSDictionary *dict in goodsArray) {
        [printer appendLeftText:dict[@"amount"] middleText:dict[@"name"] rightText:dict[@"price"] isTitle:NO];
        total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
    }
    [printer appendTitle:@"总计:" value:@"40.00"];
    [printer appendNewLine];
    [printer appendText:@"订单明细" alignment:HLTextAlignmentCenter];
    [printer appendNewLine];
    [printer appendTitle:@"支付金额:" value:@"26.00"];
    [printer appendTitle:@"支付方式:" value:@"微信支付"];
    [printer appendTitle:@"订单编号:" value:@"3180523120800905637" valueOffset:150];
    [printer appendTitle:@"操作员:" value:@"张安民"];
    [printer appendNewLine];
    [printer appendSeperatorLine];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendText:@"欢迎你再次光临！" alignment:HLTextAlignmentCenter];
    [printer appendNewLine];
    [printer appendText:@"客服电话" alignment:HLTextAlignmentCenter];
    [printer appendNewLine];
    [printer appendText:@"400-5555-666" alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendFooter:nil];

    return printer;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"uITableViewCell"];
    }

    CBPeripheral *peripherral = [self.deviceArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBPeripheral *peripheral = [self.deviceArr objectAtIndex:indexPath.row];

    [[SEPrinterManager sharedInstance] connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (error) {
            STLog(@"连接失败");
        } else {
            STLog(@"连接成功");
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
