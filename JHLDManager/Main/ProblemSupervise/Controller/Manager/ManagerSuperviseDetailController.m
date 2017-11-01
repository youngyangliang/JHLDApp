//
//  ManagerSuperviseDetailController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/11/1.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ManagerSuperviseDetailController.h"

@interface ManagerSuperviseDetailController ()

@end

@implementation ManagerSuperviseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"督导详情";
    [self loadData];
}

-(void)loadData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.projectId forKey:@"superid"];
    [RequestData AppPOST:@"projectMoniDetail" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

@end
