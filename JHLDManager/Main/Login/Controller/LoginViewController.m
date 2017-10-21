//
//  LoginViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *userNameField;
@property (nonatomic, weak) UITextField *passwordField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";
    [self setUpUI];
}

-(void)setUpUI{
    
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = backgroudColor;
    
    
    UIView *userNameView = [[UIView alloc]init];
    [scrollView addSubview:userNameView];
    [userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(50);
    }];
    userNameView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *userNameImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkout_password"]];
    [userNameView addSubview:userNameImg];
    [userNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userNameView);
        make.left.equalTo(userNameView).offset(10);
        make.width.height.mas_equalTo(20);
    }];
    
    UITextField *userNameField = [[UITextField alloc]init];
    [userNameView addSubview:userNameField];
    [userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(userNameView);
        make.left.equalTo(userNameImg.mas_right).offset(10);
        make.right.equalTo(userNameView).offset(-10);
    }];
    userNameField.placeholder = @"请输入手机号码";
    [userNameField setValue:[UIFont boldSystemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    userNameField.delegate = self;
    self.userNameField = userNameField;
    userNameField.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *passwordView = [[UIView alloc]init];
    [scrollView addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNameView.mas_bottom).offset(1);
        make.left.right.height.equalTo(userNameView);
    }];
    passwordView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *passwordImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkout_password"]];
    [passwordView addSubview:passwordImg];
    [passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordView);
        make.left.equalTo(passwordView).offset(10);
        make.width.height.mas_equalTo(20);
    }];
    
    UITextField *passwordField = [[UITextField alloc]init];
    [passwordView addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(passwordView);
        make.left.equalTo(passwordImg.mas_right).offset(10);
        make.right.equalTo(passwordView).offset(-10);
    }];
    passwordField.placeholder = @"请输入密码";
    passwordField.secureTextEntry = YES;
    [passwordField setValue:[UIFont boldSystemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    passwordField.delegate = self;
    self.passwordField = passwordField;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView.mas_bottom).offset(20);
        make.left.right.equalTo(passwordView);
        make.height.mas_equalTo(50);
    }];
    [loginBtn setBackgroundColor:RGB(60, 150, 215) forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn rounded:5];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.left.equalTo(loginBtn).offset(25);
    }];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:RGB(60, 150, 215) forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.right.equalTo(loginBtn).offset(-25);
    }];
    [registerBtn setTitle:@"用户注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:RGB(60, 150, 215) forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.userNameField) {

    }
}

-(void)loginBtnClick{
    if ([self verify]) {
        
    }
}

-(BOOL)verify{
//    if ([Helper isBlankString:self.userNameField.text] || ![self verifyUserNameField]) {
//        [MBProgressHUD showText:@"请输入规范的用户名"];
//        return NO;
//    }
//    if ([Helper isBlankString:self.passwordField.text] || ![self verifyPasswordField]) {
//        [MBProgressHUD showText:@"请输入规范的密码"];
//        return NO;
//    }
//    if (![self.inputCodeField.text isEqualToString:self.codeLabel.text]) {
//        [MBProgressHUD showText:@"验证码输入有误"];
//        return NO;
//    }
    return YES;
}

-(BOOL)verifyUserNameField{
    NSString *phoneNoRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNoRegex];
    return [pred evaluateWithObject:self.userNameField.text];
}

-(BOOL)verifyPasswordField{
    NSString * regex = @"^[A-Za-z0-9]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self.passwordField.text];
}


-(void)forgetBtnClick{
//    ForgetPasswordViewController *forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
//    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

-(void)registerBtnClick{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}



@end
