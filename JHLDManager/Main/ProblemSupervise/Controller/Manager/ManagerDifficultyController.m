//
//  ManagerDifficultyController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ManagerDifficultyController.h"
#import "ProjectDifficultCell.h"

#define buttonsViewH 40
#define searchViewH  0

@interface ManagerDifficultyController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *areacode;
@property (nonatomic, copy) NSString *projecttype;
@property (nonatomic, copy) NSString *projectstatus;

@end

@implementation ManagerDifficultyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpButtons];
    [self setUpSupervise];
    [self loadData];
}
-(void)setUpButtons{
    
    //    UISearchBar *searchBar = [[UISearchBar alloc] init];
    //    [self.view addSubview:searchBar];
    //    searchBar.frame = CGRectMake(0, 0, WIDTH, searchViewH);
    //    self.searchBar = searchBar;
    //    searchBar.barTintColor = RGB(200, 200, 200);
    //    searchBar.delegate = self;
    //    [searchBar setPlaceholder:@"请输入关键字"];
    //    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    
    NSArray *textArray = @[@"区域",@"类型",@"状态"];
    UIView *buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, searchViewH, WIDTH, buttonsViewH)];
    [self.view addSubview:buttonsView];
    buttonsView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, buttonsView.frame.size.width, 1)];
    [buttonsView addSubview:lineView];
    lineView.backgroundColor = UIColorFromRGB(0xc8c7cc);
    
    CGFloat buttonW = WIDTH/textArray.count;
    for (int i = 0; i<textArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        [buttonsView addSubview:button];
        CGFloat buttonX = i*buttonW;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonsViewH);
        [button setTitle:textArray[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x15aaff) forState:UIControlStateSelected];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, button.frame.size.width*0.25);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setImage:[UIImage imageNamed:@"downArraw"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.frame.size.width*0.8, 0, button.frame.size.width*0.08);
        [button addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 1; i<textArray.count; i++) {
        UIView *line = [[UIView alloc]init];
        [buttonsView addSubview:line];
        line.backgroundColor = UIColorFromRGB(0xebebeb);
        line.frame = CGRectMake(buttonW*i, 8, 1, 24);
    }
    UIView *bottomLine = [[UIView alloc]init];
    [buttonsView addSubview:bottomLine];
    bottomLine.backgroundColor = UIColorFromRGB(0xebebeb);
    bottomLine.frame = CGRectMake(0, buttonsViewH-1, WIDTH, 1);
}

-(void)selectButtonClick:(UIButton *)btn{
    
}

-(void)setUpSupervise{
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, buttonsViewH+searchViewH, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT-buttonsViewH-searchViewH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = backgroudColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]init];
    //    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.dataArray.count;
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"superviseCell";
    ProjectDifficultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ProjectDifficultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)loadData{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:self.areacode forKey:@"areacode"];
//    [param setValue:self.projecttype forKey:@"projecttype"];
//    [param setValue:self.projectstatus forKey:@"projectstatus"];
//    [RequestData AppPOST:@"projectMoniList" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
//        if (responseOK) {
//            NSLog(@"%@",responseObject);
//            for (NSDictionary *dict in responseObject) {
//                ProblemSuperviseModel *model = [ProblemSuperviseModel mj_objectWithKeyValues:dict];
//                [self.dataArray addObject:model];
//                [self.tableView reloadData];
//            }
//        }else{
//            [ProgressHUD showError:msg];
//        }
//    }];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
