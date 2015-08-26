//
//  RankingView.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RankingView.h"
#import "Masonry.h"

@implementation RankingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_titleLabel];
        
        UILabel *updateLabel = [[UILabel alloc] init];
        updateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        updateLabel.text = @"更新：";
        updateLabel.font = [UIFont systemFontOfSize:10];
        updateLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:updateLabel];
        
        _videoInfoLabel = [[UILabel alloc] init];
        _videoInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _videoInfoLabel.font = [UIFont systemFontOfSize:10];
        _videoInfoLabel.textColor = [UIColor orangeColor];
        [self addSubview:_videoInfoLabel];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.bottom.equalTo(_titleLabel.mas_top).with.offset(0);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.bottom.equalTo(updateLabel.mas_top).with.offset(0);
            make.bottom.equalTo(_videoInfoLabel.mas_top).with.offset(0);
            make.height.equalTo(@15);
        }];
        
        [updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(_videoInfoLabel.mas_left).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.height.equalTo(@15);
            make.width.equalTo(@38);
        }];
        
        [_videoInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
            make.left.equalTo(updateLabel.mas_right).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.height.equalTo(@15);
        }];
    }
    return self;
}

@end
