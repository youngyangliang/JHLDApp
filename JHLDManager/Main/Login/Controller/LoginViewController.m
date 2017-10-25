//
//  LoginViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "UserInfoModel.h"

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
    
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];    
    
    UIImageView *logoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bigLogo"]];
    [scrollView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    YLTextField *userNameField = [[YLTextField alloc]init];
    [scrollView addSubview:userNameField];
    [userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImg.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
    }];
    userNameField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_icon"]];
    userNameField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:userNameField andColor:baseColor andRadius:25 BorderWith:1];
    userNameField.placeholder = @"请输入手机号码";
    [userNameField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [userNameField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    userNameField.delegate = self;
    self.userNameField = userNameField;
    userNameField.keyboardType = UIKeyboardTypeNumberPad;
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    YLTextField *passwordField = [[YLTextField alloc]init];
    [scrollView addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNameField.mas_bottom).offset(20);
        make.left.right.height.equalTo(userNameField);
    }];
    passwordField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:passwordField andColor:baseColor andRadius:25 BorderWith:1];
    passwordField.placeholder = @"请输入密码";
    [passwordField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [passwordField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    passwordField.delegate = self;
    self.passwordField = passwordField;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.secureTextEntry = YES;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(20);
        make.left.right.equalTo(passwordField);
        make.height.mas_equalTo(50);
    }];
    [loginBtn setBackgroundColor:baseColor forState:UIControlStateNormal];
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = FONT(20);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn rounded:25];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];


    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(50);
        make.right.equalTo(loginBtn.mas_centerX).offset(-15);
    }];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:baseColor forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(forgetBtn);
        make.left.equalTo(loginBtn.mas_centerX).offset(15);
    }];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:baseColor forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc]init];
    [scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loginBtn);
        make.centerY.equalTo(forgetBtn);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
    }];
    line.backgroundColor = baseColor;
    
    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(registerBtn.frame));
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.userNameField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

-(void)loginBtnClick{
    if ([self verify]) {
        [ProgressHUD show:@"正在登录"];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.userNameField.text forKey:@"userLogin"];
        [param setValue:[Helper md5:self.passwordField.text] forKey:@"pwd"];
        [RequestData POST:@"login" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
            if (responseOK) {
                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                [userDef setObject:responseObject forKey:@"userInfo"];
                [ProgressHUD showSuccess:msg];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ProgressHUD showError:msg];
            }
        }];
    }
}

-(BOOL)verify{
    if (![Helper isPhoneNumber:self.userNameField.text]) {
        [ProgressHUD showError:@"请输入正确的手机号码"];
        return NO;
    }

    return YES;
}


-(void)registerBtnClick{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)forgetPasswordBtnClick{
    ForgetPasswordViewController *forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}


@end
