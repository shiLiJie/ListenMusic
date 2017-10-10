//
//  LJLoginViewController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "LJLoginViewController.h"
#import "PhoneRegistController.h"
#import "ForgotPassWordController.h"

@interface LJLoginViewController ()

@end

@implementation LJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

// 设置导航栏背景色
- (UIColor *)set_colorBackground
{
    return [UIColor clearColor];
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}



#pragma mark - btnclick - 
// 忘记密码
- (IBAction)forgotPassword:(UIButton *)sender {
    
    ForgotPassWordController *forgot = [[ForgotPassWordController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];

}

// 登陆
- (IBAction)login:(UIButton *)sender {
    //加密token
    NSString *token = [NSString md5WithString];
    //参数字典
    NSDictionary *dict = @{
                           @"token":token,
                           @"login_name":self.userNameText.text,
                           @"password":self.passWordText.text
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:@"http://cloud.musiccare.cn/Api/NbApi/nb_login"
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        NSString *msg = [NSString getResponseMsgWithObject:obj];

                                                        int code;
                                                        if ([[obj valueForKey:@"code"] isKindOfClass:[NSNumber class]]) {
                                                            code = [[obj valueForKey:@"code"] intValue];
                                                        }
                                                        //状态码1成功
                                                        if ([SucceedCoder isEqualToString:[NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]]]) {
                                                            //存一下成功的账号信息
                                                            NSString *uid = [NSString getResponseUIDWithObject:obj];
                                                            UserObj *obj = [UserObj sharedUser];
                                                            obj.ID = uid;
                                                            obj.userID = self.userNameText.text;
                                                            obj.password = self.passWordText.text;
                                                            [UserTool saveTheUserInfo:obj];
                                                            //block成功
//                                                            self.loginBlock(YES,msg);
                                                        }
                                                        //状态码0失败
                                                        if ([FailureCoder isEqualToString:[NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]]]) {
                                                            //block失败
//                                                            self.loginBlock(NO,msg);
                                                        }
                                                        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                                                    }
                                                       fail:^(NSError *error) {
//                                                           self.loginBlock(NO,@"请检查网络");
                                                           [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                                                       }];
    
}

// 注册
- (IBAction)regist:(UIButton *)sender {
    
    PhoneRegistController *forgot = [[PhoneRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

#pragma mark - 推键盘 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameText resignFirstResponder];
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
