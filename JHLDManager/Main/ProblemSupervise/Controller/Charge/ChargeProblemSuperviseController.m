//
//  ChargeProblemSuperviseController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/11/1.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ChargeProblemSuperviseController.h"
#import "ChargeSuperviseController.h"
#import "ChargeDifficultyController.h"
#import "ChargeReactController.h"

@interface ChargeProblemSuperviseController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>
@property (nonatomic, weak) SGPageTitleView *pageTitleView;
@property (nonatomic, weak) SGPageContentView *pageContentView;

@end

@implementation ChargeProblemSuperviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
-(void)setUpUI{
    // 子标题及 pageTitleView 的创建
    NSArray *titleArr = @[@"项目督导", @"项目难点",@"公众反应"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleSelectedColor = baseColor;
    configure.spacingBetweenButtons = 15;
    configure.indicatorColor = baseColor;
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, 250, 44) delegate:self titleNames:titleArr configure:configure];
    pageTitleView.isShowBottomSeparator = NO;
    pageTitleView.isNeedBounces = NO;
    self.navigationItem.titleView = pageTitleView;
    self.pageTitleView = pageTitleView;
    
    // 子控制器及 pageContentView 的创建
    ChargeSuperviseController *oneVC = [[ChargeSuperviseController alloc] init];
    ChargeDifficultyController *twoVC = [[ChargeDifficultyController alloc] init];
    ChargeReactController *threeVC = [[ChargeReactController alloc] init];
    /// 子控制器数组
    NSArray *childVCArr = @[oneVC, twoVC,threeVC];
    
    CGFloat contentViewHeight = HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT;
    SGPageContentView *pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, contentViewHeight) parentVC:self childVCs:childVCArr];
    pageContentView.delegatePageContentView = self;
    self.pageContentView = pageContentView;
    [self.view addSubview:pageContentView];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}
@end
