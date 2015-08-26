//
//  GroupViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "GroupViewController.h"
#import "MJRefresh.h"
#import "GroupModel.h"
#import "GroupCell.h"
#import "GroupHeaderView.h"

@interface GroupViewController ()
    <HttpManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation GroupViewController

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
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize = CGSizeMake((ScreenWidth-20)/2, 80);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-68-(29*(ScreenWidth/5)/108+10)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[GroupCell class] forCellWithReuseIdentifier:@"GroupCellId"];
    [_collectionView registerClass:[GroupHeaderView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"GroupHeaderViewId"];
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
    [manager requestGet:lGroupUrl];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Group:%@", error);
    _isLoading = NO;
    [_headerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    [_dataArray removeAllObjects];
    
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    for(NSDictionary *dic in rootDic[@"forums"]){
        GroupModel *model = [[GroupModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    
    [_collectionView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader){
        GroupHeaderView *groupHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                     withReuseIdentifier:@"GroupHeaderViewId"
                                                                            forIndexPath:indexPath];
        return groupHeaderView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, ScreenWidth * 58 / 640);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count + 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCellId" forIndexPath:indexPath];
    if(indexPath.item < _dataArray.count){
        cell.model = _dataArray[indexPath.item];
    }else{
        [cell setBlankCell];
    }
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
