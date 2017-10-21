//
//  HomeCell.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/21.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()

@end

@implementation HomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    
    UILabel *textLab = [[UILabel alloc]init];
    [self.contentView addSubview:textLab];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    self.textLab = textLab;
    textLab.font = FONT(14);
    
    UILabel *dateLab = [[UILabel alloc]init];
    [self.contentView addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(textLab);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    self.dateLab = dateLab;
    dateLab.font = FONT(14);
}

@end
