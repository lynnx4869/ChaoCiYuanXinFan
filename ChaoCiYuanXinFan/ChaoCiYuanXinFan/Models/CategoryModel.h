//
//  CategoryModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, strong, setter=setCat_id:) NSString *catId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;

/*
 "cat_id": "1",
"name": "七月番",
"image": "http://qn.18touch.com/uploads/20141217/1418810495316274.jpg"
*/

@end
