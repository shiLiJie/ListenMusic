//
//  ForgotPassWordController.h
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgotPassWordController : BaseViewController
// 忘记密码Lab
@property (weak, nonatomic) IBOutlet UILabel *forGotPassWordLab;
// 手机号或邮箱textField
@property (weak, nonatomic) IBOutlet UITextField *phoneEmailNumText;
// 验证码textField
@property (weak, nonatomic) IBOutlet UITextField *verifiCodeText;
// 获取验证码btn
@property (weak, nonatomic) IBOutlet UIButton *getVerifiCodeBtn;
// 重置密码Lab
@property (weak, nonatomic) IBOutlet UILabel *resetPassWordLab;
// 输入新密码textField
@property (weak, nonatomic) IBOutlet UITextField *inputNewPassword;
// 再次输入新密码textField
@property (weak, nonatomic) IBOutlet UITextField *reInputPassword;
// 重置密码btn
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordBtn;

@end
