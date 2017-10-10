//
//  TextViewController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/13.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "TextViewController.h"
#import <BabyBluetooth/BabyBluetooth.h>
#import "ConnectVIewController.h"
#import "AppDelegate.h"
#import "ChangeLanguage.h"


@interface TextViewController ()

@property (nonatomic, strong) UIImageView *logo;

@property (nonatomic, strong) BabyBluetooth *blue;
@property (nonatomic, weak) CBPeripheral *peripheral;

@property (nonatomic, strong) UIButton *LaunchBtn;
@property (nonatomic, strong) UIButton *LaunchBtnZ;

@property (nonatomic, strong) UIButton *LaunchBtne;
@property (nonatomic, strong) UIButton *LaunchBtnE;

@property (nonatomic, strong) UIButton *SysLaunchBtn;

@property (nonatomic, strong) UIButton *NextBtn;
@property (nonatomic, strong) UIButton *NextBtnZ;


@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化应用语言
    [ChangeLanguage initUserLanguage];
    // 添加UI
    [self addUI];
    // 添加语言
    [self addLangua];
    // 添加初始完毕的控件
    [self.view addSubview:self.logo];
    [self.view addSubview:self.LaunchBtn];
    [self.view addSubview:self.LaunchBtnZ];
    [self.view addSubview:self.LaunchBtne];
    [self.view addSubview:self.LaunchBtnE];
    [self.view addSubview:self.NextBtn];
    [self.view addSubview:self.SysLaunchBtn];
    [self.view addSubview:self.NextBtnZ];
    
   
//    self.blue = [BabyBluetooth shareBabyBluetooth];
//    [self babyDelegate];
//    [self okConnect];
//    [self readAndWriteCharacteristics];
//    self.blue.scanForPeripherals().begin();
    
}
//添加UI
-(void)addUI{
    
    // logo
    self.logo = [[UIImageView alloc] init];
    self.logo.image = GetImage(@"logo");
    self.logo.frame = CGRectMake(kScreen_CenterX-145/2, kScreen_CenterY-250, 145, 145);
    
    // 语言按钮
    self.LaunchBtn = [[UIButton alloc] init];
    self.LaunchBtn.frame = CGRectMake(kScreen_CenterX-kScreen_Width/3, self.logo.frame.origin.y+145+50, kScreen_Width/3*2, 57);
    [self.LaunchBtn setImage:GetImage(@"biankuang") forState:UIControlStateNormal];
    
    // 语言按钮
    self.LaunchBtnZ = [[UIButton alloc] init];
    self.LaunchBtnZ.frame = CGRectMake(kScreen_CenterX-kScreen_Width/3, self.logo.frame.origin.y+145+50, kScreen_Width/3*2, 57);
    [self.LaunchBtnZ addTarget:self action:@selector(setChinese) forControlEvents:UIControlEventTouchUpInside];
    
    // 语言按钮
    self.LaunchBtne = [[UIButton alloc] init];
    self.LaunchBtne.frame = CGRectMake(kScreen_CenterX-kScreen_Width/3, self.LaunchBtn.frame.origin.y+70, kScreen_Width/3*2, 57);
    [self.LaunchBtne setImage:GetImage(@"biankuang") forState:UIControlStateNormal];
    
    // 语言按钮
    self.LaunchBtnE = [[UIButton alloc] init];
    self.LaunchBtnE.frame = CGRectMake(kScreen_CenterX-kScreen_Width/3, self.LaunchBtn.frame.origin.y+70, kScreen_Width/3*2, 57);
    [self.LaunchBtnE addTarget:self action:@selector(setEnglish) forControlEvents:UIControlEventTouchUpInside];
    
    // 下一步按钮
    self.NextBtn = [[UIButton alloc] init];
    self.NextBtn.frame = CGRectMake(kScreen_CenterX-kScreen_Width/3, kScreen_Height-157, kScreen_Width/3*2, 57);
    [self.NextBtn setImage:GetImage(@"anniu") forState:UIControlStateNormal];
    
    // 选择语言按钮
    self.SysLaunchBtn = [[UIButton alloc] init];
    self.SysLaunchBtn.frame = CGRectMake(0, self.LaunchBtn.frame.origin.y-57, kScreen_Width, 57);
    [self.SysLaunchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.SysLaunchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    // 选择语言按钮
    self.NextBtnZ = [[UIButton alloc] init];
    self.NextBtnZ.frame = CGRectMake(kScreen_CenterX-kScreen_Width/3, kScreen_Height-157, kScreen_Width/3*2, 57);

    [self.NextBtnZ addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    [self.LaunchBtnZ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.LaunchBtnE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

// 添加语言
-(void)addLangua{
    // 获取当前设备语言
    [self.SysLaunchBtn setTitle:[[ChangeLanguage bundle] localizedStringForKey:@"chooseLaunch" value:nil table:@"Localizable"] forState:UIControlStateNormal];
    [self.NextBtnZ setTitle:[[ChangeLanguage bundle] localizedStringForKey:@"next" value:nil table:@"Localizable"] forState:UIControlStateNormal];
    [self.LaunchBtnZ setTitle:[[ChangeLanguage bundle] localizedStringForKey:@"Chinese" value:nil table:@"Localizable"] forState:UIControlStateNormal];
    [self.LaunchBtnE setTitle:[[ChangeLanguage bundle] localizedStringForKey:@"English" value:nil table:@"Localizable"] forState:UIControlStateNormal];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}

// 设置导航栏背景色
- (UIColor *)set_colorBackground
{
    return [UIColor clearColor];
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

//-(NSMutableAttributedString *)setTitle{
//    return [self changeTitle:@"666"];
//}

#pragma mark - btn事件 -
// 切换中文
-(void)setChinese{
    
    //修改语言
    NSString *language = [ChangeLanguage userLanguage];
    if ([language isEqualToString:@"en"]) {
        [ChangeLanguage setUserlanguage:@"zh-Hans"];
        [self addLangua];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ENGLISH" object:nil userInfo:nil];
    }else{
        return;
    }
}
// 切换英文
-(void)setEnglish{
    
    //修改语言
    NSString *language = [ChangeLanguage userLanguage];
    if ([language isEqualToString:@"en"]) {
        return;
    }else{
        [ChangeLanguage setUserlanguage:@"en"];
        [self addLangua];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CHINESE" object:nil userInfo:nil];
    }
}

#pragma mark - 自定义代码 -
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
}

// 下一步 弹出连接界面
-(void)nextStep{
    
    ConnectVIewController *vc = [[ConnectVIewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

//-(void)babyDelegate {
//    //设置扫描到设备的委托
//    __block TextViewController *blockSelf = self;
//    
//    [self.blue setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
//        NSLog(@"搜索到了设备:%@",peripheral.name);
//        if ([peripheral.name hasPrefix:@"LE"]) {
//            NSLog(@"找到测试蓝牙");
//            blockSelf.peripheral = peripheral;
//            blockSelf.blue.having(blockSelf.peripheral).connectToPeripherals().begin();
//        }
//    }];
//}
//
//-(void)okConnect{
//    [self.blue setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
//        NSLog(@"设备：%@--连接成功",peripheral.name);
//    }];
//}
//
//-(void)readAndWriteCharacteristics{
//    [self.blue setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
//        NSLog(@"%@",peripheral.name);
//        NSLog(@"%@",service.UUID);
//
//    }];
//}

- (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
