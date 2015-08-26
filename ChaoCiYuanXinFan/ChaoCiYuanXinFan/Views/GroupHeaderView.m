//
//  GroupHeaderView.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "GroupHeaderView.h"
#import "Masonry.h"

@implementation GroupHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _bgImageView.image = [UIImage imageNamed:@"bg_head_allGroup"];
        [self addSubview:_bgImageView];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
        }];
    }
    return self;
}

@end
