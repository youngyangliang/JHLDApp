//
//  ProjectDifficultyListModel.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/11/1.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectDifficultyListModel : NSObject
@property (nonatomic, copy) NSString *diffid;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *projectcontent;
@property (nonatomic, copy) NSString *projectname;
@property (nonatomic, copy) NSString *projecttime;
@property (nonatomic, copy) NSString *projecttype;
@property (nonatomic, copy) NSString *projectunit;
@end
