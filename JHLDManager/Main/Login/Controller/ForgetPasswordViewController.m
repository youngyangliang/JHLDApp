//
//  ForgetPasswordViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *placeHoldArray;
@property (nonatomic, weak) UITextField *telField;
@property (nonatomic, weak) UITextField *codeField;
@property (nonatomic, weak) UITextField *passwordField;
@property (nonatomic, weak) UITextField *secondPasswordField;
@property (nonatomic, weak) UIButton *codeBtn;
@property (nonatomic, assign) int count;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self setUpUI];
}
-(void)setUpUI{
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = backgroudColor;
//    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [scrollView addSubview:headBtn];
//    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(scrollView);
//        make.top.equalTo(scrollView).offset(40);
//        make.width.height.mas_equalTo(80);
//    }];
//    [headBtn setImage:[UIImage imageNamed:@"headIcon"] forState:UIControlStateNormal];
//    [headBtn rounded:40];
//    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    self.headBtn = headBtn;
    
    for (int i = 0; i<self.placeHoldArray.count; i++) {
        UIView *bgView = [[UIView alloc]init];
        [scrollView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scrollView).offset(30+i*(51));
            make.left.equalTo(self.view).offset(25);
            make.right.equalTo(self.view).offset(-25);
            make.height.mas_equalTo(50);
        }];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkout_password"]];
        [bgView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).offset(10);
            make.width.height.mas_equalTo(20);
        }];
        
        UITextField *textField = [[UITextField alloc]init];
        [bgView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView);
            make.left.equalTo(img.mas_right).offset(10);
            make.right.equalTo(bgView).offset(-10);
        }];
        textField.placeholder = self.placeHoldArray[i];
        [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        textField.delegate = self;
        switch (i) {
            case 0:
                self.telField = textField;
                textField.keyboardType = UIKeyboardTypePhonePad;
                break;
            case 1:
            {
                self.codeField = textField;
                UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [bgView addSubview:codeBtn];
                [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(bgView.mas_right).offset(-10);
                    make.centerY.equalTo(bgView);
                    make.width.mas_equalTo(100);
                    make.height.mas_equalTo(40);
                }];
                codeBtn.backgroundColor = baseColor;
                [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                codeBtn.titleLabel.font = FONT(14);
                [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [codeBtn rounded:5];
                [textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(bgView);
                    make.left.equalTo(img.mas_right).offset(10);
                    make.right.equalTo(codeBtn.mas_left).offset(-5);
                }];
                [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                self.codeBtn = codeBtn;
            }
                break;
            case 2:
                self.passwordField = textField;
                break;
            case 3:
                self.secondPasswordField = textField;
                break;
            default:
                break;
        }
    }
    
    UIButton *changePassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:changePassword];
    [changePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondPasswordField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(50);
    }];
    [changePassword setBackgroundColor:baseColor forState:UIControlStateNormal];
    [changePassword setTitle:@"修改密码" forState:UIControlStateNormal];
    [changePassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changePassword rounded:5];
    [changePassword addTarget:self action:@selector(changePasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(changePassword.frame));
}

-(void)codeBtnClick:(UIButton *)codeBtn{
    if ([Helper isPhoneNumber:self.telField.text]) {
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
    [param setValue:self.telField.text forKey:@"userLogin"];
    [RequestData POST:@"obtainPin" parameters:param response:^(id responseObject, BOOL responseOK) {
        
    }];
}

-(void)changePasswordBtnClick{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.telField.text forKey:@"userLogin"];
    [RequestData POST:@"findPwd" parameters:param response:^(id responseObject, BOOL responseOK) {
        
    }];
}

-(NSArray *)placeHoldArray{
    if (!_placeHoldArray) {
        _placeHoldArray = [NSArray arrayWithObjects:@"请输入手机号",@"请输入验证码",@"请输入密码",@"请再次输入密码", nil];
    }
    return _placeHoldArray;
}
@end
