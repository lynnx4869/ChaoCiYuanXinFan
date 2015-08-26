//
//  RankingModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RankingModel : NSObject

@property (nonatomic, strong, setter=setCat_id:) NSString *catId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableArray *postsArray;

@end
