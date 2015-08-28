//
//  RootPopViewController.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    ShortLength,
    LongLength
} BgImageLength;

@interface RootPopViewController : UIViewController

- (void)addNav:(NSString *)title bgImage:(NSString *)imageName type:(BgImageLength)type rightBtn:(UIButton *)btn withLength:(CGFloat)length;

@end
