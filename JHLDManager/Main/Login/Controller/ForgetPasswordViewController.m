//
//  ForgetPasswordViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *userNameField;
@property (nonatomic, weak) UITextField *codeField;
@property (nonatomic, weak) UITextField *passwordField;
@property (nonatomic, weak) UITextField *secondPasswordField;
@property (nonatomic, weak) UIButton *codeBtn;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) int count;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
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
    [userNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    YLTextField *codeField = [[YLTextField alloc]init];
    [scrollView addSubview:codeField];
    [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNameField.mas_bottom).offset(20);
        make.left.right.height.equalTo(userNameField);
    }];
    codeField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"code_icon"]];
    codeField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:codeField andColor:baseColor andRadius:25 BorderWith:1];
    codeField.placeholder = @"请输入验证码";
    [codeField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [codeField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    codeField.delegate = self;
    self.codeField = codeField;
    codeField.keyboardType = UIKeyboardTypeNumberPad;
    [codeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeField addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeField.mas_right).offset(-5);
        make.centerY.equalTo(codeField);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    codeBtn.backgroundColor = baseColor;
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = FONT(14);
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn rounded:20];
    [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn = codeBtn;
    
    YLTextField *passwordField = [[YLTextField alloc]init];
    [scrollView addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeField.mas_bottom).offset(20);
        make.left.right.height.equalTo(userNameField);
    }];
    passwordField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:passwordField andColor:baseColor andRadius:25 BorderWith:1];
    passwordField.placeholder = @"请输入新密码";
    [passwordField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [passwordField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    passwordField.delegate = self;
    self.passwordField = passwordField;
    passwordField.secureTextEntry = YES;
    
    YLTextField *secondPasswordField = [[YLTextField alloc]init];
    [scrollView addSubview:secondPasswordField];
    [secondPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(20);
        make.left.right.height.equalTo(userNameField);
    }];
    secondPasswordField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
    secondPasswordField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:secondPasswordField andColor:baseColor andRadius:25 BorderWith:1];
    secondPasswordField.placeholder = @"请再次输入新密码";
    [secondPasswordField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [secondPasswordField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    secondPasswordField.delegate = self;
    self.secondPasswordField = secondPasswordField;
    secondPasswordField.secureTextEntry = YES;
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondPasswordField.mas_bottom).offset(20);
        make.left.right.height.equalTo(userNameField);
    }];
    [registerBtn setBackgroundColor:baseColor forState:UIControlStateNormal];
    [registerBtn setTitle:@"立即修改" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = FONT(20);
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn rounded:25];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(registerBtn.frame));
}

-(void)codeBtnClick:(UIButton *)codeBtn{
    if ([Helper isPhoneNumber:self.userNameField.text]) {
        codeBtn.userInteractionEnabled = NO;
        [self statrCount];
        [self getVerifyCode];
    }else{
        [ProgressHUD showError:@"请输入正确格式的电话号码"];
    }
}

#pragma mark - 定时器
-(void)statrCount{
    self.count = 60;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}
-(void)timerFire:(NSTimer *)timer{
    
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%dS后重新获取",self.count] forState:UIControlStateNormal];
    self.count--;
    if(self.count == 0){
        [timer invalidate];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = YES;
    }
}

-(void)getVerifyCode{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userNameField.text forKey:@"userLogin"];
    [RequestData POST:@"obtainPin" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
            self.code = [responseObject objectForKey:@"pin"];
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}



- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.userNameField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.codeField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}


-(void)registerBtnClick{
    if ([self verify]) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.userNameField.text forKey:@"userLogin"];
        [param setValue:self.codeField.text forKey:@"pin"];
        [param setValue:[Helper md5:self.passwordField.text] forKey:@"pwd"];
        [RequestData POST:@"register" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
            if (responseOK) {
                [ProgressHUD showSuccess:@"更改成功"];
            }else{
                [ProgressHUD showError:msg];
            }
        }];
    }
}



-(BOOL)verify{
    if (![Helper isPhoneNumber:self.userNameField.text]) {
        [ProgressHUD showError:@"请输入正确的手机号码！"];
        return NO;
    }
    if (![self.code isEqualToString:self.codeField.text]) {
        [ProgressHUD showError:@"验证码输入有误！"];
        return NO;
    }
    if (![self.passwordField.text isEqualToString:self.secondPasswordField.text]) {
        [ProgressHUD showError:@"两次密码输入不一致！"];
        return NO;
    }
    return YES;
}
@end
