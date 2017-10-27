//
//  ProblemSuperviseController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ProblemSuperviseController.h"
#import "ProblemSuperviseCell.h"
#import "SuperviseDetailController.h"
#import "ProblemSuperviseModel.h"
#define buttonsViewH 40

@interface ProblemSuperviseController ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *areacode;
@property (nonatomic, copy) NSString *projecttype;
@property (nonatomic, copy) NSString *projectstatus;

@end

@implementation ProblemSuperviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
-(void)setUpUI{
    // 子标题及 pageTitleView 的创建
    NSArray *titleArr = @[@"项目督导", @"项目难点", @"公众反映"];
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, 250, 44) delegate:self titleNames:titleArr configure:[SGPageTitleViewConfigure pageTitleViewConfigure]];
    pageTitleView.isShowBottomSeparator = NO;
    pageTitleView.isNeedBounces = NO;
    self.navigationItem.titleView = pageTitleView;
    [self setUpButtons];
    [self setUpSupervise];
    [self loadData];
}

-(void)setUpButtons{
    NSArray *textArray = @[@"区域",@"类型",@"状态"];
    UIView *buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, buttonsViewH)];
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


-(void)segmentedControlValueChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            //            self.mapView.hidden = NO;
            //            self.distributionView.hidden = YES;
            break;
        case 1:
            //            self.mapView.hidden = YES;
            //            self.distributionView.hidden = NO;
            break;
            
        default:
            break;
    }
}

-(void)loadData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.areacode forKey:@"areacode"];
    [param setValue:self.projecttype forKey:@"projecttype"];
    [param setValue:self.projectstatus forKey:@"projectstatus"];
    [RequestData AppPOST:@"projectMoniList" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
            for (NSDictionary *dict in responseObject) {
                ProblemSuperviseModel *model = [ProblemSuperviseModel mj_objectWithKeyValues:dict];
                [self.dataArray addObject:model];
            }
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

-(void)setUpSupervise{
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, buttonsViewH, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT-buttonsViewH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = backgroudColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]init];
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
}

-(void)refreshNewData{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"superviseCell";
    ProblemSuperviseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ProblemSuperviseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    ProblemSuperviseModel *model = self.dataArray[indexPath.row];
    SuperviseDetailController *detailVC = [[SuperviseDetailController alloc]init];
//    detailVC.projectId = model.projectid;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
