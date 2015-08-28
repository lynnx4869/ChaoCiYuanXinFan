//
//  SearchViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SearchViewController.h"
#import "ListViewController.h"
#import "HttpManager.h"
#import "Const.h"
#import "AutoLabelModel.h"
#import "MyUtil.h"

@interface SearchViewController () <HttpManagerDelegate>

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:252/255.0 blue:244/255.0 alpha:1.0];
    [self addNav:nil bgImage:@"ss1" type:ShortLength rightBtn:nil withLength:0];
    
    _dataArray = [NSMutableArray array];
    
    [self createView];
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView{
    UIImageView *searchBgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 74, ScreenWidth-70, 30)];
    searchBgView.image = [UIImage imageNamed:@"bg_textBg_input"];
    searchBgView.userInteractionEnabled = YES;
    [self.view addSubview:searchBgView];
    
    UIImageView *searchnewView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 18, 20)];
    searchnewView.image = [UIImage imageNamed:@"searchnew"];
    [searchBgView addSubview:searchnewView];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(28, 0, ScreenWidth-98, 30)];
    [searchBgView addSubview:_searchTextField];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(ScreenWidth-60, 74, 50, 30);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchBtn setBackgroundColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]];
    [searchBtn addTarget:self action:@selector(searchResults) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 5;
    [self.view addSubview:searchBtn];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.tag = 100;
    bottomBtn.frame = CGRectMake(0, ScreenHeight-40, ScreenWidth, 40);
    [bottomBtn setTitle:@"换一换" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:252/255.0 green:139/255.0 blue:63/255.0 alpha:1.0]];
    [bottomBtn addTarget:self action:@selector(downloadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

#pragma mark - ClickAction
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)searchResults{
    ListViewController *lvc = [[ListViewController alloc] init];
    lvc.navTitle = _searchTextField.text;
    lvc.type = SearchList;
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)tapLabels:(UITapGestureRecognizer *)gr{
    UILabel *label = (UILabel *)gr.view;
    ListViewController *lvc = [[ListViewController alloc] init];
    lvc.navTitle = label.text;
    lvc.type = SearchList;
    [self.navigationController pushViewController:lvc animated:YES];
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    btn.enabled = NO;
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:lHotKeyUrl];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"search:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    [_dataArray removeAllObjects];
    
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    for(NSDictionary *dic in rootDic[@"data"]){
        AutoLabelModel *model = [[AutoLabelModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [self displayLabels];
}

- (void)displayLabels{
    for(NSInteger i = 0; i < _dataArray.count; i++){
        UILabel *label = (UILabel *)[self.view viewWithTag:300+i];
        if(label){
            [label removeFromSuperview];;
        }
    }
    
    for(NSInteger i = 0; i < _dataArray.count; i++){
        AutoLabelModel *model = _dataArray[i];
        CGFloat width = [model.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}
                                                 context:nil].size.width;
        NSInteger originX = arc4random() % (NSInteger)(ScreenWidth-width);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, 110+i*30, width, 30)];
        label.userInteractionEnabled = YES;
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:12];
        label.tag = 300 + i;
        label.textColor = [MyUtil getColorFromString:model.color];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabels:)];
        [label addGestureRecognizer:tap];
        
        [self.view addSubview:label];
    }
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    btn.enabled = YES;
}



@end
