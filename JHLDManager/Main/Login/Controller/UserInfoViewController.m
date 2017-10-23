//
//  UserInfoViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self setUpUI];
}

-(void)setUpUI{
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = backgroudColor;
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [headBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
