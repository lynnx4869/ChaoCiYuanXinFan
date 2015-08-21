//
//  ExpressCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ExpressCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface ExpressCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *videoInfoLabel;

@end

@implementation ExpressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellView];
    }
    return self;
}

- (void)createCellView{
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_bgImageView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(5, 10, 5, 10);
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
    
    UIView *titleBgView = [[UIView alloc] init];
    titleBgView.translatesAutoresizingMaskIntoConstraints = NO;
    titleBgView.backgroundColor = [UIColor blackColor];
    titleBgView.alpha = 0.5;
    [_bgImageView addSubview:titleBgView];
    
    [titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.left.equalTo(_bgImageView.mas_left).with.offset(0);
        make.right.equalTo(_bgImageView.mas_right).with.offset(0);
        make.bottom.equalTo(_bgImageView.mas_bottom).with.offset(0);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = 0;
    [titleBgView addSubview:_titleLabel];
    
    _videoInfoLabel = [[UILabel alloc] init];
    _videoInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _videoInfoLabel.textColor = [UIColor whiteColor];
    _videoInfoLabel.font = [UIFont systemFontOfSize:13];
    _videoInfoLabel.textAlignment = 2;
    [titleBgView addSubview:_videoInfoLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBgView.mas_top).with.offset(5);
        make.bottom.equalTo(titleBgView.mas_bottom).with.offset(-5);
        make.left.equalTo(titleBgView.mas_left).with.offset(5);
        make.right.equalTo(_videoInfoLabel.mas_left).with.offset(0);
        make.width.equalTo(_videoInfoLabel);
    }];
    
    [_videoInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBgView.mas_top).with.offset(5);
        make.bottom.equalTo(titleBgView.mas_bottom).with.offset(-5);
        make.right.equalTo(titleBgView.mas_left).with.offset(-5);
        make.left.equalTo(_titleLabel.mas_right).with.offset(0);
        make.width.equalTo(_titleLabel);
    }];
}

- (void)setModel:(ExpressModel *)model{
    if(_model != model){
        _model = model;
    }
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"tcimg"]];
    _titleLabel.text = model.title;
    _videoInfoLabel.text = model.videoInfo;
    
//    NSString *string = _videoInfoLabel.text;
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
//    [attrString addAttribute:NSForegroundColorAttributeName
//                       value:[UIColor redColor]
//                       range:[string rangeOfString:model.latest]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
