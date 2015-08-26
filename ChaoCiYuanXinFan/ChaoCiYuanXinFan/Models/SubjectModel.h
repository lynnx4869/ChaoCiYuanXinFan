//
//  SubjectModel.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectModel : NSObject

@property (nonatomic, strong, setter=setId:) NSString *subjectId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *posttime;
@property (nonatomic, strong) NSString *img;

/*
 "id": "747849",
 "title": "“2010年代播放的少女漫画原作恋爱动画”人气投票结果发表！",
 "author": "橘Ace",
 "url": "http://api.18touch.com/index.php?c=Nzs&a=getcontent&helper=ACG%E7%B2%BE%E5%93%81%E6%96%87%E7%AB%A0&id=747849&v=a08261551&type=acg",
 "posttime": 1440572746,
 "img": "http://qn.18touch.com/uploads/acg201508/1440572732634091.png?imageMogr2/thumbnail/!75p"
 */

@end
