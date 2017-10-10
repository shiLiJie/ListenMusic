//
//  HelpView.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/20.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpView : UIView

// 左上角logo
@property (nonatomic, strong) UIImageView *logo;
// 帮助Lab
@property (nonatomic, strong) UILabel *helpLab;
// 购买btn
@property (nonatomic, strong) UIButton *goumaiBtn;
// 未连接设备lab
@property (nonatomic, strong) UILabel *weilianjieLab;
// Lab1
@property (nonatomic, strong) UILabel *LabOne;
// Lab2
@property (nonatomic, strong) UILabel *LabTwo;
// Lab3
@property (nonatomic, strong) UILabel *LabThree;

@end
