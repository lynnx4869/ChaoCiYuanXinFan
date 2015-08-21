//
//  RootPagesViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RootPagesViewController.h"
#import "MyUtil.h"
#import "RankingViewController.h"
#import "CategoryViewController.h"
#import "ExpressViewController.h"
#import "ConsultationViewController.h"
#import "GroupViewController.h"

@interface RootPagesViewController ()
    <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray *vcArray;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation RootPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNav];
    [self createTopView];
    [self createPageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建界面
- (void)createNav{
    self.navigationItem.titleView = [MyUtil createImageView:CGRectMake(0, 0, 250*44/123, 44) image:@"new_logo"];
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:
                                [MyUtil createBtn:CGRectMake(0, 0, 20, 20)
                                            image:@"set"
                                        highImage:@"set_hover"
                                         selected:nil
                                           target:self
                                           action:@selector(gotoSetting:)]];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:
                                [MyUtil createBtn:CGRectMake(0, 0, 20, 20)
                                            image:@"glass"
                                        highImage:@"glass_hover"
                                         selected:nil
                                           target:self
                                           action:@selector(gotoSearch:)]];
    
    self.navigationItem.leftBarButtonItems = @[setItem, searchItem];
    
    UIBarButtonItem *timeLineItem = [[UIBarButtonItem alloc] initWithCustomView:
                                [MyUtil createBtn:CGRectMake(0, 0, 20, 20)
                                            image:@"clock"
                                        highImage:@"clock_hover"
                                         selected:nil
                                           target:self
                                           action:@selector(gotoTimeLine:)]];
    
    UIBarButtonItem *CollectsItem = [[UIBarButtonItem alloc] initWithCustomView:
                                   [MyUtil createBtn:CGRectMake(0, 0, 20, 20)
                                               image:@"sc"
                                           highImage:@"sc_hover"
                                            selected:nil
                                              target:self
                                              action:@selector(gotoCollects:)]];
    
    self.navigationItem.rightBarButtonItems = @[timeLineItem, CollectsItem];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"sp_back"]
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)createTopView{
    _topHeight = 29 * (ScreenWidth / 5) / 108 + 10;
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, _topHeight)];
    topView.image = [UIImage imageNamed:@"bg_nav"];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    
    NSArray *imageName = @[@"name6", @"name7", @"name2", @"name4", @"name5"];
    NSArray *selectName = @[@"name6_hover", @"name7_hover", @"name2_hover", @"name4_hover", @"name5_hover"];
    for(NSInteger i = 0; i < imageName.count; i++){
        UIButton *btn = [MyUtil createBtn:CGRectMake(ScreenWidth/5*i, 0, ScreenWidth/5, _topHeight)
                                    image:imageName[i]
                                highImage:nil
                                 selected:selectName[i]
                                   target:self
                                   action:@selector(changeViewByBtn:)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        btn.tag = 100 + i;
        if(i == 2){
            btn.selected = YES;
        }
        [topView addSubview:btn];
    }
    
    
    UIView *selectBtnLine = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/5*2, _topHeight-2, ScreenWidth/5, 2)];
    selectBtnLine.backgroundColor = [UIColor colorWithRed:0/225.0 green:106/255.0 blue:220/255.0 alpha:1.0];
    selectBtnLine.tag = 150;
    [topView addSubview:selectBtnLine];
}

- (void)createPageControl{
    _vcArray = [NSMutableArray array];
    NSArray *vcTitleArray = @[@"RankingViewController", @"CategoryViewController", @"ExpressViewController", @"ConsultationViewController", @"GroupViewController"];
    for(NSString *clsString in vcTitleArray){
        Class cls = NSClassFromString(clsString);
        UIViewController *vc = [[cls alloc] init];
        [_vcArray addObject:vc];
    }
    
    _curPage = 2;
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:1
                                                          navigationOrientation:0
                                                                        options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [_pageViewController setViewControllers:@[_vcArray[2]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES
                                 completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 68+_topHeight, ScreenWidth, ScreenHeight-68-_topHeight);
    [self.view addSubview:_pageViewController.view];
}

#pragma mark - 点击事件
- (void)gotoSetting:(UIButton *)btn{
    
}

- (void)gotoSearch:(UIButton *)btn{
    
}

- (void)gotoTimeLine:(UIButton *)btn{
    
}

- (void)gotoCollects:(UIButton *)btn{
    
}

- (void)changeViewByBtn:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    
    UIButton *beforeBtn = (UIButton *)[self.view viewWithTag:100+_curPage];
    UIButton *afterBtn = (UIButton *)[self.view viewWithTag:100+index];
    beforeBtn.selected = NO;
    afterBtn.selected = YES;
    UIView *lineView = (UIView *)[self.view viewWithTag:150];
    lineView.frame = CGRectMake(ScreenWidth/5*index, _topHeight-2, ScreenWidth/5, 2);
    
    if(index > _curPage){
        [_pageViewController setViewControllers:@[_vcArray[index]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         _curPage = index;
                                     }];
    }else{
        [_pageViewController setViewControllers:@[_vcArray[index]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         _curPage = index;
                                     }];
    }
}

#pragma mark - UIPageViewControllerDelegate, UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if(index + 1 == _vcArray.count){
        return nil;
    }
    return _vcArray[index+1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if(index == 0){
        return nil;
    }
    return _vcArray[index-1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIButton *beforeBtn = (UIButton *)[self.view viewWithTag:100+_curPage];
    _curPage = [_vcArray indexOfObject:_pageViewController.viewControllers[0]];
    UIButton *afterBtn = (UIButton *)[self.view viewWithTag:100+_curPage];
    beforeBtn.selected = NO;
    afterBtn.selected = YES;
    
    UIView *lineView = (UIView *)[self.view viewWithTag:150];
    lineView.frame = CGRectMake(ScreenWidth/5*_curPage, _topHeight-2, ScreenWidth/5, 2);
}

@end
