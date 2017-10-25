//
//  BaseTabBarController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "BaseTabBarController.h"
#import "NavViewController.h"
#import "HomeViewController.h"
#import "MeCentreController.h"
#import "ProblemSuperviseController.h"
#import "ProjectMapController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    self.tabBar.tintColor=RGB(0, 188, 203);
}
//添加子控制器
-(void)addChildViewControllers{
    [self addChildViewController:[[HomeViewController alloc]init] title:@"廊道动态" imageName:@"home"];
    [self addChildViewController:[[ProjectMapController alloc]init] title:@"项目博览" imageName:@"ProjectMap"];
    [self addChildViewController:[[ProblemSuperviseController alloc]init] title:@"问题督导" imageName:@"ProblemSupervise"];
    [self addChildViewController:[[MeCentreController alloc]init] title:@"个人中心" imageName:@"MeCentre"];
}
-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName {
    NavViewController *nav = [[NavViewController alloc]initWithRootViewController:childController];
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_default",imageName]];
    UIImage *selected = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
    childController.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

@end
