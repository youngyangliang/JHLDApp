//
//  ChangePasswordViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/25.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *oldPasswordField;
@property (nonatomic, weak) UITextField *passwordField;
@property (nonatomic, weak) UITextField *secondPasswordField;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    
    UIImageView *logoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bigLogo"]];
    [scrollView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    YLTextField *oldPasswordField = [[YLTextField alloc]init];
    [scrollView addSubview:oldPasswordField];
    [oldPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImg.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
    }];
    oldPasswordField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_icon"]];
    oldPasswordField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:oldPasswordField andColor:baseColor andRadius:25 BorderWith:1];
    oldPasswordField.placeholder = @"请输入原密码";
    [oldPasswordField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [oldPasswordField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    oldPasswordField.delegate = self;
    self.oldPasswordField = oldPasswordField;
    oldPasswordField.secureTextEntry = YES;
    oldPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [oldPasswordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    YLTextField *passwordField = [[YLTextField alloc]init];
    [scrollView addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPasswordField.mas_bottom).offset(20);
        make.left.right.height.equalTo(oldPasswordField);
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
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    YLTextField *secondPasswordField = [[YLTextField alloc]init];
    [scrollView addSubview:secondPasswordField];
    [secondPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(20);
        make.left.right.height.equalTo(oldPasswordField);
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
    secondPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondPasswordField.mas_bottom).offset(20);
        make.left.right.height.equalTo(secondPasswordField);
    }];
    [changeBtn setBackgroundColor:baseColor forState:UIControlStateNormal];
    [changeBtn setTitle:@"立即修改" forState:UIControlStateNormal];
    changeBtn.titleLabel.font = FONT(20);
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn rounded:25];
    [changeBtn addTarget:self action:@selector(changeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(changeBtn.frame));
}

-(void)changeButtonClick{
    if ([self verify]) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:UserInfoDef[@"userLogin"] forKey:@"userLogin"];
        [param setValue:self.oldPasswordField.text forKey:@"pwd"];
        [param setValue:self.passwordField.text forKey:@"npwd"];
        [RequestData POST:@"updatePwd" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
            if (responseOK) {
                [ProgressHUD showSuccess:msg];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ProgressHUD showError:msg];
            }
        }];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
//    if (textField == self.nameField) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//    }
}

-(BOOL)verify{
    if ([Helper isBlankString:self.oldPasswordField.text]) {
        [ProgressHUD showError:@"原密码不能为空"];
        return NO;
    }
    if ([Helper isBlankString:self.passwordField.text]) {
        [ProgressHUD showError:@"新密码不能为空"];
        return NO;
    }
    if (![self.passwordField.text isEqualToString:self.secondPasswordField.text]) {
        [ProgressHUD showError:@"两次密码输入不一致！"];
        return NO;
    }
    return YES;
}

@end
