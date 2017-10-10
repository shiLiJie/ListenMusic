//
//  HelpView.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/20.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "HelpView.h"
#import "Masonry.h"

@implementation HelpView

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUi];
    }
    
    return self;
    
}

-(void)setupUi{
    
    // 左上角logo
    self.logo = [[UIImageView alloc] init];
    self.logo.frame = CGRectMake(20, 40, 80, 80);
    self.logo.image = GetImage(@"logo");
    
    self.helpLab = [[UILabel alloc] init];
    self.helpLab.text = NSLocalizedString(@"help", nil);
    self.helpLab.textAlignment = NSTextAlignmentCenter;
    self.helpLab.font = [UIFont systemFontOfSize:18];
    
    self.goumaiBtn = [[UIButton alloc] init];
    [self.goumaiBtn setTitle:NSLocalizedString(@"goumai", nil) forState:UIControlStateNormal];
    [self.goumaiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goumaiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    self.weilianjieLab = [[UILabel alloc] init];
    self.weilianjieLab.text = NSLocalizedString(@"weilianjieshebei", nil);
    self.weilianjieLab.textAlignment = NSTextAlignmentCenter;
    self.weilianjieLab.font = [UIFont systemFontOfSize:20];
    
    self.LabOne = [[UILabel alloc] init];
    self.LabOne.text = NSLocalizedString(@"①lab1", nil);
    self.LabOne.textAlignment = NSTextAlignmentLeft;
    self.LabOne.font = [UIFont systemFontOfSize:16];
    self.LabOne.numberOfLines = 0;
    
    self.LabTwo = [[UILabel alloc] init];
    self.LabTwo.text = NSLocalizedString(@"②lab1", nil);
    self.LabTwo.textAlignment = NSTextAlignmentLeft;
    self.LabTwo.font = [UIFont systemFontOfSize:16];
    self.LabTwo.numberOfLines = 0;
    
    self.LabThree = [[UILabel alloc] init];
    self.LabThree.text = NSLocalizedString(@"③lab1", nil);
    self.LabThree.textAlignment = NSTextAlignmentLeft;
    self.LabThree.font = [UIFont systemFontOfSize:16];
    self.LabThree.numberOfLines = 0;
    
    
    
    [self addSubview:self.logo];
    [self addSubview:self.helpLab];
    [self addSubview:self.goumaiBtn];
    [self addSubview:self.weilianjieLab];
    [self addSubview:self.LabOne];
    [self addSubview:self.LabTwo];
    [self addSubview:self.LabThree];
    
    // 添加约束
    [self addLayout];
}

-(void)addLayout{
    
    // deviceLab
    [self.helpLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logo);
        make.width.equalTo(self);
        make.left.equalTo(self);
    }];
    
    //购买btn
    [self.goumaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        
    }];
    
    //未连接设备
    [self.weilianjieLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.helpLab).offset(100);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        
    }];
    
    // Lab1
    [self.LabOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weilianjieLab.mas_bottom).offset(50);
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).offset(-70);
        
    }];
    
    // Lab2
    [self.LabTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LabOne.mas_bottom).offset(50);
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).offset(-70);
        
    }];
    
    // Lab3
    [self.LabThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LabTwo.mas_bottom).offset(50);
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).offset(-70);
        
    }];
}

@end
