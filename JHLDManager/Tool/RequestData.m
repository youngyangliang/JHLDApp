//
//  RequestData.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    response:(responseBlock)response{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,URLString];
    [[NetworkInstance instance] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0];
        NSDictionary *jsonDict = (NSDictionary *)json;
        BOOL responseOK = NO;
        if ([[jsonDict objectForKey:@"code"] isEqualToString:@"200"]) {
            responseOK = YES;
        }else{
            responseOK = NO;
        }
        if (response) {
            response([jsonDict objectForKey:@"data"],responseOK,[jsonDict objectForKey:@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (response) {
            response(@{},NO,@"网络异常");
        }
    }];
}
@end
