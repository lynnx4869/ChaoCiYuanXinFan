//
//  ConsultationSmallCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ConsultationSmallCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ConsultationSmallCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation ConsultationSmallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.numberOfLines = 2;
        [self.contentView addSubview:_nameLabel];
        
        _summaryLabel = [[UILabel alloc] init];
        _summaryLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _summaryLabel.font = [UIFont systemFontOfSize:10];
        _summaryLabel.textColor = [UIColor darkGrayColor];
        _summaryLabel.numberOfLines = 2;
        [self.contentView addSubview:_summaryLabel];
        
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_rightImageView];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(5);
            make.bottom.equalTo(_summaryLabel.mas_top).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(5);
            make.right.equalTo(_rightImageView.mas_left).with.offset(-5);
            make.height.equalTo(_summaryLabel);
        }];
        
        [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
            make.left.equalTo(self.contentView.mas_left).with.offset(5);
            make.right.equalTo(_rightImageView.mas_left).with.offset(-5);
            make.height.equalTo(_nameLabel);
        }];
        
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
            make.right.equalTo(self.contentView.mas_right).with.offset(-5);
            make.left.equalTo(_nameLabel.mas_right).with.offset(5);
            make.left.equalTo(_summaryLabel.mas_right).with.offset(5);
            make.width.equalTo(@90);
        }];
    }
    return self;
}

- (void)setModel:(ConsultationModel *)model{
    if(_model != model){
        _model = nil;
        _model = model;
        
        _nameLabel.text = model.title;
        _summaryLabel.text = model.summary;
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:model.img]
                           placeholderImage:[UIImage imageNamed:@"tcimg"]];
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
