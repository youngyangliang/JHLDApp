//
//  HomeChartView.h
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/25.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectInvestmentModel.h"
#import "ProjectProgressModel.h"

@interface HomeChartView : UIView
-(instancetype)initWithModel:(ProjectInvestmentModel *)projectInvestmentModel;
@end
