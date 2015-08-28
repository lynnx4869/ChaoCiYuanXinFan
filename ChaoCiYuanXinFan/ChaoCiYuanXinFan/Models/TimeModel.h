//
//  TimeModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong, setter=setBbs_id:) NSString *bbsId;

/*
 "name": "网球优等生第二季",
 "url": "http://api.18touch.com/index.php?c=acg&a=detail&id=11192",
 "image": "http://qn.18touch.com/uploads/fan/201412011417422619.jpg",
 "bbs_id": "181415"
 */

@end
