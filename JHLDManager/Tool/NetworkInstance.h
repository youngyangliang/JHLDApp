//
//  NetworkInstance.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkInstance : AFHTTPSessionManager
+(AFHTTPSessionManager *)instance;
@end
