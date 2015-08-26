//
//  ConsultationViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ConsultationViewController.h"
#import "MyUtil.h"
#import "NewConsultationViewController.h"
#import "SubjectViewController.h"

@interface ConsultationViewController ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) NewConsultationViewController *ncvc;
@property (nonatomic, strong) SubjectViewController *svc;

@end

@implementation ConsultationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSelectBtn];
    
    CGFloat height = (ScreenWidth-100)/2*56/249+5;
    
    _ncvc = [[NewConsultationViewController alloc] init];
    _ncvc.view.frame = CGRectMake(0, height, ScreenWidth, ScreenHeight-height);
    _ncvc.delegate = self.delegate;
    [self.view addSubview:_ncvc.view];
    
    _svc = [[SubjectViewController alloc] init];
    _svc.view.frame = CGRectMake(0, height, ScreenWidth, ScreenHeight-height);
    _svc.delegate = self.delegate;
    _svc.view.hidden = YES;
    [self.view addSubview:_svc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSelectBtn{
    _leftBtn = [MyUtil createBtn:CGRectMake(50, 0, (ScreenWidth-100)/2, (ScreenWidth-100)/2*56/249)
                           image:@"zxzxbtn"
                       highImage:nil
                        selected:@"zxzxbtn_hover"
                          target:self action:@selector(switchInterface:)];
    _leftBtn.selected = YES;
    [self.view addSubview:_leftBtn];
    
    _rightBtn = [MyUtil createBtn:CGRectMake(50+(ScreenWidth-100)/2, 0, (ScreenWidth-100)/2, (ScreenWidth-100)/2*56/249)
                            image:@"jcztbtn"
                        highImage:nil
                         selected:@"jcztbtn_hover"
                           target:self action:@selector(switchInterface:)];
    [self.view addSubview:_rightBtn];
}

#pragma mark - ClickAction
- (void)switchInterface:(UIButton *)btn{
    if(btn == _leftBtn){
        _leftBtn.selected = YES;
        _rightBtn.selected = NO;
        _ncvc.view.hidden = NO;
        _svc.view.hidden = YES;
    }else if(btn == _rightBtn){
        _leftBtn.selected = NO;
        _rightBtn.selected = YES;
        _ncvc.view.hidden = YES;
        _svc.view.hidden = NO;
    }
}

@end
