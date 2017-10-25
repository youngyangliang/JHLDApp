//
//  UserInfoViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ChangeNameController.h"
#import "ChangeTelephoneController.h"
#import "ChangePasswordViewController.h"

#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>

@interface UserInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, weak) UIButton *headViewBtn;
@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UILabel *nameLab;
@property (nonatomic, weak) UILabel *telLab;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserInfoNoti:) name:CHANGE_USERINFO object:nil];
    [self setUpUI];
}

-(void)changeUserInfoNoti:(NSNotification *)noti{
    self.nameLab.text = UserInfoDef[@"name"];
    self.telLab.text = UserInfoDef[@"userLogin"];
}

-(void)setUpUI{
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = backgroudColor;
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    [headBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *headLab = [[UILabel alloc]init];
    [headBtn addSubview:headLab];
    [headLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headBtn);
        make.left.equalTo(headBtn).offset(20);
    }];
    headLab.text = @"头像";
    
    UIImageView *rightArrow1 = [[UIImageView alloc]init];
    [headBtn addSubview:rightArrow1];
    [rightArrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headBtn);
        make.right.equalTo(headBtn).offset(-15);
        make.width.height.mas_equalTo(20);
    }];
    rightArrow1.image = [UIImage imageNamed:@"arrow_right"];
    
    UIButton *headViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn addSubview:headViewBtn];
    [headViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerY.equalTo(headBtn);
        make.right.equalTo(rightArrow1.mas_left).offset(-10);
    }];
    [headViewBtn rounded:30];
    [headViewBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,UserInfoDef[@"imageUrl"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"headIcon"]];
    [headViewBtn addTarget:self action:@selector(headViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.headViewBtn = headViewBtn;
    
    
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:nameBtn];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headBtn.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [nameBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(nameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *nameTextLab = [[UILabel alloc]init];
    [nameBtn addSubview:nameTextLab];
    [nameTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameBtn);
        make.left.equalTo(nameBtn).offset(20);
    }];
    nameTextLab.text = @"昵称";
    
    
    UIImageView *rightArrow2 = [[UIImageView alloc]init];
    [nameBtn addSubview:rightArrow2];
    [rightArrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameBtn);
        make.right.equalTo(nameBtn).offset(-15);
        make.width.height.mas_equalTo(20);
    }];
    rightArrow2.image = [UIImage imageNamed:@"arrow_right"];
    
    UILabel *nameLab = [[UILabel alloc]init];
    [nameBtn addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameBtn);
        make.right.equalTo(rightArrow2.mas_left).offset(-10);
    }];
    nameLab.text = UserInfoDef[@"name"];
    self.nameLab = nameLab;
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:telBtn];
    [telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameBtn.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [telBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [telBtn addTarget:self action:@selector(telBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *telTextLab = [[UILabel alloc]init];
    [telBtn addSubview:telTextLab];
    [telTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telBtn);
        make.left.equalTo(telBtn).offset(20);
    }];
    telTextLab.text = @"手机号码";
    
    
    UIImageView *rightArrow3 = [[UIImageView alloc]init];
    [telBtn addSubview:rightArrow3];
    [rightArrow3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telBtn);
        make.right.equalTo(telBtn).offset(-15);
        make.width.height.mas_equalTo(20);
    }];
    rightArrow3.image = [UIImage imageNamed:@"arrow_right"];
    
    UILabel *telLab = [[UILabel alloc]init];
    [telBtn addSubview:telLab];
    [telLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telBtn);
        make.right.equalTo(rightArrow3.mas_left).offset(-10);
    }];
    telLab.text = UserInfoDef[@"userLogin"];
    self.telLab = telLab;
    
    UIButton *passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:passwordBtn];
    [passwordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telBtn.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [passwordBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [passwordBtn addTarget:self action:@selector(passwordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *passwordTextLab = [[UILabel alloc]init];
    [passwordBtn addSubview:passwordTextLab];
    [passwordTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordBtn);
        make.left.equalTo(passwordBtn).offset(20);
    }];
    passwordTextLab.text = @"修改密码";
    
    
    UIImageView *rightArrow4 = [[UIImageView alloc]init];
    [passwordBtn addSubview:rightArrow4];
    [rightArrow4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordBtn);
        make.right.equalTo(passwordBtn).offset(-15);
        make.width.height.mas_equalTo(20);
    }];
    rightArrow4.image = [UIImage imageNamed:@"arrow_right"];
}

-(void)headViewBtnClick{
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    bigView.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:bigView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [bigView addGestureRecognizer:tap];
    
    UIImageView *headImg = [[UIImageView alloc]initWithImage:self.headViewBtn.imageView.image];
    [bigView addSubview:headImg];
    headImg.contentMode = UIViewContentModeScaleAspectFit;
    self.headImg = headImg;
    
    CGRect newRect = [bigView convertRect:self.headViewBtn.frame fromView:self.headViewBtn.superview];
    headImg.frame = newRect;
    [UIView animateWithDuration:0.5 animations:^{
        headImg.frame = bigView.bounds;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)nameBtnClick{
    ChangeNameController *changeNameVC = [[ChangeNameController alloc]init];
    [self.navigationController pushViewController:changeNameVC animated:YES];
}

-(void)telBtnClick{
    
    ChangeTelephoneController *changeTelephoneVC = [[ChangeTelephoneController alloc]init];
    [self.navigationController pushViewController:changeTelephoneVC animated:YES];
}

-(void)passwordBtnClick{
    
    ChangePasswordViewController *changePasswordVC = [[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}

-(void)tap:(UIGestureRecognizer *)recognizer{
    UIView *bigView = recognizer.view;
//    CGRect newRect = [self.view convertRect:self.headViewBtn.frame fromView:self.headViewBtn.superview];
//    bigView.backgroundColor = [UIColor clearColor];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.headImg.frame = newRect;
//        [self.headImg rounded:40];
//    } completion:^(BOOL finished) {
        [bigView removeFromSuperview];
//    }];
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
                [[UIApplication sharedApplication] openURL:url options:dict completionHandler:nil];
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
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.headViewBtn setImage:originImage forState:UIControlStateNormal];
    [user setObject:UIImageJPEGRepresentation(originImage, 0.03f) forKey:@"headPhoto"];
    //不是从相册里拿的照片,就保存到相册里
    if (![info objectForKey:@"UIImagePickerControllerReferenceURL"]) {
        UIImageWriteToSavedPhotosAlbum(originImage, nil, nil, nil);
    }
    [self uploadHeadImage];
}

-(void)uploadHeadImage{
    NSData *headData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headPhoto"];
    NSString *encodedImageStr = [headData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:UserInfoDef[@"userId"] forKey:@"userID"];
    [param setValue:encodedImageStr forKey:@"imageData"];
    [RequestData POST:@"updateImage" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            [ProgressHUD showSuccess:@"上传成功"];
            [Helper updataUserDefultValue:responseObject[@"imageUrl"] forKey:@"imageUrl"];
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
