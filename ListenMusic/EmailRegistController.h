 //
//  EmailRegistController.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "BaseViewController.h"

@interface EmailRegistController : BaseViewController
// 用户注册Lab
@property (weak, nonatomic) IBOutlet UILabel *userRegistLab;
// 电子邮箱注册Lab
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
// 输入邮箱地址text
@property (weak, nonatomic) IBOutlet UITextField *emailText;
// 输入验证码text
@property (weak, nonatomic) IBOutlet UITextField *verifiCodeText;
// 获取验证码btn
@property (weak, nonatomic) IBOutlet UIButton *getVerifiCodeBtn;
// 注册按钮拜托你
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
// 手机号注册btn
@property (weak, nonatomic) IBOutlet UIButton *phoneNumRegistBtn;
// 用户名注册btn
@property (weak, nonatomic) IBOutlet UIButton *userNameRegistBtn;
// 密码text
@property (weak, nonatomic) IBOutlet UITextField *passWordText;

@end
