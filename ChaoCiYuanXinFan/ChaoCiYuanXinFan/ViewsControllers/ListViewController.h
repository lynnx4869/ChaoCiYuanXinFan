//
//  ListCategoryViewController.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RootPopViewController.h"

typedef enum : NSUInteger{
    CategoryList,
    SearchList
} ListType;

@interface ListViewController : RootPopViewController

@property (nonatomic, strong) NSString *catId;
@property (nonatomic, strong) NSString *navTitle;
@property (nonatomic, assign) ListType type;

@end
