//
//  RankingCell.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressModel.h"
#import "RankingModel.h"
#import "RootPagesViewController.h"

@interface RankingCell : UITableViewCell

@property (nonatomic, strong) RankingModel *model;
@property (nonatomic, weak) RootPagesViewController *delegate;

@end
