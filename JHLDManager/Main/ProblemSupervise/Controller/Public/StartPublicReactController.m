//
//  StartPublicReactController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/11/1.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "StartPublicReactController.h"

@interface StartPublicReactController ()

@end

@implementation StartPublicReactController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self upData];
}

-(void)upData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"" forKey:@"projectid"];
    [param setValue:@"" forKey:@"title"];
    [param setValue:@"" forKey:@"address"];
    [param setValue:@"" forKey:@"projectname"];
    [param setValue:@"" forKey:@"remark"];
    [param setValue:@"" forKey:@"soruceid"];
    [RequestData AppPOST:@"saveProjectFeedback" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
            
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

@end
