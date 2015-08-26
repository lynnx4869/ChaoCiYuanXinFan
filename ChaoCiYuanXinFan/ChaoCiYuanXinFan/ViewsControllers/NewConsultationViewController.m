//
//  NewConsultationViewController.m
//  ;
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "NewConsultationViewController.h"
#import "MJRefresh.h"
#import "ConsultationModel.h"
#import "ConsultationBigCell.h"
#import "ConsultationSmallCell.h"
#import "Masonry.h"
#import "SubjectDetailViewController.h"

@interface NewConsultationViewController ()
    <UITableViewDelegate, UITableViewDataSource, HttpManagerDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, strong) MJRefreshFooterView *footerView;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isRefreshing;

@end

@implementation NewConsultationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    _isLoading = NO;
    _isRefreshing = YES;
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate = self;
    _headerView.scrollView = _tableView;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.delegate = self;
    _footerView.scrollView = _tableView;
    
    [_headerView beginRefreshing];
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    _isLoading = YES;
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    
    if(_isRefreshing){
        NSString *url = [NSString stringWithFormat:lConsultationUrl, @"动漫资讯", @"0", @"0"];
        [manager requestGet:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }else{
        ConsultationModel *model = [_dataArray lastObject];
        NSString *url = [NSString stringWithFormat:lConsultationUrl, @"动漫资讯", model.consultationId, model.posttime];
        [manager requestGet:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Consultation:%@", error);
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    if(_isRefreshing){
        [_dataArray removeAllObjects];
    }
    
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    for(NSDictionary *dic in rootDic[@"posts"]){
        ConsultationModel *model = [[ConsultationModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    
    [_tableView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 4 == 0){
        return 120;
    }else{
        return 70;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 4 == 0){
        ConsultationBigCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultationBigCellId"];
        if(cell == nil){
            cell = [[ConsultationBigCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:@"ConsultationBigCellId"];
        }
        cell.model = _dataArray[indexPath.row];
        return cell;
    }else{
        ConsultationSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultationSmallCellId"];
        if(cell == nil){
            cell = [[ConsultationSmallCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:@"ConsultationSmallCellId"];
        }
        cell.model = _dataArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectDetailViewController *sdvc = [[SubjectDetailViewController alloc] init];
    ConsultationModel *model = _dataArray[indexPath.row];
    sdvc.urlString = model.url;
    sdvc.type = 1;
    if(self.delegate){
        [self.delegate.navigationController pushViewController:sdvc animated:YES];
    }
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if(_isLoading){
        return ;
    }
    
    if(refreshView == _headerView){
        _isRefreshing = YES;
        [self downloadData];
    }else if(refreshView == _footerView){
        _isRefreshing = NO;
        [self downloadData];
    }
}

@end
