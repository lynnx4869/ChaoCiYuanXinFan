//
//  ConsultationBigCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ConsultationBigCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ConsultationBigCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ConsultationBigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_bgImageView];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
        }];
        
        UIView *titleView = [[UIView alloc] init];
        titleView.backgroundColor = [UIColor blackColor];
        titleView.alpha = 0.5;
        [self.contentView addSubview:titleView];
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
            make.height.equalTo(@25);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor whiteColor];
        [titleView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleView.mas_top).with.offset(0);
            make.bottom.equalTo(titleView.mas_bottom).with.offset(0);
            make.left.equalTo(titleView.mas_left).with.offset(15);
            make.right.equalTo(titleView.mas_right).with.offset(-15);
        }];
    }
    return self;
}

- (void)setModel:(ConsultationModel *)model{
    if(_model != model){
        _model = nil;
        _model = model;
        
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img]
                        placeholderImage:[UIImage imageNamed:@"tcimg"]];
        _titleLabel.text = model.title;
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
