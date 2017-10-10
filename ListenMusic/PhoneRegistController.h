//
//  PhoneRegistController.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "BaseViewController.h"

@interface PhoneRegistController : BaseViewController
// 用户注册Lab
@property (weak, nonatomic) IBOutlet UILabel *userRegistLab;
// 输入中国大陆手机号码
@property (weak, nonatomic) IBOutlet UILabel *inputPhoneNum;
// 输入手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
// 输入验证码
@property (weak, nonatomic) IBOutlet UITextField *verifiCode;
// 注册btn
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
// 邮箱注册tbn
@property (weak, nonatomic) IBOutlet UIButton *emailRegistBtn;
// 用户名注册btn
@property (weak, nonatomic) IBOutlet UIButton *userNameRegistBtn;
// 获取验证码btn
@property (weak, nonatomic) IBOutlet UIButton *getVerifiCodeBtn;
// 密码text
@property (weak, nonatomic) IBOutlet UITextField *passWordText;

@end
