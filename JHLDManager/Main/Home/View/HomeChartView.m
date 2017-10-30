//
//  HomeChartView.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/25.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "HomeChartView.h"


#define lineColor UIColorFromRGB(0x999999)


@interface HomeChartView ()
@property (nonatomic, strong) ProjectInvestmentModel *projectInvestmentModel;
@end

@implementation HomeChartView

-(instancetype)initWithModel:(ProjectInvestmentModel *)projectInvestmentModel{
    if (self = [super init]) {
        self.projectInvestmentModel = projectInvestmentModel;
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    UILabel *titleLab = [[UILabel alloc]init];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.centerX.equalTo(self);
    }];
    titleLab.font = FONT(16);
    titleLab.text = [NSString stringWithFormat:@"截止%@  区域投资完成情况",[Helper getYYMMFormatDate:[NSDate date]]];
    
    for (int i = 0; i<3; i++) {
        UIImageView *colorImg = [[UIImageView alloc]init];
        [self addSubview:colorImg];
        [colorImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).offset(10+i*(10+5));
            make.left.equalTo(self).offset(15);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(20);
        }];
        
        UILabel *colorTextLab = [[UILabel alloc]init];
        [self addSubview:colorTextLab];
        [colorTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(colorImg);
            make.left.equalTo(colorImg.mas_right).offset(5);
        }];
        colorTextLab.font = FONT(12);
        switch (i) {
            case 0:
                colorImg.backgroundColor = RGB(220, 100, 6);
                colorTextLab.text = [NSString stringWithFormat:@"%@计划投资",[Helper getYYFormatDate:[NSDate date]]];
                break;
            case 1:
                colorImg.backgroundColor = RGB(250, 190, 0);
                colorTextLab.text = [NSString stringWithFormat:@"%@已完成投资",[Helper getYYFormatDate:[NSDate date]]];
                break;
            case 2:
                colorImg.image = [UIImage imageNamed:@"home_line_icon"];
                colorTextLab.text = [NSString stringWithFormat:@"%@投资完成率",[Helper getYYFormatDate:[NSDate date]]];
            {
                UILabel *unitTextLab = [[UILabel alloc]init];
                [self addSubview:unitTextLab];
                [unitTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-20);
                    make.bottom.equalTo(colorImg);
                }];
                unitTextLab.font = FONT(12);
                unitTextLab.text = @"单位：亿元";
            }
                break;
            default:
                break;
        }
    }
    
    UIView *leftYLine = [[UIView alloc]init];
    [self addSubview:leftYLine];
    [leftYLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(80);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(1);
        make.left.equalTo(self).offset(50);
    }];
    leftYLine.backgroundColor = lineColor;
    
    UIView *rightYLine = [[UIView alloc]init];
    [self addSubview:rightYLine];
    [rightYLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(leftYLine);
        make.right.equalTo(self).offset(-50);
    }];
    rightYLine.backgroundColor = lineColor;
    
    for (int i = 0; i<7; i++) {
        UIView *leftScale = [[UIView alloc]init];
        [self addSubview:leftScale];
        [leftScale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(leftYLine);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(1);
            make.top.equalTo(leftYLine).offset(i*25);
        }];
        leftScale.backgroundColor = lineColor;
        
        UILabel *leftScaleValue = [[UILabel alloc]init];
        [self addSubview:leftScaleValue];
        [leftScaleValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftScale);
            make.right.equalTo(leftScale.mas_left).offset(-5);
        }];
        leftScaleValue.font = FONT(12);
        self.projectInvestmentModel.max = @"120";
        leftScaleValue.text = [NSString stringWithFormat:@"%d",[self.projectInvestmentModel.max intValue] - i*([self.projectInvestmentModel.max intValue]/6)];
    }
    for (int i = 0; i<11; i++) {
        UIView *rightScale = [[UIView alloc]init];
        [self addSubview:rightScale];
        [rightScale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightYLine);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(1);
            make.top.equalTo(rightYLine).offset(i*15);
        }];
        rightScale.backgroundColor = lineColor;
        
        UILabel *rightScaleValue = [[UILabel alloc]init];
        [self addSubview:rightScaleValue];
        [rightScaleValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(rightScale);
            make.left.equalTo(rightScale.mas_right).offset(5);
        }];
        rightScaleValue.font = FONT(12);
        rightScaleValue.text = [NSString stringWithFormat:@"%d%%",100-i*10];
    }
    
    UIScrollView *chartScrollView = [[UIScrollView alloc]init];
    [self addSubview:chartScrollView];
    [chartScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftYLine);
        make.left.equalTo(leftYLine.mas_right);
        make.right.equalTo(rightYLine.mas_left);
        make.bottom.equalTo(leftYLine).offset(25);
    }];
    
    UIView *Xline = [[UIView alloc]init];
    [chartScrollView addSubview:Xline];
    [Xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartScrollView);
        make.top.equalTo(chartScrollView).offset(150);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(50*self.projectInvestmentModel.area.count);
    }];
    Xline.backgroundColor = lineColor;
    
     NSMutableArray *pointArray = [NSMutableArray array];
    for (int i = 0; i<self.projectInvestmentModel.area.count; i++) {
        ProjectProgressModel *progressModel = self.projectInvestmentModel.area[i];
        progressModel.plan = [NSString stringWithFormat:@"%d",arc4random() % 120+1];
        progressModel.fact = [NSString stringWithFormat:@"%d",arc4random() % [progressModel.plan intValue]];
        progressModel.per = [NSString stringWithFormat:@"%d",arc4random() % 90+10];
        
        UIView *planView = [[UIView alloc]init];
        [chartScrollView addSubview:planView];
        [planView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(chartScrollView).offset(10+(30+20)*i);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(150/[self.projectInvestmentModel.max intValue]*[progressModel.plan intValue]);
            make.bottom.equalTo(Xline.mas_top);
        }];
        planView.backgroundColor = RGB(220, 100, 6);
        
        UIView *factView = [[UIView alloc]init];
        [chartScrollView addSubview:factView];
        [factView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(planView);
            make.height.mas_equalTo(150/[self.projectInvestmentModel.max intValue]*[progressModel.fact intValue]);
        }];
        factView.backgroundColor = RGB(250, 190, 0);
        
        UIImageView *dotImg = [[UIImageView alloc]init];
        [chartScrollView addSubview:dotImg];
        [dotImg rounded:3];
        dotImg.backgroundColor = baseColor;
        CGFloat dotX = 25 + i*50;
        CGFloat dotY = 150 - ([progressModel.per intValue]/100.0*150);
        [dotImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(chartScrollView.mas_left).offset(dotX);
            make.centerY.equalTo(chartScrollView.mas_top).offset(dotY);
            make.width.height.mas_equalTo(6);
        }];
        
        CGPoint point = CGPointMake(dotX, dotY);
        NSValue *value = [NSValue valueWithCGPoint:point];
        [pointArray addObject:value];
        
        UILabel *areaLab = [[UILabel alloc]init];
        [chartScrollView addSubview:areaLab];
        [areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(planView);
            make.top.equalTo(Xline.mas_bottom).offset(5);
        }];
        areaLab.font = FONT(12);
        NSString *subStr = [progressModel.areaname substringToIndex:3];
        areaLab.text = subStr;
    }
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    for (int i = 0; i<pointArray.count; i++) {
        NSValue *tmpValue = pointArray[i];
        CGPoint point = [tmpValue CGPointValue];
        if (i==0) {
            [linePath moveToPoint:CGPointMake(point.x, point.y)];
        }
        [linePath addLineToPoint:CGPointMake(point.x, point.y)];
    }
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 2;
    lineLayer.strokeColor = baseColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    [chartScrollView.layer addSublayer:lineLayer];
    
    chartScrollView.contentSize = CGSizeMake(50*self.projectInvestmentModel.area.count, 0);
    chartScrollView.bounces = NO;
    chartScrollView.showsHorizontalScrollIndicator = NO;
    
}

@end
