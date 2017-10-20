//
//  MeCentreController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "MeCentreController.h"
#import "MeCentreCell.h"

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    MeCentreCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[MeCentreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:[dict objectForKey:@"imageName"]];
    cell.textLab.text = [dict objectForKey:@"text"];
    
    return cell;
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
