//
//  MeCentreCell.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "MeCentreCell.h"

@implementation MeCentreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    UIImageView *imgView = [[UIImageView alloc]init];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.height.width.mas_equalTo(25);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    self.imgView = imgView;
    
    UILabel *textLab = [[UILabel alloc]init];
    [self.contentView addSubview:textLab];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgView);
        make.left.equalTo(imgView.mas_right).offset(15);
    }];
    textLab.textColor = [UIColor whiteColor];
    self.textLab = textLab;
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = UIColorFromRGB(0x999999);
}

@end
