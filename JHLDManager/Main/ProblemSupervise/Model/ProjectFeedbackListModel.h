//
//  ProjectFeedbackListModel.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/11/1.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectFeedbackListModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *reporttime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@end
