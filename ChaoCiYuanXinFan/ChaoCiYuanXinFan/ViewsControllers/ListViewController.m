//
//  ListCategoryViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ListViewController.h"
#import "Const.h"
#import "MJRefresh.h"
#import "HttpManager.h"
#import "MyUtil.h"
#import "ExpressModel.h"
#import "CategoryDetailCell.h"

@interface ListViewController ()
    <UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate, HttpManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if(_type == CategoryList){
        [self addNav:_navTitle bgImage:nil type:LongLength rightBtn:nil withLength:0];
    }else if(_type == SearchList){
        [self addNav:[NSString stringWithFormat:@"\"%@\"搜索结果", _navTitle] bgImage:nil type:LongLength rightBtn:nil withLength:0];
    }
    
    _dataArray = [NSMutableArray array];
    _isLoading = NO;
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[CategoryDetailCell class] forCellReuseIdentifier:@"CategoryDetailCellId"];
    [self.view addSubview:_tableView];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate = self;
    _headerView.scrollView = _tableView;
    
    [_headerView beginRefreshing];
}

- (void)downloadData{
    _isLoading = YES;
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    if(_type == CategoryList){
        [manager requestGet:[NSString stringWithFormat:lListByCategoryUrl, _catId]];
    }else if(_type == SearchList){
        NSString *urlString = [NSString stringWithFormat:lSearchUrl, _navTitle];
        [manager requestGet:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"CategoryDetail:%@", error);
    _isLoading = NO;
    [_headerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    [_dataArray removeAllObjects];
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    if(![rootDic[@"posts"] isEqual:@""]){
        for(NSDictionary *dic in rootDic[@"posts"]){
            ExpressModel *model = [[ExpressModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    label.text = @"没有更多啦。";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = 1;
    _tableView.tableFooterView = label;
    
    [_tableView reloadData];
    
    _isLoading = NO;
    [_headerView endRefreshing];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryDetailCellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if(_isLoading){
        return ;
    }
    
    if(refreshView == _headerView){
        [self downloadData];
    }
}

- (void)dealloc{
    [_headerView free];
}



@end
