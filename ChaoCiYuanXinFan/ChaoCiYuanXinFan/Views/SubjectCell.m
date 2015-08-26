//
//  SubjectCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SubjectCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface SubjectCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation SubjectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_iconImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_nameLabel];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.bottom.equalTo(_nameLabel.mas_top).with.offset(0);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImageView.mas_bottom).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

- (void)setModel:(SubjectModel *)model{
    if(_model != model){
        _model = nil;
        _model = model;
        
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img]
                          placeholderImage:[UIImage imageNamed:@"tcimg"]];
        _nameLabel.text = model.title;
    }
}

@end
