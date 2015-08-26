//
//  CategoryDetailCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "CategoryDetailCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface CategoryDetailCell ()

@property (nonatomic, strong) UIImageView *aniImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *videoInfoLabel;

@end

@implementation CategoryDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellView];
    }
    return self;
}

- (void)createCellView{
    _aniImageView = [[UIImageView alloc] init];
    _aniImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _aniImageView.layer.masksToBounds = YES;
    _aniImageView.layer.cornerRadius = 10;
    [self.contentView addSubview:_aniImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = 0;
    [self.contentView addSubview:_titleLabel];
    
    _videoInfoLabel = [[UILabel alloc] init];
    _videoInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _videoInfoLabel.textColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    _videoInfoLabel.font = [UIFont systemFontOfSize:15];
    _videoInfoLabel.textAlignment = 0;
    [self.contentView addSubview:_videoInfoLabel];
    
    [_aniImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(_titleLabel.mas_left).with.offset(-10);
        make.right.equalTo(_videoInfoLabel.mas_left).with.offset(-10);
        make.width.equalTo(@70);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.bottom.equalTo(_videoInfoLabel.mas_top).with.offset(-10);
        make.left.equalTo(_aniImageView.mas_right).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.equalTo(_videoInfoLabel);
    }];
    
    [_videoInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        make.left.equalTo(_aniImageView.mas_right).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.equalTo(_titleLabel);
    }];
}

- (void)setModel:(ExpressModel *)model{
    if(_model != model){
        _model = nil;
        _model = model;
        
        [_aniImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"tcimg"]];
        _titleLabel.text = model.title;
        _videoInfoLabel.text = model.videoInfo;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
