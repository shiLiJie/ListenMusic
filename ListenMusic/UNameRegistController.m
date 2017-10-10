//
//  UNameRegistController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/25.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "UNameRegistController.h"
#import "PhoneRegistController.h"
#import "EmailRegistController.h"

@interface UNameRegistController ()

@end

@implementation UNameRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

#pragma mark - btnclick - 
// 手机号注册
- (IBAction)phoneNumRegist:(UIButton *)sender {
    
    PhoneRegistController *forgot = [[PhoneRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

// 邮箱注册
- (IBAction)emailRegist:(UIButton *)sender {
    
    EmailRegistController *forgot = [[EmailRegistController alloc] init];
    [self.navigationController pushViewController:forgot animated:YES];
}

// 注册
- (IBAction)regist:(UIButton *)sender {
    
    //判断是否传入空的账号或密码
    if ([self.userNameTextField.text isEqualToString:@""] ||
        [self.passWordTextField.text isEqualToString:@""] ) {
        return;
    }
    //排除特殊字符
    NSString *acc=self.userNameTextField.text;
    NSString *pwd=self.passWordTextField.text;
    //判断账号密码长度
    if (self.userNameTextField.text.length > 10) {
        [MBProgressHUD showError:@"账号长度不要大于20位"];
        return;
    }
    if (self.passWordTextField.text.length > 20) {
        [MBProgressHUD showError:@"密码长度不要大于20位"];
        return;
    }
    if (![self.passWordTextField.text isEqualToString:self.rePassWordTextField.text]) {
        [MBProgressHUD showError:@"两次输入的密码不相同"];
        return;
    }
    //再判断格式是否正确
    if ([SLJJudgementString checkPassword:acc]) {
    }else{
        //没有
        [MBProgressHUD showError:@"账号格式不正确"];
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
                           @"register_name":self.userNameTextField.text,
                           @"password":self.passWordTextField.text,
                           @"org_id":@"1",
                           @"re_password":self.passWordTextField.text,
                           @"register_type":[NSString stringWithFormat:@"1"],
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
                                                            obj.userID = self.userNameTextField.text;
                                                            obj.password = self.passWordTextField.text;
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
    [self.userNameTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    [self.rePassWordTextField resignFirstResponder];
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
