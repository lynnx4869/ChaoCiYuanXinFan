//
//  SettingViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/27.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SettingViewController.h"
#import "MyUtil.h"
#import "SDImageCache.h"
#import "HttpManager.h"
#import "Const.h"
#import "KVNProgress.h"
#import "AboutViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, HttpManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNav:nil bgImage:@"grzx" type:ShortLength rightBtn:nil withLength:0];
    
    _dataArray = @[@"user_btn1", @"user_btn2", @"user_btn3", @"user_btn4", @"clean", @"user_btn5"];
    
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView{
    UIButton *headBtn = [MyUtil createBtn:CGRectMake((ScreenWidth-100)/2, 80, 100, 100)
                                             image:@"guitou"
                                         highImage:nil
                                          selected:nil
                                            target:nil
                                            action:nil];
    headBtn.showsTouchWhenHighlighted = YES;
    [headBtn setBackgroundImage:[UIImage imageNamed:@"user_img"] forState:UIControlStateNormal];
    [self.view addSubview:headBtn];
    
    UIButton *loginBtn = [MyUtil createBtn:CGRectMake((ScreenWidth-80)/2, 200, 80, 30)
                                     image:@"login"
                                 highImage:@"login_hover"
                                  selected:nil
                                    target:nil
                                    action:nil];
    [self.view addSubview:loginBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, ScreenWidth, 180) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 3){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.text = @"v2.4";
        label.textAlignment = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:137/225.0 green:137/225.0 blue:137/225.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:10];
        cell.accessoryView = label;
    }else if(indexPath.row == 4){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.tag = 400;
        label.text = [NSString stringWithFormat:@"%0.2f M", ((float)[[SDImageCache sharedImageCache] getSize])/1024/1024];
        label.textAlignment = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:137/225.0 green:137/225.0 blue:137/225.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:10];
        cell.accessoryView = label;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLabel:)
                                                     name:lClearNoti
                                                   object:nil];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            [self checkUpdate];
            break;
        }
        case 4:{
            [self clearImageCaches];
            break;
        }
        case 5:{
            AboutViewController *avc = [[AboutViewController alloc] init];
            [self presentViewController:avc animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

- (void)clearImageCaches{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [KVNProgress showProgress:0.0f status:@"清理中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [KVNProgress updateProgress:0.2f animated:YES];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [KVNProgress updateProgress:0.4f animated:YES];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [KVNProgress updateProgress:0.6f animated:YES];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [KVNProgress updateProgress:0.8f animated:YES];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [KVNProgress updateProgress:1.0f animated:YES];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [KVNProgress showSuccessWithStatus:@"清理成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:lClearNoti object:nil];
        });
    }];
}

#pragma mark - HttpManagerDelegate
- (void)checkUpdate{
    [KVNProgress showWithStatus:@"检测中"];
    
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestPost:lUpdateUrl parameters:@{@"id" : @"907769056"}];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Update:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    if([rootDic[@"results"][0][@"version"] isEqualToString:@"2.4"]){
        [KVNProgress dismiss];
        [KVNProgress showSuccessWithStatus:@"已经是最新版本"];
    }else{
        NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/chao-ci-yuan-xin-fan-zui-xin/id907769056?mt=8&uo=4"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - NSNotificationCenter
- (void)updateLabel:(NSNotification *)no{
    UILabel *label = (UILabel *)[self.view viewWithTag:400];
    label.text = @"0.0 M";
}

- (void)dealloc{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
