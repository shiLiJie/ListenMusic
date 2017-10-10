//
//  UNameRegistController.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "BaseViewController.h"

@interface UNameRegistController : BaseViewController
// 用户注册Lab
@property (weak, nonatomic) IBOutlet UILabel *userRegistLab;
// 用户名注册Lab
@property (weak, nonatomic) IBOutlet UILabel *userNameRegistLab;
// 输入用户名textField
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
// 输入密码textField
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
// 再次输入密码textField
@property (weak, nonatomic) IBOutlet UITextField *rePassWordTextField;
// 注册btn
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
// 手机号注册btn
@property (weak, nonatomic) IBOutlet UIButton *phoneNumRegistBtn;
// 电子邮箱注册btn
@property (weak, nonatomic) IBOutlet UIButton *emailRegistBtn;

@end
