//
//  GroupCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "GroupCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface GroupCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *residentLabel;
@property (nonatomic, strong) UILabel *heatLabel;

@end

@implementation GroupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_iconImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.textColor = [UIColor darkGrayColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
        
        _residentLabel = [[UILabel alloc] init];
        _residentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _residentLabel.textColor = [UIColor darkGrayColor];
        _residentLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_residentLabel];

        _heatLabel = [[UILabel alloc] init];
        _heatLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _heatLabel.textColor = [UIColor darkGrayColor];
        _heatLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_heatLabel];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.right.equalTo(_nameLabel.mas_left).with.offset(-10);
            make.right.equalTo(_residentLabel.mas_left).with.offset(-10);
            make.right.equalTo(_heatLabel.mas_left).with.offset(-10);
            make.width.equalTo(@60);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(_residentLabel.mas_top).with.offset(-10);
            make.left.equalTo(_iconImageView.mas_right).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.height.equalTo(@20);
        }];
        
        [_residentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(10);
            make.bottom.equalTo(_heatLabel.mas_top).with.offset(0);
            make.left.equalTo(_iconImageView.mas_right).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.height.equalTo(_heatLabel);
        }];
        
        [_heatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_residentLabel.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
            make.left.equalTo(_iconImageView.mas_right).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.height.equalTo(_residentLabel);
        }];
    }
    return self;
}

- (void)setModel:(GroupModel *)model{
    if(model != _model){
        _model = nil;
        _model = model;
        
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"tcimg"]];
        _nameLabel.text = model.Name;
        _residentLabel.text = [NSString stringWithFormat:@"入驻：%@", model.ResidentCount];
        _heatLabel.text = [NSString stringWithFormat:@"发帖：%@", model.Heat];
    }
}

- (void)setBlankCell{
    _iconImageView.image = nil;
    _nameLabel.text = @"";
    _residentLabel.text = @"";
    _heatLabel.text = @"";
}

@end
