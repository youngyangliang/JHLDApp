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
    self.view.backgroundColor = backgroudColor;
    
    YLTextField *nameField = [[YLTextField alloc]init];
    [self.view addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    nameField.backgroundColor = [UIColor whiteColor];
    nameField.placeholder = @"请输入新的昵称";
    [nameField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    self.nameField = nameField;
    nameField.delegate = self;
//    [nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [nameField becomeFirstResponder];
    nameField.text = UserInfoDef[@"name"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameField.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(changeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:baseColor forState:UIControlStateNormal];
    [button rounded:5];
    
}

-(void)changeButtonClick{
    
}
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.nameField) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//    }
//}


@end
