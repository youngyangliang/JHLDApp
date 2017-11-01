//
//  StartSupervisorViewController.m
//  JHLDManager
//
//  Created by 杨亮 on 2017/10/30.
//  Copyright © 2017年 booway.com. All rights reserved.
//

#import "StartSupervisorViewController.h"
#import "ProjectListModel.h"

@interface StartSupervisorViewController ()<TZImagePickerControllerDelegate,UITextFieldDelegate,YBPopupMenuDelegate>
@property (nonatomic, weak) UITextField *typeField;
@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *titleField;
@property (nonatomic, weak) UITextField *chargeField;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) YBPopupMenu *typeMenu;
@property (nonatomic, strong) YBPopupMenu *nameMenu;
@property (nonatomic, strong) ProjectListModel *model;
@property (nonatomic, strong) UITextView *contextText;
@end

@implementation StartSupervisorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起督导";
    [self setUpUI];
    [self loadData];
}

-(void)setUpUI{
    BaseScrollView *scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavgBar_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = backgroudColor;
    
    UIView *typeView = [[UIView alloc]init];
    [scrollView addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(15);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    typeView.backgroundColor = [UIColor whiteColor];
    
    UILabel *typeTextLabel = [[UILabel alloc]init];
    [typeView addSubview:typeTextLabel];
    [typeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeView);
        make.left.equalTo(typeView).offset(20);
        make.width.mas_equalTo(100);
    }];
    typeTextLabel.text = @"项目类型:";
    
    UITextField *typeField = [[UITextField alloc]init];
    [typeView addSubview:typeField];
    [typeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeTextLabel);
        make.left.equalTo(typeTextLabel.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(typeView).offset(-40);
    }];
    typeField.placeholder = @"请选择项目类型";
    typeField.delegate = self;
    self.typeField = typeField;
    
    UIView *nameView = [[UIView alloc]init];
    [scrollView addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeView.mas_bottom).offset(1);
        make.left.right.height.equalTo(typeView);
    }];
    nameView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameTextLabel = [[UILabel alloc]init];
    [nameView addSubview:nameTextLabel];
    [nameTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView);
        make.left.width.equalTo(typeTextLabel);
    }];
    nameTextLabel.text = @"项目名称:";
    
    UITextField *nameField = [[UITextField alloc]init];
    [nameView addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameTextLabel);
        make.left.right.height.equalTo(typeField);
    }];
    nameField.placeholder = @"请选择项目名称";
    nameField.delegate = self;
    self.nameField = nameField;
    
    UIView *chargeView = [[UIView alloc]init];
    [scrollView addSubview:chargeView];
    [chargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).offset(1);
        make.left.right.height.equalTo(typeView);
    }];
    chargeView.backgroundColor = [UIColor whiteColor];
    
    UILabel *chargeTextLabel = [[UILabel alloc]init];
    [chargeView addSubview:chargeTextLabel];
    [chargeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chargeView);
        make.left.width.equalTo(typeTextLabel);
    }];
    chargeTextLabel.text = @"项目负责人:";
    
    UITextField *chargeField = [[UITextField alloc]init];
    [chargeView addSubview:chargeField];
    [chargeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chargeTextLabel);
        make.left.right.height.equalTo(typeField);
    }];
    chargeField.placeholder = @"请填写项目负责人";
    self.chargeField = chargeField;
    
    UIView *titleView = [[UIView alloc]init];
    [scrollView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chargeView.mas_bottom).offset(1);
        make.left.right.height.equalTo(typeView);
    }];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleTextLabel = [[UILabel alloc]init];
    [titleView addSubview:titleTextLabel];
    [titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView);
        make.left.width.equalTo(typeTextLabel);
    }];
    titleTextLabel.text = @"督导标题:";
    
    UITextField *titleField = [[UITextField alloc]init];
    [titleView addSubview:titleField];
    [titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleTextLabel);
        make.left.right.height.equalTo(typeField);
    }];
    titleField.placeholder = @"请填写督导标题";
    self.titleField = titleField;
    
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [scrollView addSubview:addBtn];
//    [addBtn setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
//    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(15);
//        make.top.equalTo(titleView.mas_bottom).offset(15);
//        make.width.height.mas_equalTo(50);
//    }];
//    [addBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *contentView = [[UIView alloc]init];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(1);
        make.left.right.equalTo(typeView);
        make.height.mas_equalTo(200);
    }];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    [contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(10);
        make.left.width.equalTo(typeTextLabel);
    }];
    contentLabel.text = @"填写督导单:";
    
    UITextView *contextText = [[UITextView alloc]init];
    [contentView addSubview:contextText];
    [contextText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(10);
        make.left.equalTo(contentLabel);
        make.right.equalTo(contentView).offset(-15);
        make.bottom.equalTo(contentView).offset(-15);
    }];
    self.contextText = contextText;
    [Helper addBordToView:contextText andColor:backgroudColor andRadius:5 BorderWith:1];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(40);
    }];
    [startBtn setTitle:@"发起督导" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn setBackgroundColor:baseColor forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(startBtn.frame));
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.typeField) {
//        NSArray *title = [NSArray arrayWithObjects:@"示范项目",@"普通项目",@"终点项目", nil];
        NSMutableArray *type = [NSMutableArray array];
        for (NSDictionary *dict in self.typeArray) {
            [type addObject:[dict objectForKey:@"type"]];
        }
        self.typeMenu = [YBPopupMenu showRelyOnView:self.typeField titles:type icons:nil menuWidth:WIDTH/2 delegate:self];
        return NO;
    }
    if (textField == self.nameField) {
        NSMutableArray *name = [NSMutableArray array];
        for (ProjectListModel *model in self.nameArray) {
            [name addObject:model.projectname];
        }
        self.nameMenu = [YBPopupMenu showRelyOnView:self.nameField titles:name icons:nil menuWidth:WIDTH/2 delegate:self];
        return NO;
    }
    return YES;
}

-(void)loadData{
    [RequestData AppPOST:@"projectList" parameters:nil response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            NSLog(@"%@",responseObject);
            for (NSDictionary *dict in responseObject) {
                ProjectListModel *model = [ProjectListModel mj_objectWithKeyValues:dict];
                [self.nameArray addObject:model];
            }
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    if (ybPopupMenu == self.typeMenu) {
        NSDictionary *dict = self.typeArray[index];
        self.typeField.text = [dict objectForKey:@"type"];
    }
    if (ybPopupMenu == self.nameMenu) {
        ProjectListModel *model = self.nameArray[index];
        self.nameField.text = model.projectname;
        self.chargeField.text = model.projectusername;
        self.model = model;
    }
}

-(void)startBtnClick{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.projectid forKey:@"projectid"];
    [param setValue:self.titleField.text forKey:@"title"];
    [param setValue:self.contextText.text forKey:@"projectcontent"];
    [param setValue:@"" forKey:@"soruceid"];
    [param setValue:self.model.projectuserid forKey:@"userId"];
    
    [RequestData AppPOST:@"saveProjectMoni" parameters:param response:^(id responseObject, BOOL responseOK, NSString *msg) {
        if (responseOK) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"saveProjectMoni" object:nil];
        }else{
            [ProgressHUD showError:msg];
        }
    }];
}

-(void)btnClick{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.isStatusBarDefault = YES;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    NSLog(@"count==%ld",photos.count);
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}

-(NSMutableArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

-(NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray arrayWithObjects:
                      @{@"typeCode":@"1",@"type":@"普通项目"},
                      @{@"typeCode":@"2",@"type":@"示范项目"},
                      @{@"typeCode":@"3",@"type":@"重点项目"},nil];
    }
    return _typeArray;
}

@end
