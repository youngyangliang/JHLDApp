//
//  ProblemSuperviseCell.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/26.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ProblemSuperviseCell.h"

@interface ProblemSuperviseCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UILabel *feedbackLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *msgLabel;
@end
@implementation ProblemSuperviseCell

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
        make.height.width.mas_equalTo(85);
        make.top.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    [imgView rounded:5];
    imgView.backgroundColor = UIColorFromRGB(0x007f7f);
    self.imgView = imgView;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView);
        make.left.equalTo(imgView.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    self.nameLabel = nameLabel;
    nameLabel.font = FONT(16);
    nameLabel.text = @"湖海塘公园项目";
    
    UILabel *feedbackLabel = [[UILabel alloc]init];
    [self.contentView addSubview:feedbackLabel];
    [feedbackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(4);
        make.left.equalTo(nameLabel);
    }];
    self.feedbackLabel = feedbackLabel;
    feedbackLabel.font = FONT(16);
    feedbackLabel.text = @"未反馈";
    
    UILabel *typeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feedbackLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    self.typeLabel = typeLabel;
    typeLabel.font = FONT(16);
    typeLabel.text = @"示范项目";
    typeLabel.textColor = baseColor;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feedbackLabel.mas_bottom).offset(4);
        make.left.equalTo(feedbackLabel);
    }];
    self.timeLabel = timeLabel;
    timeLabel.font = FONT(16);
    timeLabel.textColor = RGBC(160);
    timeLabel.text = @"2017-10-26 17:53";
    
    UILabel *msgLabel = [[UILabel alloc]init];
    [self.contentView addSubview:msgLabel];
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(4);
        make.left.equalTo(timeLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    self.msgLabel = msgLabel;
    msgLabel.textColor = RGBC(160);
    msgLabel.font = FONT(16);
    msgLabel.text = @"项目进展太慢，现场很多垃圾，脏乱差。项目进展太慢，现场很多垃圾，脏乱差";
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = backgroudColor;
}

@end
