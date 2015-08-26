//
//  CategoryViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "CategoryViewController.h"
#import "MJRefresh.h"
#import "CategoryModel.h"
#import "CategoryCell.h"
#import "ListCategoryViewController.h"

@interface CategoryViewController ()
    <UICollectionViewDelegate, UICollectionViewDataSource, MJRefreshBaseViewDelegate, HttpManagerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    _isLoading = NO;
    
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
    layout.itemSize = CGSizeMake((ScreenWidth-40)/3, (ScreenWidth-40)/3+20);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-68-(29*(ScreenWidth/5)/108+10)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"CategoryCellId"];
    [self.view addSubview:_collectionView];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate = self;
    _headerView.scrollView = _collectionView;
    
    [_headerView beginRefreshing];
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    _isLoading = YES;
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:lCategoryUrl];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Category:%@", error);
    _isLoading = NO;
    [_headerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    [_dataArray removeAllObjects];
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    for(NSDictionary *dic in rootDic[@"data"]){
        CategoryModel *model = [[CategoryModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    
    [_collectionView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
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

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCellId" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = _dataArray[indexPath.item];    
    
    ListCategoryViewController *lcvc = [[ListCategoryViewController alloc] init];
    lcvc.catId = model.catId;
    lcvc.typeTitle = model.name;
    if(self.delegate){
        [self.delegate.navigationController pushViewController:lcvc animated:YES];
    }
}

@end
