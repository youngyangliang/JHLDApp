//
//  HomeViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "ProjectAnalysisModel.h"
#import "HomeChartView.h"

#define buttonHeight 110
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UILabel *qb;
@property (nonatomic, weak) UILabel *qq;
@property (nonatomic, weak) UILabel *sg;
@property (nonatomic, weak) UILabel *wg;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

-(void)setUpUI{

    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-TabBar_HEIGHT-NavgBar_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = backgroudColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableHeaderView = [self tableViewHeadView];
    tableView.tableFooterView = [self tableViewFootView];
    
}

-(UIView *)tableViewHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
   
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), CGRectGetHeight(headView.frame)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.autoScrollTimeInterval = 3;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    [headView addSubview:cycleScrollView];
    
    //        NSMutableArray *imagesURLStrings = [NSMutableArray array];
    NSArray *titles = @[@"金华市召开全市生态廊道办主任会议",
                        @"张荣贵义务调研生态廊道建设工作",
                        @"生态廊道天时地利人和"
                        ];
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    cycleScrollView.titlesGroup = titles;
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    return headView;
}

-(UIView *)tableViewFootView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 490)];
    footView.backgroundColor = [UIColor whiteColor];
    UIView *line1 = [[UIView alloc]init];
    [footView addSubview:line1];
    line1.frame = CGRectMake(0, 0, CGRectGetWidth(footView.frame), 40);
    line1.backgroundColor = RGBC(240);
    
    UILabel *progressTextLab = [[UILabel alloc]init];
    [line1 addSubview:progressTextLab];
    [progressTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line1);
        make.left.equalTo(line1).offset(15);
    }];
    progressTextLab.textColor = baseColor;
    progressTextLab.font = FONT(16);
    progressTextLab.text = @"项目进展情况";
    
    NSArray *projectArray = @[
  @{@"imgName":@"total_project",@"text":@"工程总数"},
  @{@"imgName":@"earlier_project",@"text":@"前期"},
  @{@"imgName":@"construction_project",@"text":@"施工"},
  @{@"imgName":@"finish_project",@"text":@"完工"}];
    
    for (int i = 0; i<projectArray.count; i++) {
        NSDictionary *dict = projectArray[i];
        UIButton *projectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [footView addSubview:projectBtn];
        CGFloat btnW = (WIDTH - 30 - 5*3)/4.0;
        CGFloat btnX = 15 + i*(btnW+5);
        projectBtn.frame = CGRectMake(btnX, CGRectGetMaxY(line1.frame)+10, btnW, buttonHeight);
        projectBtn.tag = i;
        [projectBtn addTarget:self action:@selector(projectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *projectImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[dict objectForKey:@"imgName"]]];
        [projectBtn addSubview:projectImg];
        [projectImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(projectBtn);
            make.top.equalTo(projectBtn).offset(5);
            make.width.height.mas_equalTo(40);
        }];
        UILabel *countText = [[UILabel alloc]init];
        [projectBtn addSubview:countText];
        [countText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(projectImg);
            make.top.equalTo(projectImg.mas_bottom).offset(5);
        }];
        countText.font = FONT(14);
        countText.text = [dict objectForKey:@"text"];
        
        UILabel *countLab = [[UILabel alloc]init];
        [projectBtn addSubview:countLab];
        [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(projectImg);
            make.top.equalTo(countText.mas_bottom).offset(5);
        }];
        countLab.font = [UIFont boldSystemFontOfSize:15];
        
        switch (i) {
            case 0:
                self.qb = countLab;
                break;
            case 1:
                self.qq = countLab;
                break;
            case 2:
                self.sg = countLab;
                break;
            case 3:
                self.wg = countLab;
                break;
                
            default:
                break;
        }
        
    }
    UIView *line2 = [[UIView alloc]init];
    [footView addSubview:line2];
    line2.frame = CGRectMake(0, CGRectGetMaxY(line1.frame)+buttonHeight, CGRectGetWidth(footView.frame), 40);
    line2.backgroundColor = RGBC(240);
    
    UILabel *investTextLab = [[UILabel alloc]init];
    [line2 addSubview:investTextLab];
    [investTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line2);
        make.left.equalTo(line2).offset(15);
    }];
    investTextLab.textColor = baseColor;
    investTextLab.font = FONT(16);
    investTextLab.text = @"项目投资情况";
    
    HomeChartView *chartView = [[HomeChartView alloc]init];
    [footView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.right.bottom.equalTo(footView);
    }];
    
    return footView;
}

-(void)loadData{
    [RequestData AppPOST:@"projectAnalysis" parameters:nil response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            ProjectAnalysisModel *model = [ProjectAnalysisModel mj_objectWithKeyValues:responseObject];
            self.qb.text = model.qb;
            self.qq.text = model.qq;
            self.sg.text = model.sg;
            self.wg.text = model.sg;
            [self loadProjectInvestment];
        }
    }];
}

-(void)loadProjectInvestment{
    [RequestData AppPOST:@"projectInvestment" parameters:nil response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
        }
    }];
}

-(void)projectBtnClick:(UIButton *)projectBtn{
    NSLog(@"第%ld个按钮被点击",projectBtn.tag);
    switch (projectBtn.tag) {
        case 0:
            
            break;
            
        default:
            break;
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"homeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLab.text = self.dataArray[indexPath.row];
    cell.dateLab.text = [Helper getFormatDate:[NSDate date]];
    return cell;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:
                      @"金华市召开全市生态廊道办主任会议",
                      @"张荣贵义务调研生态廊道建设工作",
                      @"生态廊道天时地利人和", nil];
    }
    return _dataArray;
}

@end
