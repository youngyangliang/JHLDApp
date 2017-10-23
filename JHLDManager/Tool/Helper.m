//
//  Helper.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/21.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "Helper.h"
#import<CommonCrypto/CommonDigest.h>

@implementation Helper
//判断字符串是否为空
+(BOOL) isBlankString:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (string == nil || string == NULL || [string isEqualToString:@"null"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}



+ (NSString *)hanleNums:(NSString *)numbers{
    NSString *str = [numbers substringWithRange:NSMakeRange(numbers.length%3, numbers.length-numbers.length%3)];
    NSString *strs = [numbers substringWithRange:NSMakeRange(0, numbers.length%3)];
    for (int  i =0; i < str.length; i =i+3) {
        NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
    }
    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
    }
    return strs;
}

//视图添加边框
+(void)addBordToView:(UIView *)view andColor:(UIColor *)color andRadius:(int)radius BorderWith:(CGFloat)width
{
    [view.layer setBorderWidth:width];
    view.layer.borderColor=[color CGColor];
    view.layer.cornerRadius=radius;
    view.layer.masksToBounds=YES;
}

//返回格式化时间
+(NSString *)getFormatDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+(void)addCornerRadiusToView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+(UIViewController *)getSuperViewController:(UIView *)view{
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+(BOOL) isPhoneNumber:(NSString *)phoneNumber{
    NSString *phoneNoRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNoRegex];
    return [pred evaluateWithObject:phoneNumber];
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
