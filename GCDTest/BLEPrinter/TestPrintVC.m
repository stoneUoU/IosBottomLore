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
    _testBtn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width-120)/2, 450, 120, 60);
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
    NSString *title = @"有路科技";
    NSString *str1 = @"江西省有路科技有限公司";
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    //    [printer appendBarCodeWithInfo:@"RN3456789012"];
    //    [printer appendSeperatorLine];
    //
    //    [printer appendTitle:@"时间:" value:@"2016-04-27 10:01:50" valueOffset:150];
    //    [printer appendTitle:@"订单:" value:@"4000020160427100150" valueOffset:150];
    //    [printer appendText:@"地址:深圳市南山区学府路东深大店" alignment:HLTextAlignmentLeft];
    [printer appendSeperatorLine];
    [printer appendLeftText:@"商品" middleText:@"数量" rightText:@"单价" isTitle:YES];
    CGFloat total = 0.0;
    NSDictionary *dict1 = @{@"name":@"Macbook Pro 13.3寸",@"amount":@"5",@"price":@"8888.00"};
    NSDictionary *dict2 = @{@"name":@"我是林磊，了解一下",@"amount":@"1",@"price":@"1.0"};
    NSArray *goodsArray = @[dict1, dict2];
    for (NSDictionary *dict in goodsArray) {
        [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
        total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
    }
    [printer appendSeperatorLine];
    NSString *totalStr = [NSString stringWithFormat:@"%.2f",total];
    [printer appendTitle:@"总计:" value:totalStr];
    [printer appendTitle:@"实收:" value:@"100.00"];
    NSString *leftStr = [NSString stringWithFormat:@"%.2f",100.00 - total];
    [printer appendTitle:@"找零:" value:leftStr];

    //    [printer appendSeperatorLine];
    //
    //    [printer appendText:@"位图方式二维码" alignment:HLTextAlignmentCenter];
    //    [printer appendQRCodeWithInfo:@"www.baidu.com"];
    //
    //    [printer appendSeperatorLine];
    //    [printer appendText:@"指令方式二维码" alignment:HLTextAlignmentCenter];
    //    [printer appendQRCodeWithInfo:@"www.baidu.com" size:10];
    //
    //    [printer appendFooter:nil];
    //    [printer appendImage:[UIImage imageNamed:@"ico180"] alignment:HLTextAlignmentCenter maxWidth:300];

    // 你也可以利用UIWebView加载HTML小票的方式，这样可以在远程修改小票的样式和布局。
    // 注意点：需要等UIWebView加载完成后，再截取UIWebView的屏幕快照，然后利用添加图片的方法，加进printer
    // 截取屏幕快照，可以用UIWebView+UIImage中的catogery方法 - (UIImage *)imageForWebView

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
