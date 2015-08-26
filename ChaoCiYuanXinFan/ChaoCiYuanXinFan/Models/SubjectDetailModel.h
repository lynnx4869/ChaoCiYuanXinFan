//
//  SubjectDetailModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectDetailModel : NSObject

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong, setter=setId:) NSString *subjectDetailId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *posttime;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) NSString *shareimg;
@property (nonatomic, strong) NSString *sharetext;
@property (nonatomic, strong) NSString *baseUrl;

@end
