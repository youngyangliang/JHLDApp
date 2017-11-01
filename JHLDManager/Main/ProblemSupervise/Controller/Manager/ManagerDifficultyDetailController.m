//
//  ManagerDifficultyDetailController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/11/1.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ManagerDifficultyDetailController.h"

@interface ManagerDifficultyDetailController ()

@end

@implementation ManagerDifficultyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"难点详情";
    [self loadData];
}

-(void)loadData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.diffid forKey:@"diffid"];
    [RequestData AppPOST:@"projectDifficultyDetail" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

@end
