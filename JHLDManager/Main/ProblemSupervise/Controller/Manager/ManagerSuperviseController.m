//
//  ManagerSuperviseController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ManagerSuperviseController.h"
#import "ProblemSuperviseCell.h"
#import "SuperviseDetailController.h"
#import "ProblemSuperviseModel.h"
#import "AreaView.h"
#import "TypeView.h"
#import "StateView.h"
#import "StartSupervisorViewController.h"

#define buttonsViewH 40
#define searchViewH  0

@interface ManagerSuperviseController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, weak) AreaView *areaView;
@property (nonatomic, weak) TypeView *typeView;
@property (nonatomic, weak) StateView *stateView;
@property (nonatomic, weak) UIView *selectedView;

@property (nonatomic, copy) NSString *areacode;
@property (nonatomic, copy) NSString *projecttype;
@property (nonatomic, copy) NSString *projectstatus;

@end

@implementation ManagerSuperviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpButtons];
    [self setUpTableView];
    [self setUpButton];
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
        [button setTitleColor:baseColor forState:UIControlStateSelected];
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
    if (btn.selected) {
        return;
    }
    self.btn.selected = NO;
    btn.selected = YES;
    self.btn = btn;
    
    if (!self.bgView) {
        UIView *bgView = [[UIView alloc]init];
        self.bgView = bgView;
        [self.view addSubview:bgView];
        bgView.frame = CGRectMake(0, CGRectGetMaxY(btn.frame), WIDTH, HEIGHT);
        bgView.backgroundColor = RGBA(0, 0, 0, 0.3);
    }
    self.bgView.hidden = NO;
    self.selectedView.hidden = YES;
    switch (btn.tag) {
        case 1:
        {
            if (!self.areaView) {
                AreaView *areaView = [[AreaView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
                self.areaView = areaView;
                areaView.selectedCode = ^(NSString *code,NSString *name) {
                    [btn setTitle:name forState:UIControlStateNormal];
                    self.areacode = code;
                    [self hiddenBgView];
                };
                areaView.backgroundColor = [UIColor whiteColor];
                [self.bgView addSubview:areaView];
            }
            self.areaView.hidden = NO;
            self.selectedView = self.areaView;
        }
            break;
        case 2:
        {
            if (!self.typeView) {
                TypeView *typeView = [[TypeView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
                self.typeView = typeView;
                typeView.backgroundColor = [UIColor whiteColor];
                [self.bgView addSubview:typeView];
                typeView.selectedCode = ^(NSString *code,NSString *name) {
                    [btn setTitle:name forState:UIControlStateNormal];
                    self.projecttype = code;
                    [self hiddenBgView];
                };
            }
            self.typeView.hidden = NO;
            self.selectedView = self.typeView;
        }
            break;
        case 3:
        {
            if (!self.stateView) {
                StateView *stateView = [[StateView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
                self.stateView = stateView;
                stateView.backgroundColor = [UIColor whiteColor];
                [self.bgView addSubview:stateView];
                stateView.selectedCode = ^(NSString *code,NSString *name) {
                    [btn setTitle:name forState:UIControlStateNormal];
                    self.projectstatus = code;
                    [self hiddenBgView];
                };
            }
            self.stateView.hidden = NO;
            self.selectedView = self.stateView;
        }
            break;
            
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hiddenBgView];
}

-(void)hiddenBgView{
    self.bgView.hidden = YES;
    self.btn.selected = NO;
    self.btn = nil;
}

-(void)setUpTableView{
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

-(void)setUpButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    CGFloat btnW = 60;
    btn.frame = CGRectMake(WIDTH-btnW-15, CGRectGetMaxY(self.tableView.frame)-btnW-30, btnW, btnW);
    btn.alpha = 0.5;
    [btn setTitle:@"发起督导" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(14);
    [btn rounded:btnW/2];
    [btn setBackgroundColor:baseColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick{
    StartSupervisorViewController *VC = [[StartSupervisorViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
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
            [self.tableView reloadData];
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
