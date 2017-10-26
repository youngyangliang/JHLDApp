//
//  ProjectInvestmentModel.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/26.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ProjectInvestmentModel.h"
#import "ProjectProgressModel.h"

@implementation ProjectInvestmentModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"area":[ProjectProgressModel class]};
}
@end
