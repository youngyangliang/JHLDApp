//
//  StartSupervisorViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "StartSupervisorViewController.h"

@interface StartSupervisorViewController ()

@end

@implementation StartSupervisorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起督导";
    [self setUpUI];
}

-(void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *typeTextLabel = [[UILabel alloc]init];
    [self.view addSubview:typeTextLabel];
    [typeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(20);
        make.width.mas_equalTo(100);
    }];
    typeTextLabel.text = @"项目类型:";
    
    UITextField *typeField = [[UITextField alloc]init];
    [self.view addSubview:typeField];
    [typeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeTextLabel);
        make.left.equalTo(typeTextLabel.mas_right);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view).offset(-40);
    }];
    [typeField border:1 color:UIColorFromRGB(0x999999)];
}

@end
