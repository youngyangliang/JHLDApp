//
//  MeCentreController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "MeCentreController.h"
#import "MeCentreCell.h"
#import "LoginViewController.h"

@interface MeCentreController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MeCentreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)setUpUI{
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableHeaderView = [self headView];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Identifier";
    MeCentreCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[MeCentreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:[dict objectForKey:@"imageName"]];
    cell.textLab.text = [dict objectForKey:@"text"];
    
    return cell;
}

-(UIView *)headView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 160)];
    
    UIImageView *headImg = [[UIImageView alloc]init];
    [headView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
        make.centerX.equalTo(headView);
        make.top.equalTo(headView).offset(30);
    }];
    headImg.image = [UIImage imageNamed:@"headIcon"];
    [headImg rounded:40];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImg.mas_bottom).offset(10);
        make.centerX.equalTo(headView);
    }];
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    nameLabel.text = @"昵称：黄辉";
    
    UIView *line = [[UIView alloc]init];
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headView);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = UIColorFromRGB(0x999999);
    return headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:
  @{@"text":@"个人资料",@"imageName":@"icon_read"},
  @{@"text":@"我的项目",@"imageName":@"icon_project"},
  @{@"text":@"系统设置",@"imageName":@"icon_setting"}, nil];
    }
    return _dataArray;
}


@end
