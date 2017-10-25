//
//  ChangeNameController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/24.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ChangeNameController.h"

@interface ChangeNameController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *nameField;
@end

@implementation ChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    
    UIImageView *logoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bigLogo"]];
    [scrollView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    YLTextField *nameField = [[YLTextField alloc]init];
    [scrollView addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImg.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
    }];
    nameField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_icon"]];
    nameField.leftViewMode = UITextFieldViewModeAlways;
    [Helper addBordToView:nameField andColor:baseColor andRadius:25 BorderWith:1];
    nameField.placeholder = @"请输入新的昵称";
    [nameField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    [nameField setValue:baseColor forKeyPath:@"_placeholderLabel.textColor"];
    nameField.delegate = self;
    self.nameField = nameField;
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    nameField.text = UserInfoDef[@"name"];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameField.mas_bottom).offset(20);
        make.left.right.height.equalTo(nameField);
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
        [param setValue:self.nameField.text forKey:@"name"];
        [RequestData POST:@"updateUser" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
            if (responseOK) {
                [ProgressHUD showSuccess:@"修改成功"];
                [Helper updataUserDefultValue:self.nameField.text forKey:@"name"];
                [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_USERINFO object:nil];
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
    if ([Helper isBlankString:self.nameField.text]) {
        [ProgressHUD showError:@"请输入新的昵称"];
        return NO;
    }
    return YES;
}


@end
