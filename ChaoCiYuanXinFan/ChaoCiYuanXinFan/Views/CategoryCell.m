//
//  CategoryCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "CategoryCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface CategoryCell ()

@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UILabel *categoryLabel;

@end

@implementation CategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _categoryImageView = [[UIImageView alloc] init];
        _categoryImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_categoryImageView];
        
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _categoryLabel.font = [UIFont systemFontOfSize:12];
        _categoryLabel.textColor = [UIColor blackColor];
        _categoryLabel.textAlignment = 1;
        [self.contentView addSubview:_categoryLabel];
        
        [_categoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0);
            make.bottom.equalTo(_categoryLabel.mas_top).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
        }];
        
        [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_categoryImageView.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

- (void)setModel:(CategoryModel *)model{
    if(_model != model){
        _model = nil;
        _model = model;
        
        [_categoryImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"tcimg"]];
        _categoryLabel.text = model.name;
    }
}

@end
