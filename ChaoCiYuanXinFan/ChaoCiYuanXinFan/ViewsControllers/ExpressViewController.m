//
//  ExpressViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ExpressViewController.h"
#import "Const.h"
#import "MJRefresh.h"
#import "HttpManager.h"
#import "ExpressModel.h"
#import "ExpressCell.h"

@interface ExpressViewController ()
    <UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate, HttpManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation ExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    _isLoading = NO;
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ExpressCell class] forCellReuseIdentifier:@"ExpressCellId"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate = self;
    _headerView.scrollView = _tableView;
    
    [_headerView beginRefreshing];
}

- (void)downloadData{
    [_dataArray removeAllObjects];
    _isLoading = YES;
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:lExpressUrl];
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Express:%@", error);
    _isLoading = NO;
    [_headerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    for(NSDictionary *dic in rootDic[@"posts"]){
        ExpressModel *model = [[ExpressModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    
    [_tableView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (ScreenWidth-16)*340/640;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpressCellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if(refreshView == _headerView){
        [self downloadData];
    }
}

@end
