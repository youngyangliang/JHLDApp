//
//  UIView+Category.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "UIView+Category.h"

#define vAlertTag    10086

@implementation UIView (Category)
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic origin;
@dynamic size;

#pragma mark ---------------- Setters-----------------
-(void)setX:(CGFloat)x{
    CGRect r        = self.frame;
    r.origin.x      = x;
    self.frame      = r;
}

-(void)setY:(CGFloat)y{
    CGRect r        = self.frame;
    r.origin.y      = y;
    self.frame      = r;
}

-(void)setWidth:(CGFloat)width{
    CGRect r        = self.frame;
    r.size.width    = width;
    self.frame      = r;
}

-(void)setHeight:(CGFloat)height{
    CGRect r        = self.frame;
    r.size.height   = height;
    self.frame      = r;
}

-(void)setOrigin:(CGPoint)origin{
    self.x          = origin.x;
    self.y          = origin.y;
}

-(void)setSize:(CGSize)size{
    self.width      = size.width;
    self.height     = size.height;
}

-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

-(void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark ---------------- Getters-----------------
-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(UIView *)lastSubviewOnX{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.x > outView.x)
                outView = v;
        
        return outView;
    }
    
    return nil;
}

-(UIView *)lastSubviewOnY{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.y > outView.y)
                outView = v;
        
        return outView;
    }
    
    return nil;
}

#pragma mark ---------------- other-----------------
/**
 * @brief 移除此view上的所有子视图
 */
- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    return;
}

/**
 @brief 弹窗
 @param title 弹窗标题
 message 弹窗信息
 */
+ (void) showAlertView: (NSString*) title andMessage: (NSString *) message
{
    dispatch_async(dispatch_get_main_queue() , ^{
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = title;
        alert.message = message;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}

/**
 *  弹窗
 *
 *  @param title    弹窗标题
 *  @param message  弹窗信息
 *  @param delegate 弹窗代理
 */
+ (void) showAlertView: (NSString*) title
            andMessage: (NSString *) message
          withDelegate: (UIViewController<UIAlertViewDelegate> *) delegate
{
    dispatch_async(dispatch_get_main_queue() , ^{
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = title;
        alert.message = message;
        alert.delegate = delegate;
        alert.tag = vAlertTag;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}

#pragma mark - layer
- (void)rounded:(CGFloat)cornerRadius {
    [self rounded:cornerRadius width:0 color:nil];
}

- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor {
    [self rounded:0 width:borderWidth color:borderColor];
}

- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}


-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    //给Cell设置阴影效果
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}


#pragma mark - base
- (UIViewController *)viewController {
    
    id nextResponder = [self nextResponder];
    while (nextResponder != nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            return vc;
        }
        nextResponder = [nextResponder nextResponder];
    }
    return nil;
}

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
@end
