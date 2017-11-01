//
//  AreaView.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "AreaView.h"

@interface AreaView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectPath;
@end

@implementation AreaView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.frame.size.height) style:UITableViewStylePlain];
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.tableFooterView = [[UIView alloc]init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"selectedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"area"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int newRow = (int)[indexPath row];
    int oldRow = (int)(_selectPath != nil) ? (int)[_selectPath row]:-1;
    if (newRow != oldRow) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_selectPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _selectPath = [indexPath copy];
    }
     NSDictionary *dict = self.dataArray[indexPath.row];
    if (self.selectedCode) {
        self.selectedCode([dict objectForKey:@"areaCode"],[dict objectForKey:@"area"]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:
                      @{@"area":@"全部",@"areaCode":@""},
                      @{@"area":@"婺城区",@"areaCode":@"330702"},
                      @{@"area":@"金东区",@"areaCode":@"330703"},
                      @{@"area":@"武义县",@"areaCode":@"330723"},
                      @{@"area":@"浦江县",@"areaCode":@"330726"},
                      @{@"area":@"磐安县",@"areaCode":@"330727"},
                      @{@"area":@"兰溪市",@"areaCode":@"330781"},
                      @{@"area":@"义乌市",@"areaCode":@"330782"},
                      @{@"area":@"东阳市",@"areaCode":@"330783"},
                      @{@"area":@"永康市",@"areaCode":@"330784"},
                      @{@"area":@"金华开发区",@"areaCode":@"330704"},
                      @{@"area":@"金义都市新区",@"areaCode":@"330705"},
                      @{@"area":@"金华山旅游经济区",@"areaCode":@"330706"},
                      
                      nil];
    }
    return _dataArray;
}

@end
