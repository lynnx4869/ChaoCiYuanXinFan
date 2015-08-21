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
@property (nonatomic, strong) NSString *videoInfo;
@property (nonatomic, strong) NSString *video;

/*
 "img": "http://qn.18touch.com/uploads/acg201501/1426581651799973.jpg",
 "title": "战斗之魂烈火魂",
 "latest": "第20集",
 "bbsid": "210307",
 "type": "video",
 "url": "http://api.18touch.com/index.php?c=acg&a=detail&id=16298",
 "time": 1440048863,
 "video_info": "更新至第20集",
 "video": 0
 */

@end
