//
//  AutoLabelModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoLabelModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong, setter=setFan_id:) NSString *fanId;

/*
 "name": "血型君",
 "color": "3498DB",
 "fan_id": "16203"
 */

@end
