//
//  UserInfoModel.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/24.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString *userId;//用户标识id
@property (nonatomic, copy) NSString *roleId;//角色id
@property (nonatomic, copy) NSString *userLogin;//用户名
@property (nonatomic, copy) NSString *name;//昵称
@property (nonatomic, copy) NSString *imageUrl;//头像
@end
