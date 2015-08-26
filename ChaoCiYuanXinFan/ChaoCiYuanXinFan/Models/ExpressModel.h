//
//  ExpressModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressModel : NSObject

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *latest;
@property (nonatomic, strong) NSString *bbsid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong, setter=setVideo_info:) NSString *videoInfo;
@property (nonatomic, strong) NSString *video;

@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *desc;

@end
