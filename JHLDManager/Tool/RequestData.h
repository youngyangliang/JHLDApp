//
//  RequestData.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/23.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkInstance.h"

typedef void(^responseBlock)(id responseObject,BOOL responseOK,NSString *msg);
@interface RequestData : NSObject
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    response:(responseBlock)response;

+ (void)AppPOST:(NSString *)URLString
     parameters:(id)parameters
       response:(responseBlock)response;

@end
