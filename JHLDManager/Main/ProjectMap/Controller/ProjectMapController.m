//
//  ProjectMapController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/20.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "ProjectMapController.h"
#import "ProjectListModel.h"

@interface ProjectMapController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *projectArray;

@end

@implementation ProjectMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
-(void)setUpUI{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"项目博览",@"示范段博览",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, WIDTH/2, 35);
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = baseColor;
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self setUpBaiduMap];
    [self loadData];
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

-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    NSLog(@"zoomLevel==%f",self.mapView.zoomLevel); NSLog(@"latitude==%f,longitude==%f",self.mapView.centerCoordinate.latitude,self.mapView.centerCoordinate.longitude);
}
-(void)setUpBaiduMap{
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavgBar_HEIGHT-TabBar_HEIGHT)];
    [self.view addSubview:mapView];
    self.mapView = mapView;
    self.mapView.delegate = self;
    self.mapView.showMapScaleBar = YES;
    [_mapView setMapType:BMKMapTypeSatellite];
    self.mapView.zoomLevel = 13;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(29.1099901, 119.659882);
    //设定地图View能否支持旋转
    self.mapView.rotateEnabled = NO;
}

-(void)loadData{
    [RequestData AppPOST:@"exampleObjectList" parameters:nil response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
//            for (NSDictionary *dict in responseObject) {
//                ProjectListModel *model = [ProjectListModel mj_objectWithKeyValues:dict];
//                [self.projectArray addObject:model];
//
//                BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
//                float lat = [model.projectLat floatValue];
//                float lon = [model.projectLong floatValue];
//                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
////                annotation.cityModel = cityModel;
//                [self.mapView addAnnotation:annotation];
//            }
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

-(NSMutableArray *)projectArray{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}
@end
