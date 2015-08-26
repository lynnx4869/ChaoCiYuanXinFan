//
//  GroupModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic, strong, setter=setId:) NSString *groupId;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Image;
@property (nonatomic, strong) NSString *Slogan;
@property (nonatomic, strong) NSString *Heat;
@property (nonatomic, strong) NSString *ResidentCount;

/*
 "Id": "8700",
 "Name": "ACG",
 "Image": "http://qn.18touch.com/tq/Images/18touch.png",
 "Slogan": "",
 "Heat": 0,
 "ResidentCount": "4"
 */

@end
