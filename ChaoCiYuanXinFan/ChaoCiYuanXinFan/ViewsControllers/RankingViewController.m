//
//  RankingViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RankingViewController.h"
#import "ExpressModel.h"
#import "RankingModel.h"
#import "RankingCell.h"

@interface RankingViewController ()
    <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [self createTableView];
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-68-(29*(ScreenWidth/5)/108+10)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[RankingCell class] forCellReuseIdentifier:@"RankingCellId"];
    [self.view addSubview:_tableView];
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:lRankingUrl];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Ranking:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    for(NSDictionary *rankDic in rootDic[@"data"]){
        RankingModel *rankModel = [[RankingModel alloc] init];
        [rankModel setValuesForKeysWithDictionary:rankDic];
        
        for(NSDictionary *expressDic in rankDic[@"posts"]){
            ExpressModel *expressModel = [[ExpressModel alloc] init];
            [expressModel setValuesForKeysWithDictionary:expressDic];
            [rankModel.postsArray addObject:expressModel];
        }
        
        [_dataArray addObject:rankModel];
    }
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 60 + 44*ScreenWidth/641 + 243*(ScreenWidth-20)/642 + 243*(ScreenWidth-20)/625 + ((ScreenWidth-30)/2/4*3.5+30)*2;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArray[indexPath.row];
    cell.delegate = self.delegate;
    return cell;
}

@end
