//
//  ConnectVIew.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/20.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "ConnectVIew.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface ConnectVIew()

// 拖动手势
@property (nonatomic, strong) UIPanGestureRecognizer *panGP;
// 箭头最小y轴位置
@property (nonatomic, assign) CGFloat minY;
// timer
@property (nonatomic,strong)NSTimer *timer;
// 黑点亮的顺序
@property (nonatomic, assign) int num;

@end

@implementation ConnectVIew


-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.num = 0;
        
        [self setupUi];
        
        self.panGP = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self.huadongImage setUserInteractionEnabled:YES];
        [self.huadongImage addGestureRecognizer:self.panGP];
        
    }
    
    return self;
    
}

-(void)setupUi{
    // 左上角logo
    self.logo = [[UIImageView alloc] init];
    self.logo.frame = CGRectMake(20, 40, 80, 80);
    self.logo.image = GetImage(@"logo");
    
    self.deviceLab = [[UILabel alloc] init];
    self.deviceLab.text = @"PMS6016-a8d8";
    self.deviceLab.textAlignment = NSTextAlignmentCenter;
    self.deviceLab.font = [UIFont systemFontOfSize:14];
    
    self.erjilogo = [[UIImageView alloc] init];
    self.erjilogo.image = GetImage(@"Headset_pic");
    
    self.huadongImage = [[UIImageView alloc] init];
    self.huadongImage.image = GetImage(@"JianTou");
    
    self.tuodongLab = [[UILabel alloc] init];
    self.tuodongLab.text = NSLocalizedString(@"tuodongyilianjie", nil);
    self.tuodongLab.textAlignment = NSTextAlignmentCenter;
    self.tuodongLab.font = [UIFont systemFontOfSize:14];
    
    self.lanya = [[UIImageView alloc] init];
    self.lanya.image = GetImage(@"Bluetooth_ico");
    
    self.hei1 = [[UIImageView alloc] init];
    self.hei1.image = GetImage(@"Gray_point-2");
    
    self.hei2 = [[UIImageView alloc] init];
    self.hei2.image = GetImage(@"Gray_point-2");
    
    self.hei3 = [[UIImageView alloc] init];
    self.hei3.image = GetImage(@"Gray_point-2");
    
    self.hei4 = [[UIImageView alloc] init];
    self.hei4.image = GetImage(@"Gray_point-2");
    
    self.hei5 = [[UIImageView alloc] init];
    self.hei5.image = GetImage(@"Gray_point-2");
    
    self.hei6 = [[UIImageView alloc] init];
    self.hei6.image = GetImage(@"Gray_point-2");

    
    
    [self addSubview:self.logo];
    [self addSubview:self.deviceLab];
    [self addSubview:self.erjilogo];
    [self addSubview:self.huadongImage];
    [self addSubview:self.tuodongLab];
    [self addSubview:self.lanya];
    [self addSubview:self.hei1];
    [self addSubview:self.hei2];
    [self addSubview:self.hei3];
    [self addSubview:self.hei4];
    [self addSubview:self.hei5];
    [self addSubview:self.hei6];
    

    
    // 添加约束
    [self addLayout];
}

-(void)addLayout{
    
    // deviceLab
    [self.deviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logo);
        make.width.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.erjilogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(self.erjilogo.mas_width).multipliedBy(1.1);
    }];
    
    [self.huadongImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.erjilogo.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(33);
    }];
    
    [self.tuodongLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        
    }];
    
    [self.lanya mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.erjilogo.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(27);
    }];
    
    [self.hei1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lanya.mas_left).offset(-10);
        make.centerY.equalTo(self.lanya);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    
    [self.hei2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.hei1.mas_left).offset(-10);
        make.centerY.equalTo(self.lanya);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    
    [self.hei3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.hei2.mas_left).offset(-10);
        make.centerY.equalTo(self.lanya);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    
    [self.hei4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lanya.mas_right).offset(10);
        make.centerY.equalTo(self.lanya);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    
    [self.hei5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hei4.mas_right).offset(10);
        make.centerY.equalTo(self.lanya);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    
    [self.hei6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hei5.mas_right).offset(10);
        make.centerY.equalTo(self.lanya);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
}

//平移手势的回调方法
- (void)panAction:(UIPanGestureRecognizer*)sender{
    //得到当前手势所在视图
    
    CGPoint point = [sender translationInView:self];
//    sender.view.center = CGPointMake(sender.view.center.x + point.x, sender.view.center.y + point.y);
//    [sender setTranslation:CGPointMake(0, 0) inView:self];
//    
    

//    CGPoint newCenter = CGPointMake(sender.view.center.x+ point.x,
//                                    sender.view.center.y + point.y);//    限制屏幕范围：
//    newCenter.y = MAX(sender.view.frame.size.height/2, newCenter.y);
//    newCenter.y = MIN(self.frame.size.height - sender.view.frame.size.height/2,  newCenter.y);
//    newCenter.x = MAX(sender.view.frame.size.width/2, newCenter.x);
//    newCenter.x = MIN(self.frame.size.width - sender.view.frame.size.width/2,newCenter.x);
//    sender.view.center = newCenter;
    
    CGPoint newCenter = CGPointMake(sender.view.center.x+ point.x,
                                    sender.view.center.y + point.y);//    限制屏幕范围：
    
    if (self.minY <= 0) {
        self.minY = self.huadongImage.center.y;
    }

    newCenter.y = MAX(self.minY, newCenter.y);
    newCenter.y = MIN(self.frame.size.height - sender.view.frame.size.height/2,  newCenter.y);
    
//    newCenter.y

    newCenter.x = MAX(sender.view.center.x, newCenter.x);
    newCenter.x = MIN(sender.view.center.x,newCenter.x);
    sender.view.center = newCenter;
    
    [sender setTranslation:CGPointZero inView:self];
}

#pragma mark - test - 
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.num == 0) {
        self.timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(connectAnima) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }else{
        self.num = 0;
        [self.timer invalidate];
    }
    
    
}
-(void)connectAnima{
    if (self.num==0) {
        self.hei3.image = GetImage(@"Black_point02");
        self.num = 1;
        self.hei2.image = GetImage(@"Gray_point-2");
        self.hei1.image = GetImage(@"Gray_point-2");
        self.hei4.image = GetImage(@"Gray_point-2");
        self.hei5.image = GetImage(@"Gray_point-2");
        self.hei6.image = GetImage(@"Gray_point-2");
    }else if (self.num==1){
        self.hei2.image = GetImage(@"Black_point02");
        self.num = 2;
        self.hei1.image = GetImage(@"Gray_point-2");
        self.hei3.image = GetImage(@"Gray_point-2");
        self.hei4.image = GetImage(@"Gray_point-2");
        self.hei5.image = GetImage(@"Gray_point-2");
        self.hei6.image = GetImage(@"Gray_point-2");
    }else if (self.num==2){
        self.hei1.image = GetImage(@"Black_point02");
        self.num = 3;
        self.hei2.image = GetImage(@"Gray_point-2");
        self.hei3.image = GetImage(@"Gray_point-2");
        self.hei4.image = GetImage(@"Gray_point-2");
        self.hei5.image = GetImage(@"Gray_point-2");
        self.hei6.image = GetImage(@"Gray_point-2");
    }else if (self.num==3){
        self.hei4.image = GetImage(@"Black_point02");
        self.num = 4;
        self.hei2.image = GetImage(@"Gray_point-2");
        self.hei3.image = GetImage(@"Gray_point-2");
        self.hei1.image = GetImage(@"Gray_point-2");
        self.hei5.image = GetImage(@"Gray_point-2");
        self.hei6.image = GetImage(@"Gray_point-2");
    }else if (self.num==4){
        self.hei5.image = GetImage(@"Black_point02");
        self.num = 5;
        self.hei2.image = GetImage(@"Gray_point-2");
        self.hei3.image = GetImage(@"Gray_point-2");
        self.hei4.image = GetImage(@"Gray_point-2");
        self.hei1.image = GetImage(@"Gray_point-2");
        self.hei6.image = GetImage(@"Gray_point-2");
    }else if (self.num==5){
        self.hei6.image = GetImage(@"Black_point02");
        self.num = 6;
        self.hei2.image = GetImage(@"Gray_point-2");
        self.hei3.image = GetImage(@"Gray_point-2");
        self.hei4.image = GetImage(@"Gray_point-2");
        self.hei5.image = GetImage(@"Gray_point-2");
        self.hei1.image = GetImage(@"Gray_point-2");
    }
    else if (self.num==6){
        self.hei3.image = GetImage(@"Black_point02");
        self.num = 1;
        self.hei2.image = GetImage(@"Gray_point-2");
        self.hei1.image = GetImage(@"Gray_point-2");
        self.hei4.image = GetImage(@"Gray_point-2");
        self.hei5.image = GetImage(@"Gray_point-2");
        self.hei6.image = GetImage(@"Gray_point-2");
    }
    
}



@end
