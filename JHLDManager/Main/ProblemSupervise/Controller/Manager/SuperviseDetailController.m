//
//  SuperviseDetailController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/27.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "SuperviseDetailController.h"

@interface SuperviseDetailController ()

@end

@implementation SuperviseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

-(void)loadData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.projectId forKey:@"projectid"];
    [RequestData AppPOST:@"projectMoniDetail" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}


@end
