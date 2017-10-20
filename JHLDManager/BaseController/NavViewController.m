//
//  NavViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_home_city_background_white"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
}

//重写push方法，统一设置push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        // 隐藏tabbar
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"checkout_back_arrow"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"checkout_back_arrow"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backButtonClick{
    [self popViewControllerAnimated:YES];
}

@end
