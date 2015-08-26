//
//  ConsultationModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultationModel : NSObject

@property (nonatomic, strong, setter=setId:) NSString *consultationId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *posttime;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *img;

/*
 "id": "747846",
 "title": "第一卷封面&展开图公布",
 "author": "admin",
 "url": "http://api.18touch.com/index.php?c=Nzs&a=getcontent&helper=&id=747846&v=a08261123&type=acg",
 "posttime": 1440557956,
 "summary": "人气少女向作品《赤发白雪姬》自从开播以来受到了动漫迷们的广泛关注。而近日，有关本作品蓝光的封面以及展开图等详情也正式公布。",
 "img": "http://qn.18touch.com/uploads/acg201508/1440557936411029.png?imageMogr2/thumbnail/!75p"
 */

@end
