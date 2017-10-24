//
//  BaseScrollView.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.backgroundColor = [UIColor whiteColor];
        }
    }
    return self;
}

@end
