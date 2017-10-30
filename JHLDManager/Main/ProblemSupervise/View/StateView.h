//
//  StateView.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectedComplete)(NSString *code,NSString *name);
@interface StateView : UIView
@property (nonatomic, copy) selectedComplete selectedCode;
@end
