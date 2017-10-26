//
//  JZAddPersonController.m
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#import "JZAddPersonController.h"
#import "JZAddPersonCell.h"
#import "JZListPersonModel.h"
#import "JZCoreData.h"
#import "JZPersonEntity.h"
@interface JZAddPersonController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView * jz_tableView;
@end

@implementation JZAddPersonController{
    JZAddPersonCell * cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加联系人";
    [self setupNav];
    [self setupView];
}
#pragma mark - 设置导航
-(void)setupNav{
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}
#pragma mark - 保存的点击事件
-(void)btnClick{
//    NSLog(@"点击保存按钮");
    if ([self.jz_type isEqualToString:@"2"]) {// 编辑
        [self editData];
    }else{ // 添加
        [self addData];
    }
}

#pragma mark - 编辑
-(void)editData{
    if (cell.jz_nameText.text.length>0 && cell.jz_phoneText.text.length>0) {
        __block JZListPersonModel * myModel = [[JZListPersonModel alloc]init];
        myModel.name = cell.jz_nameText.text;
        myModel.phone = cell.jz_phoneText.text;
        WS(weakSelf);
        [JZCoreData jz_updataDataWith_CoredatamoldeClass:[JZPersonEntity class] where:[NSString stringWithFormat:@"name = '%@'",self.jz_nameStr] result:^(JZPersonEntity *entity) {
            entity.name = myModel.name;
            entity.phone = myModel.phone;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } Error:^(NSError *error) {
            if (error.userInfo) {
                NSLog(@"出错了 %@",error.userInfo);
            }
            
        }];
    }else{
        NSLog(@"请完善信息在保存");
    }
    
}
#pragma mark - 添加
-(void)addData{
    if (cell.jz_nameText.text.length>0 && cell.jz_phoneText.text.length>0) {
        __block JZListPersonModel * myModel = [[JZListPersonModel alloc]init];
        WS(weakSelf);
        myModel.name = cell.jz_nameText.text;
        myModel.phone = cell.jz_phoneText.text;
        
        [JZCoreData jz_inserDataWith_CoredatamodelClass:[JZPersonEntity class] CoredataModel:^(JZPersonEntity *model) {
            model.name = myModel.name;
            model.phone = myModel.phone;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } Error:^(NSError *error) {
            if (error.userInfo) {
                NSLog(@"出错了 %@",error.userInfo);
            }
        }];
    }else{
        NSLog(@"请完善信息在保存");
    }
}
#pragma mark - 设置UI
-(void)setupView{
    UITableView * jz_tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    jz_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    jz_tableView.delegate = self;
    jz_tableView.dataSource = self;
    [self.view addSubview:jz_tableView];
    self.jz_tableView = jz_tableView;
}
#pragma mark - tableview的数据源代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [JZAddPersonCell cellWithTableView:tableView];
    if ([self.jz_type isEqualToString:@"2"]) {
        cell.jz_nameText.text = _jz_nameStr;
        cell.jz_phoneText.text = _jz_phoneStr;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
