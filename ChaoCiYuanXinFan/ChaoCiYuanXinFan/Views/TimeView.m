//
//  TimeView.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "TimeView.h"

@implementation TimeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (ScreenWidth-85)/4, 80)];
        [self addSubview:_headerImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, (ScreenWidth-85)/4, 10)];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.font = [UIFont systemFontOfSize:8];
        _nameLabel.textAlignment = 1;
        [self addSubview:_nameLabel];
    }
    return self;
}

@end
