//
//  ForgotPassWordController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "ForgotPassWordController.h"

@interface ForgotPassWordController ()

@end

@implementation ForgotPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

//-(void)left_button_event:(UIButton *)sender{
//}

//设置左边按键
//-(UIButton*)set_leftButton
//{
//    UIButton *left_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [left_button setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateNormal];
//    [left_button setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateHighlighted];
//    return left_button;
//}



#pragma mark - btnclick - 
// 获取验证码
- (IBAction)getVerifiCode:(UIButton *)sender {
    //获取验证码按钮点击
    NSString *token = [NSString md5WithString];
    NSDictionary *dict = @{
                           @"token":token,
                           @"phone":self.phoneEmailNumText.text,
                           @"type":@""
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/NbApi/nb_phone_verify"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([SucceedCoder isEqualToString:[NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]]]) {
                                                            
                                                            [MBProgressHUD showSuccess:@"发送成功"];
                                                            
                                                        }else{
                                                            [MBProgressHUD showError:@"获取验证码失败"];
                                                        }
                                                    }
                                                       fail:^(NSError *error) {
                                                           [MBProgressHUD showError:@"获取验证码失败"];
                                                       }];
}

// 重置密码
- (IBAction)resetPassword:(UIButton *)sender {
    //加密token
    NSString *token = [NSString md5WithString];
    //参数字典
    NSDictionary *dict = @{
                           @"token":token,
                           @"phone":self.phoneEmailNumText.text,
                           @"password":self.inputNewPassword.text,
                           @"code":self.verifiCodeText.text,
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/NbApi/reset_password_byphone"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        NSString *msg = [NSString getResponseMsgWithObject:obj];
                                                        NSLog(@"%@",obj);
                                                        
                                                        
//                                                        int code;
//                                                        if ([[obj valueForKey:@"code"] isKindOfClass:[NSNumber class]]) {
//                                                            code = [[obj valueForKey:@"code"] intValue];
//                                                        }
//                                                        //状态码1成功
//                                                        if (code == successRequest) {
//                                                            //存一下成功的账号信息
//                                                            NSString *uid = [NSString getResponseUIDWithObject:obj];
//                                                            UserObj *obj = [UserObj sharedUser];
//                                                            obj.ID = uid;
//                                                            obj.userID = self.UserTextfield.text;
//                                                            obj.password = self.PasswordTextfield.text;
//                                                            [UserTool saveTheUserInfo:obj];
//                                                            //block成功
//                                                            self.loginBlock(YES,msg);
//                                                        }
//                                                        //状态码0失败
//                                                        if (code == failRequset) {
//                                                           
//                                                        }
                                                        
                                                    }
                                                       fail:^(NSError *error) {
                                                           
                                                       }];
}

#pragma mark - 推键盘 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneEmailNumText resignFirstResponder];
    [self.verifiCodeText resignFirstResponder];
    [self.inputNewPassword resignFirstResponder];
    [self.reInputPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
