//
//  NetworkInstance.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "NetworkInstance.h"

@implementation NetworkInstance
+(AFHTTPSessionManager *)instance{
    static AFHTTPSessionManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [AFHTTPSessionManager manager];
        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
        _instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        _instance.requestSerializer.timeoutInterval = 15.f;
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        [_instance.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    });
    return _instance;
}
@end
