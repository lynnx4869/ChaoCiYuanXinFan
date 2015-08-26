//
//  SubjectViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SubjectViewController.h"
#import "MJRefresh.h"
#import "SubjectModel.h"
#import "SubjectCell.h"
#import "Masonry.h"
#import "SubjectDetailViewController.h"

@interface SubjectViewController ()
    <UICollectionViewDelegate, UICollectionViewDataSource, HttpManagerDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, strong) MJRefreshFooterView *footerView;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isRefreshing;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    _isLoading = NO;
    _isRefreshing = YES;
    
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize = CGSizeMake((ScreenWidth-20)/2, 100);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[SubjectCell class] forCellWithReuseIdentifier:@"SubjectCellId"];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate = self;
    _headerView.scrollView = _collectionView;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.delegate = self;
    _footerView.scrollView = _collectionView;
    
    [_headerView beginRefreshing];
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    _isLoading = YES;
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    
    if(_isRefreshing){
        NSString *url = [NSString stringWithFormat:lSubjectUrl, @"ACG精品文章", @"0", @"0"];
        [manager requestGet:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }else{
        SubjectModel *model = [_dataArray lastObject];
        NSString *url = [NSString stringWithFormat:lSubjectUrl, @"ACG精品文章", model.subjectId, model.posttime];
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
        SubjectModel *model = [[SubjectModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    
    [_collectionView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectCellId" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectDetailViewController *sdvc = [[SubjectDetailViewController alloc] init];
    SubjectModel *model = _dataArray[indexPath.item];
    sdvc.urlString = model.url;
    sdvc.type = 2;
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
