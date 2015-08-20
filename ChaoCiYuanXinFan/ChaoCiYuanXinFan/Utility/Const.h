//
//  Const.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/20.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#ifndef ChaoCiYuanXinFan_Const_h
#define ChaoCiYuanXinFan_Const_h

//新番速递(有刷新无加载)
#define lExpressUrl @"http://api.18touch.com/index.php?c=acg&a=lists&limit=500&v=2"


//动画排行(无刷新加载)
#define lRankingUrl @"http://api.18touch.com/index.php?c=acg&a=getVedioRankList"


//分类推荐(有刷新无加载)
#define lCategoryUrl @"http://api.18touch.com/index.php?c=acg&a=getHotCategory"
//推荐细节(有刷新无加载)
#define lListByCategoryUrl @"http://api.18touch.com/index.php?c=acg&a=getListByCategory&cat_id=%@"


//动漫咨询
//最新资讯(初始00,后续为最后一个)
#define lConsultationUrl @"http://api.18touch.com/?c=Nzs&a=getlist&cat=%E5%8A%A8%E6%BC%AB%E8%B5%84%E8%AE%AF&img=1&summary=1&lastid=%@&lasttime=%@"
//精彩专题(初始00,后续为最后一个)
#define lSubjectUrl @"http://api.18touch.com/?c=Nzs&a=getlist&helper=ACG%E7%B2%BE%E5%93%81%E6%96%87%E7%AB%A0&img=1&lastid=%@&lasttime=%@"


//兴趣小组(有刷新无加载)
#define lGroupUrl @"http://api.bbs.18touch.com/Forum?zone=8700&dk=47cc89f3630b6e060e84f639738c08df947f77b3"


//时间表
#define lTimelineUrl @"http://api.18touch.com/?c=acg&a=timeline"

//动画细节详情
#define lAniDetailUrl @"http://api.18touch.com/index.php?c=acg&a=detail&id=%@"

//动画评论
#define lCommendUrl @"http://api.bbs.18touch.com/Post/80969?dk=47cc89f3630b6e060e84f639738c08df947f77b3&ak=&dl=false&comment=2&count=20&order=2"

//搜索
#define l @"http://api.18touch.com/index.php?c=acg&a=searchVedio&name=%@&offset=1"
//关键词
#define lHotKeyUrl @"http://api.18touch.com/index.php?c=acg&a=getHotKeyWords"


#endif
