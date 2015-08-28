//
//  SubjectDetailViewController.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SubjectDetailViewController.h"
#import "HttpManager.h"
#import "Const.h"
#import "SubjectDetailModel.h"
#import "KVNProgress.h"

@interface SubjectDetailViewController () <HttpManagerDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) SubjectDetailModel *model;

@end

@implementation SubjectDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString *bgString = @"";
    if(_type == 1){
        bgString = @"zxzxtop";
    }else if(_type == 2){
        bgString = @"jczttop";
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"psharebtn"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"psharebtn_hover"] forState:UIControlStateHighlighted];
    
    [self addNav:nil bgImage:bgString type:LongLength rightBtn:rightBtn withLength:20];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [_webView setScalesPageToFit:YES];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.hidden = YES;
    [self.view addSubview:_webView];
    
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HttpManagerDelegate
- (void)downloadData{
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:_urlString];
}

- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Subject:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    _model = [[SubjectDetailModel alloc] init];
    [_model setValuesForKeysWithDictionary:dic];

    [_webView loadHTMLString:_model.html baseURL:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [KVNProgress show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *jsString = [NSString stringWithFormat:
                          @"document.getElementById(\"Gtitle\").setAttribute(\"style\", \"font-size:30px;\");"
                          "var child=document.getElementById(\"cnzz\");"
                          "child.parentNode.removeChild(child);"
                          "nodes = document.getElementsByTagName(\"img\");"
                          "for(i = 0; i < nodes.length; i++){"
                          "nodes[i].setAttribute(\"src\", nodes[i].getAttribute(\"data-original\"));"
                          "nodes[i].setAttribute(\"style\", \"width:%f\")"
                          "}", ScreenWidth-30];
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
    
    [KVNProgress dismiss];
    _webView.hidden = NO;
}

@end
