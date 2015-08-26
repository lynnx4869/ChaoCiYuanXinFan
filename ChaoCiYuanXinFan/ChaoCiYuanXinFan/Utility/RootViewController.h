//
//  RootViewController.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"
#import "HttpManager.h"
#import "RootPagesViewController.h"

@interface RootViewController : UIViewController

@property (nonatomic, weak) RootPagesViewController *delegate;

@end
