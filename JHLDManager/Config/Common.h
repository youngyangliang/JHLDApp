//
//  Common.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define TabBar_HEIGHT  (kDevice_Is_iPhoneX==1?83:49)
#define NavgBar_HEIGHT  (kDevice_Is_iPhoneX==1?88:64)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB(r,g,b)               RGBA(r,g,b,1)
#define RGBC(c)               RGBA(c,c,c,1)

#define baseColor RGB(69, 179, 196)
#define backgroudColor RGB(240, 240, 240)
//字体
#define FONT(s) [UIFont systemFontOfSize:s]

#endif /* Common_h */
