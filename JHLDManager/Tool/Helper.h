//
//  Helper.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/21.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
//判断字符串是否为空
+(BOOL)isBlankString:(NSString*)string;
//,

//视图添加边框
+(void)addBordToView:(UIView*)view andColor:(UIColor*)color andRadius:(int)radius BorderWith:(CGFloat)width;

//返回格式化时间
+(NSString *)getFormatDate:(NSDate *)date;

//返回格式化时间 年 月
+(NSString *)getYYMMFormatDate:(NSDate *)date;
//返回格式化时间 年
+(NSString *)getYYFormatDate:(NSDate *)date;

+(void)addCornerRadiusToView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

//获取控制器
+(UIViewController *)getSuperViewController:(UIView *)view;
//随机颜色
+ (UIColor *)randomColor;

+ (NSString *)hanleNums:(NSString *)numbers;

//验证是否为手机号
+(BOOL) isPhoneNumber:(NSString *)phoneNumber;

+ (NSString *) md5:(NSString *) input;

+(void)updataUserDefultValue:(nullable id)value forKey:(nullable NSString *)key;
@end
