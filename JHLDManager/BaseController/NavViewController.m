//
//  NavViewController.m
//  huanjing
//
//  Created by 杨亮 on 2017/8/28.
//  Copyright © 2017年 com.booway. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //RGB(35, 159, 95)
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
     [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_home_city_background_white"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setImage:[UIImage imageNamed:@"left_back"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"left_back"] forState:UIControlStateHighlighted];
//        button.frame = CGRectMake(0, 0, 44, 44);
//        [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }
    [super pushViewController:viewController animated:animated];
}


@end
