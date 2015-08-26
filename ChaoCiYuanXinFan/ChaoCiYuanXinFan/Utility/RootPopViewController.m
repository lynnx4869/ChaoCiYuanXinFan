//
//  RootPopViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RootPopViewController.h"
#import "Masonry.h"
#import "MyUtil.h"

@interface RootPopViewController ()

@end

@implementation RootPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNav:(NSString *)title bgImage:(NSString *)imageName rightBtn:(UIButton *)btn withLength:(CGFloat)length{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    UIButton *leftBtn = [MyUtil createBtn:CGRectMake(20, 12, 20, 20)
                                    image:@"sp_back"
                                highImage:@"sp_back_hover"
                                 selected:nil
                                   target:self
                                   action:@selector(back:)];
    [bgImageView addSubview:leftBtn];
    
    if(title){
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.text = title;
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textAlignment = 1;
        [bgImageView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgImageView.mas_top).with.offset(0);
            make.bottom.equalTo(bgImageView.mas_bottom).with.offset(0);
            make.left.equalTo(bgImageView.mas_left).with.offset(100);
            make.right.equalTo(bgImageView.mas_right).with.offset(-100);
        }];
    }
    
    if(imageName){
        bgImageView.image = [UIImage imageNamed:imageName];
    }else{
        bgImageView.image = [UIImage imageNamed:@"bg_nav"];
    }
    
    if(btn){
        btn.frame = CGRectMake(ScreenWidth-length-20, 12, length, 20);
        [bgImageView addSubview:btn];
    }
}

- (void)back:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
