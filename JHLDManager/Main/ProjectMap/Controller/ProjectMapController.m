//
//  ProjectMapController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ProjectMapController.h"

@interface ProjectMapController ()

@end

@implementation ProjectMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
-(void)setUpUI{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"项目博览",@"示范段博览",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, WIDTH/2, 35);
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = baseColor;
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)segmentedControlValueChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
//            self.mapView.hidden = NO;
//            self.distributionView.hidden = YES;
            break;
        case 1:
//            self.mapView.hidden = YES;
//            self.distributionView.hidden = NO;
            break;
            
        default:
            break;
    }
}

@end
