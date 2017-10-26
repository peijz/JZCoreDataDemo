//
//  ViewController.m
//  JZCoreDataDemo
//
//  Created by wanhongios on 2017/10/23.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "ViewController.h"
#import "JZCoreDataHomeCell.h"
#import "JZAddPersonController.h"
#import "JZListPersonModel.h"
#import "JZCoreData.h"
#import "JZPersonEntity.h"
#import "MJRefresh.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView * jz_tableView;
@property(nonatomic,strong) NSMutableArray * jz_datas;
@end

@implementation ViewController
-(NSMutableArray *)jz_datas{
    if (_jz_datas == nil) {
        _jz_datas = [[NSMutableArray alloc]init];
    }
    return _jz_datas;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self setupNav];
    [self setupView];
}
#pragma mark - 下拉刷新
-(void)downLoad{
    WS(weakSelf);
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.jz_datas removeAllObjects];
        [weakSelf getData];
    }];
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    self.jz_tableView.mj_header = header;
}

#pragma mark - 获取数据库中数据
-(void)getData{
    WS(weakSelf);
    [JZCoreData jz_selectDataWith_CoredatamoldeClass:[JZPersonEntity class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
        for (JZPersonEntity *entity in coredataModelArr) {
            [weakSelf.jz_datas addObject:entity];
        }
        if (weakSelf.jz_datas.count>0) {
            [weakSelf.jz_tableView.mj_footer endRefreshing];
            [weakSelf.jz_tableView.mj_header endRefreshing];
            [weakSelf.jz_tableView reloadData];
        }
    } Error:^(NSError *error) {
        if (error.userInfo) {
            NSLog(@"出错了 %@",error.userInfo);
        }
    }];
}

#pragma mark - 设置导航
-(void)setupNav{
    UIButton * rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    [rightBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}
#pragma mark - 添加的点击时间
-(void)btnClick{
    JZAddPersonController * addPerson = [[JZAddPersonController alloc]init];
    addPerson.jz_phoneStr = @"";
    addPerson.jz_nameStr = @"";
    addPerson.jz_type = @"1";
    [self.navigationController pushViewController:addPerson animated:YES];
//    NSLog(@"您点击了添加按钮");
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

#pragma mark -tableview 的数据源代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.jz_datas.count>0) {
        return self.jz_datas.count;
    }else{
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JZPersonEntity * entity = self.jz_datas[indexPath.row];
    JZAddPersonController * addPerson = [[JZAddPersonController alloc]init];
    addPerson.jz_nameStr = entity.name;
    addPerson.jz_phoneStr = entity.phone;
    addPerson.jz_type = @"2";
    [self.navigationController pushViewController:addPerson animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZCoreDataHomeCell * cell = [JZCoreDataHomeCell cellWithTableView:tableView];
    if (self.jz_datas.count>0) {
        cell.jz_entity = self.jz_datas[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.5;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    JZPersonEntity *entity = self.jz_datas[indexPath.row];
    [self deleteDataWithName:entity.name];
 
}

#pragma mark - 删除
-(void)deleteDataWithName:(NSString *)name{
    WS(weakSelf);
    [JZCoreData jz_deleteDataWith_CoredatamoldeClass:[JZPersonEntity class] where:[NSString stringWithFormat:@"name = '%@'",name] result:^(BOOL isResult) {
        [weakSelf downLoad];
//        [weakSelf.jz_tableView reloadData];
    } Error:^(NSError *error) {
        if (error.userInfo) {
            NSLog(@"删除出错了 %@",error.userInfo);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
