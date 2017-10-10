//
//  PhoneRegistController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "PhoneRegistController.h"
#import "EmailRegistController.h"
#import "UNameRegistController.h"
#import "ProView.h"

@interface PhoneRegistController ()

@end

@implementation PhoneRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.verifiCode.keyboardType = UIKeyboardTypeNumberPad;

}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

#pragma mark - btnclick - 
// 注册
- (IBAction)regist:(UIButton *)sender {
    
    //判断是否传入空的账号或密码
    if ([self.phoneNumText.text isEqualToString:@""] ||
        [self.verifiCode.text isEqualToString:@""] ) {
        return;
    }
    
    if (self.passWordText.text.length > 20) {
        [MBProgressHUD showError:@"密码长度不要大于20位"];
        return;
    }
    //排除特殊字符
    NSString *acc=self.phoneNumText.text;
    NSString *pwd=self.passWordText.text;
    
    //再判断格式是否正确
    if ([SLJJudgementString checkTelNumber:acc]) {
    }else{
        //没有
        [MBProgressHUD showError:@"手机号格式不正确"];
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
                           @"register_name":self.phoneNumText.text,
                           @"password":self.passWordText.text,
                           @"re_password":self.phoneNumText.text,
                           @"verify_code":self.verifiCode.text,
                           @"register_type":[NSString stringWithFormat:@"2"],
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
                                                            obj.userID = self.phoneNumText.text;
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

// 邮箱注册
- (IBAction)emailRegist:(UIButton *)sender {
    
    EmailRegistController *forgot = [[EmailRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

// 用户名注册
- (IBAction)userNameRegist:(UIButton *)sender {
    
    UNameRegistController *forgot = [[UNameRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

// 获取验证码
- (IBAction)getVerifiCode:(UIButton *)sender {
    
    //获取验证码按钮点击
    NSString *token = [NSString md5WithString];
    NSDictionary *dict = @{
                           @"token":token,
                           @"phone":self.phoneNumText.text,
                           @"type":@"register"
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/NbApi/nb_phone_verify"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([SucceedCoder isEqualToString:[NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]]]) {
                                                            
                                                            [MBProgressHUD showSuccess:@"发送成功"];

//                                                            ProView *pro = [[[NSBundle mainBundle] loadNibNamed:@"ProView" owner:self options:nil] lastObject];
//                                                            pro.frame = CGRectMake(Main_Screen_Width/2-80, Main_Screen_Height/2-30, 160, 60);
//                                                            [self.view addSubview:pro];
//                                                            
//                                                            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
//                                                            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                                                                [pro removeFromSuperview];
//                                                            });
                                                        }else{
                                                            [MBProgressHUD showError:@"获取验证码失败"];
                                                        }
                                                    }
                                                       fail:^(NSError *error) {
                                                           [MBProgressHUD showError:@"获取验证码失败"];
                                                       }];
    
    
    
}

#pragma mark - 退键盘 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumText resignFirstResponder];
    [self.verifiCode resignFirstResponder];
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
