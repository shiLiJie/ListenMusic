//
//  LJLoginViewController.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "BaseViewController.h"

@interface LJLoginViewController : BaseViewController
// 用户登录
@property (weak, nonatomic) IBOutlet UILabel *loginLab;
// 账号textField
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
// 密码textField
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
// 忘记密码btn
@property (weak, nonatomic) IBOutlet UIButton *forgotPassWordBtn;
// 登陆btn
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
// 注册btn
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end
