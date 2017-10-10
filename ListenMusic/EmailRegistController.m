//
//  EmailRegistController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "EmailRegistController.h"
#import "PhoneRegistController.h"
#import "UNameRegistController.h"

@interface EmailRegistController ()

@end

@implementation EmailRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.verifiCodeText.keyboardType = UIKeyboardTypeNumberPad;
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

#pragma mark - btnclick - 
// 获取验证码
- (IBAction)getVerifiCode:(UIButton *)sender {
    //获取验证码按钮点击
    NSString *token = [NSString md5WithString];
    NSDictionary *dict = @{
                           @"token":token,
                           @"email":self.emailText.text,
                           @"type":@"register"
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/NbApi/nb_email_verify"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        NSString *msg = [NSString getResponseMsgWithObject:obj];
                                                        if ([SucceedCoder isEqualToString:[NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]]]) {
                                                            [MBProgressHUD showSuccess:@"发送成功"];
                                                        }else{
                                                            [MBProgressHUD showError:msg];
                                                        }
                                                    }
                                                       fail:^(NSError *error) {
                                                           [MBProgressHUD showError:@"发送失败"];
                                                       }];
}

// 用户名注册
- (IBAction)userNameRegist:(UIButton *)sender {
    
    UNameRegistController *forgot = [[UNameRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

// 手机号注册
- (IBAction)phoneNumRegist:(UIButton *)sender {
    
    PhoneRegistController *forgot = [[PhoneRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

// 注册
- (IBAction)regist:(UIButton *)sender {
    
    //判断是否传入空的账号或密码
    if ([self.emailText.text isEqualToString:@""] ||
        [self.passWordText.text isEqualToString:@""] ) {
        return;
    }
    
    if (self.passWordText.text.length > 20) {
        [MBProgressHUD showError:@"密码长度不要大于20位"];
        return;
    }
    //排除特殊字符
    NSString *acc=self.emailText.text;
    NSString *pwd=self.passWordText.text;
    
    //再判断格式是否正确
    if ([SLJJudgementString validateEmail:acc]) {
    }else{
        //没有
        [MBProgressHUD showError:@"邮箱格式不正确"];
        return;
    }
    if ([SLJJudgementString checkPassword:pwd]) {
    }else{
        //没有
        [MBProgressHUD showError:@"密码格式不正确"];
        return;
    }
    
    NSString *token = [NSString md5WithString];
    NSDictionary *dict = @{
                           @"token":token,
                           @"register_name":self.emailText.text,
                           @"password":self.passWordText.text,
                           @"re_password":self.passWordText.text,
                           @"verify_code":self.verifiCodeText.text,
                           @"register_type":[NSString stringWithFormat:@"3"],
                           @"org_id":@"1",
                           @"register_form":@"app"
                           };
    //注册账号网络请求
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/NbApi/nb_register"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        NSLog(@"%@",obj);
                                                        NSString *msg = [NSString getResponseMsgWithObject:obj];
                                                        NSString *uid = [NSString getResponseUIDWithObject:obj];
                                                        if ([SucceedCoder isEqualToString:[NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]]]) {
                                                            [MBProgressHUD showSuccess:@"注册成功"];
                                                            //存用户数据
                                                            UserObj *obj = [UserObj sharedUser];
                                                            obj.ID = uid;
                                                            obj.userID = self.emailText.text;
                                                            obj.password = self.passWordText.text;
                                                            [UserTool saveTheUserInfo:obj];
                                                            //注册成功回调
                                                            
                                                        }else{
                                                            [MBProgressHUD showError:msg];
                                                        }
                                                        
                                                    } fail:^(NSError *error) {
                                                        //失败,提示网络错误
                                                    }];
}

#pragma mark - 退键盘 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.emailText resignFirstResponder];
    [self.verifiCodeText resignFirstResponder];
    [self.passWordText resignFirstResponder];
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
