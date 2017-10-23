//
//  RegisterViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "RegisterViewController.h"

#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>

@interface RegisterViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSArray *placeHoldArray;
@property (nonatomic, weak) UITextField *telField;
@property (nonatomic, weak) UITextField *codeField;
@property (nonatomic, weak) UITextField *passwordField;
@property (nonatomic, weak) UITextField *secondPasswordField;
@property (nonatomic, weak) UIButton *codeBtn;
@property (nonatomic, weak) UIButton *headBtn;
@property (nonatomic, assign) int count;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新用户注册";
    [self setUpUI];
}
-(void)setUpUI{
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = backgroudColor;
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView);
        make.top.equalTo(scrollView).offset(40);
        make.width.height.mas_equalTo(80);
    }];
    [headBtn setImage:[UIImage imageNamed:@"headIcon"] forState:UIControlStateNormal];
    [headBtn rounded:40];
    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.headBtn = headBtn;
    
    for (int i = 0; i<self.placeHoldArray.count; i++) {
        UIView *bgView = [[UIView alloc]init];
        [scrollView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headBtn.mas_bottom).offset(30+i*(51));
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
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondPasswordField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(50);
    }];
    [registBtn setBackgroundColor:baseColor forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn rounded:5];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(registBtn.frame));
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
    [RequestData POST:@"obtainPin" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

-(void)headBtnClick{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
            authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            // 无权限 引导去开启
            NSDictionary *dict = [NSDictionary dictionary];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:dict completionHandler:nil];
                } else {
                    // Fallback on earlier versions
                }
                return;
            }
        }
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate=self;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //相册权限
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
            //无权限 引导去开启
            NSDictionary *dict = [NSDictionary dictionary];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:dict completionHandler:nil];
                return;
            }
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.headBtn setImage:img forState:UIControlStateNormal];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:UIImagePNGRepresentation(img) forKey:@"headPhoto"];
    //不是从相册里拿的照片,就保存到相册里
    if (![info objectForKey:@"UIImagePickerControllerReferenceURL"]) {
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    }
}


-(void)registBtnClick{
    if ([self verify]) {
//        //先验证用户名是否重复
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [param setValue:self.userNameField.text forKey:@"userName"];
//        [RequestData GET:@"aqiJudgeUserNameIsRepeat" parameters:param response:^(id responseObject, BOOL responseOK) {
//            if (responseOK) {
//                if ([responseObject isEqualToString:@"false"]) {//用户名存在
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"该用户名已经存在！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        
//                    }]];
//                    [self presentViewController:alertController animated:YES completion:nil];
//                }else{
//                    
//                    [self registUser];
//                }
//            }
//        }];
    }
}

-(void)uploadHeadImage{
//    NSData *headData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headPhoto"];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"headImage.png" forKey:@"Filedata"];
//    [manager POST:@"http://60.12.237.34:9909/mobile/mobile/upload.do" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        //上传文件参数
//        [formData appendPartWithFileData:headData name:@"headImage" fileName:@"headImage.png" mimeType:@"image/jpeg"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        //打印上传进度
//        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
//        NSLog(@"%.2lf%%", progress);
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //请求成功
//        NSLog(@"请求成功：%@",responseObject);
//        [MBProgressHUD showSuccess:@"注册成功！"];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        //请求失败
//        NSLog(@"请求失败：%@",error);
//
//    }];
}

-(void)registUser{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:self.userNameField.text forKey:@"userName"];
//    [param setValue:self.passwordField.text forKey:@"password"];
//    [param setValue:self.emailField.text forKey:@"email"];
//    [param setValue:self.userNameField.text forKey:@"nickName"];
//    [param setValue:@"" forKey:@"iconId"];
//    [param setValue:self.phoneNumberField.text forKey:@"phone"];
//    [RequestData GET:@"aqiRegisterUser" parameters:param response:^(id responseObject, BOOL responseOK) {
//        if (responseOK) {
//            RegisterModel *userModel = [RegisterModel mj_objectWithKeyValues:responseObject];
//            //先请求code,再登录
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            [param setValue:self.userNameField.text forKey:@"username"];
//            [RequestData GET:@"aqiGetIdCode" parameters:param response:^(id responseObject, BOOL responseOK) {
//                if (responseOK) {
//                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//                    [param setValue:userModel.userName forKey:@"userName"];
//                    [param setValue:self.passwordField.text forKey:@"password"];
//                    [param setValue:@"0" forKey:@"phoneType"];
//                    [param setValue:responseObject forKey:@"code"];
//                    [RequestData GET:@"aqiUserLogin1" parameters:param response:^(id responseObject, BOOL responseOK) {
//                        if (responseOK) {
//                            NSLog(@"%@",responseObject);
//
//                            UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:responseObject];
//                            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//                            [userDef setObject:data forKey:@"userInfo"];
//                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];
//                            [userDef setObject:self.passwordField.text forKey:@"password"];
//
//                        }
//                    }];
//                }
//            }];
//        }
//    }];
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
//    if ([Helper isBlankString:self.emailField.text] || ![self isEmailAddress]) {
//        [MBProgressHUD showText:@"请输入可用的邮箱"];
//        return NO;
//    }
//    if (![Helper isBlankString:self.phoneNumberField.text]  && ![self isPhoneNo]) {
//        [MBProgressHUD showText:@"请输入规范的手机号码"];
//        return NO;
//    }
    return YES;
}

//-(BOOL)verifyUserNameField{
//    NSString * regex = @"^[A-Za-z0-9]{6,18}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [pred evaluateWithObject:self.telField.text];
//}



-(NSArray *)placeHoldArray{
    if (!_placeHoldArray) {
        _placeHoldArray = [NSArray arrayWithObjects:@"请输入手机号",@"请输入验证码",@"请输入密码",@"请再次输入密码", nil];
    }
    return _placeHoldArray;
}

@end
    
