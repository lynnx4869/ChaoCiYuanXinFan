//
//  TimeViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "TimeViewController.h"
#import "HttpManager.h"
#import "Const.h"
#import "MyUtil.h"
#import "TimeModel.h"
#import "TimeCell.h"

@interface TimeViewController () <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *heightArray;

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:252/255.0 blue:244/255.0 alpha:1.0];
    [self addNav:nil bgImage:@"sjb" type:ShortLength rightBtn:nil withLength:0];
    
    _dataArray = [NSMutableArray array];
    _heightArray = [NSMutableArray array];
    
    [self createTableView];
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight-70) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TimeCell class] forCellReuseIdentifier:@"TimeCellId"];
    [self.view addSubview:_tableView];
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:lTimelineUrl];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Time:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = @[@"mon", @"tue", @"wed", @"thu", @"fri", @"sat", @"sun"];
    for(NSString *str in array){
        NSArray *lists = rootDic[str];
        NSMutableArray *listArray = [NSMutableArray array];
        for(NSDictionary *dic in lists){
            TimeModel *model = [[TimeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [listArray addObject:model];
        }
        [_dataArray addObject:listArray];
    }
    [_tableView reloadData];
    
    NSInteger week = [MyUtil getWeekDay];
    CGFloat height = 0.0;
    for(NSInteger i = 0; i < week; i++){
        NSNumber *num = _heightArray[i];
        height += num.floatValue;
    }
    [_tableView setContentOffset:CGPointMake(0, height) animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = _dataArray[indexPath.row];
    NSInteger n = array.count / 4;
    if(array.count % 4 != 0){
        n++;
    }
    CGFloat height = 100.0 * n + 10.0;
    [_heightArray addObject:[NSNumber numberWithFloat:height]];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCellId" forIndexPath:indexPath];
    cell.array = _dataArray[indexPath.row];
    cell.week = indexPath.row;
    return cell;
}

@end
