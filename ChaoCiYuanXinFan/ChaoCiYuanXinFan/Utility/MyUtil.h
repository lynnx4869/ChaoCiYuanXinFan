//
//  MyUtil.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyUtil : NSObject

+ (UIImageView *)createImageView:(CGRect)frame image:(NSString *)imageName;

+ (UIButton *)createBtn:(CGRect)frame image:(NSString *)imageName highImage:(NSString *)highImageName selected:(NSString *)selectedName target:(id)target action:(SEL)action;

+ (UILabel *)createLabel:(CGRect)frame title:(NSString *)title;

@end
