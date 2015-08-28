//
//  AboutViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "AboutViewController.h"
#import "MyUtil.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    //bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    UIButton *leftBtn = [MyUtil createBtn:CGRectMake(20, 12, 20, 20)
                                    image:@"sp_back"
                                highImage:@"sp_back_hover"
                                 selected:nil
                                   target:self
                                   action:@selector(back:)];
    [bgView addSubview:leftBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, ScreenWidth-160, 43)];
    titleLabel.text = @"关于超次元新番APP";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = 1;
    [bgView addSubview:titleLabel];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
    lineView.image = [UIImage imageNamed:@"sc_line3"];
    [bgView addSubview:lineView];
}

- (void)createView{
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 94, ScreenWidth*3/5, ScreenWidth*3/5*1263/809)];
    leftImageView.image = [UIImage imageNamed:@"gy_left"];
    [self.view addSubview:leftImageView];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*3/5, 84, ScreenWidth*2/5-10, (ScreenWidth*2/5-10)*1016/680)];
    rightImageView.image = [UIImage imageNamed:@"gy_right"];
    [self.view addSubview:rightImageView];
    
    UIImageView *wzImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, rightImageView.frame.size.width-40, (rightImageView.frame.size.width-40)*171/395)];
    wzImageView.image = [UIImage imageNamed:@"gy_wz"];
    [rightImageView addSubview:wzImageView];
    
    UILabel *recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, wzImageView.frame.size.height+15, rightImageView.frame.size.width-10, rightImageView.frame.size.height-wzImageView.frame.size.height-30)];
    recommendLabel.text = @"超次元，关注你的二次元动漫游戏生活，提供动漫新闻，心烦资讯，专业介绍日本热门手机游戏，新游速递，深度测评，周边萌物，宅腐福利，给你最精彩的二次元世界。";
    recommendLabel.numberOfLines = 0;
    recommendLabel.font = [UIFont systemFontOfSize:10];
    recommendLabel.contentMode = UIViewContentModeTop;
    [rightImageView addSubview:recommendLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*3/5+10, ScreenWidth*3/5*1263/809+74, 100, 20)];
    titleLabel.text = @"联系我们";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titleLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, ScreenWidth*3/5*1263/809+94, ScreenWidth/2, ScreenHeight-(ScreenWidth*3/5*1263/809+94+ScreenWidth*468/1536))];
    descLabel.text = @"Email：web@18touch.com\nQQ：340741648\n电话：0755-26581864\n地址：深圳市南山区科技园中区科苑路15号科兴科学园A栋2单元11楼1102室";
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:descLabel];
    
    UIImageView *footImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight-ScreenWidth*468/1536, ScreenWidth, ScreenWidth*468/1536)];
    footImageView.image = [UIImage imageNamed:@"gy_foot"];
    [self.view addSubview:footImageView];
}

#pragma mark - ClickAction
- (void)back:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
