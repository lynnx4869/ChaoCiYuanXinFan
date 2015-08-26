//
//  RankingModel.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RankingModel.h"

@implementation RankingModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.postsArray = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
