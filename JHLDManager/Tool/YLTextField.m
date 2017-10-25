//
//  YLTextField.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/24.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "YLTextField.h"

@implementation YLTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    iconRect.size.height = 27;
    iconRect.size.width = 25;
    return iconRect;
}
//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 50, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{

    return CGRectInset(bounds, 50, 0);
}


@end
