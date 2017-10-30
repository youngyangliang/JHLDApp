//
//  StateView.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "StateView.h"

@interface StateView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectPath;
@end

@implementation StateView

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
    cell.textLabel.text = [dict objectForKey:@"state"];
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
        self.selectedCode([dict objectForKey:@"stateCode"],[dict objectForKey:@"state"]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:
                      @{@"state":@"全部",@"stateCode":@"0"},
                      @{@"state":@"已反馈",@"stateCode":@"1"},
                      @{@"state":@"未反馈",@"stateCode":@"2"},
                      nil];
    }
    return _dataArray;
}


@end
