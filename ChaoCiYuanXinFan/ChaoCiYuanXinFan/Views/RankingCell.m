//
//  RankingCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/24.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "RankingCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "RankingView.h"
#import "ListCategoryViewController.h"
#import "StarView.h"

@interface RankingCell ()

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, strong) UIView *firstBgView;
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, strong) UILabel *firstTitleLabel;
@property (nonatomic, strong) UILabel *firstVideoLabel;
@property (nonatomic, strong) StarView *firstStarView;
@property (nonatomic, strong) UILabel *firstDescLabel;

@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) UIButton *thirdBtn;

@end

@implementation RankingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellView];
    }
    return self;
}

- (void)createCellView{
    //主题设计
    UIImageView *titleImageView = [[UIImageView alloc] init];
    titleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    titleImageView.image = [UIImage imageNamed:@"videoranktitle"];
    titleImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:titleImageView];
    
    UITapGestureRecognizer *tapFirstBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPush:)];
    _firstBgView = [[UIView alloc] init];
    _firstBgView.translatesAutoresizingMaskIntoConstraints = NO;
    _firstBgView.backgroundColor = [UIColor clearColor];
    _firstBgView.userInteractionEnabled = YES;
    _firstBgView.tag = 100;
    [_firstBgView addGestureRecognizer:tapFirstBg];
    [self.contentView addSubview:_firstBgView];
    
    _secondImageView = [[UIImageView alloc] init];
    _secondImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _secondImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_secondImageView];
    
    UIView *viewRank = [[UIView alloc] init];
    viewRank.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:viewRank];
    
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(_firstBgView.mas_top).with.offset(-10);
        make.height.equalTo(@(44*ScreenWidth/641));
    }];
    
    [_firstBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleImageView.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(_secondImageView.mas_top).with.offset(-10);
        make.height.equalTo(@(243*(ScreenWidth-20)/642));
    }];
    
    [_secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstBgView.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(viewRank.mas_top).with.offset(-10);
        make.height.equalTo(@(243*(ScreenWidth-20)/625));
    }];
    
    [viewRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondImageView.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
    }];
    
    //第一部分
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    [titleImageView addSubview:_titleLabel];
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_titleBtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleImageView addSubview:_titleBtn];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleImageView.mas_top).with.offset(0);
        make.left.equalTo(titleImageView.mas_left).with.offset(5);
        make.bottom.equalTo(titleImageView.mas_bottom).with.offset(0);
        make.width.equalTo(@80);
    }];
    
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleImageView.mas_top).with.offset(0);
        make.right.equalTo(titleImageView.mas_right).with.offset(0);
        make.bottom.equalTo(titleImageView.mas_bottom).with.offset(0);
        make.width.equalTo(@50);
    }];
    
    //第二部分
    _firstImageView = [[UIImageView alloc] init];
    _firstImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_firstBgView addSubview:_firstImageView];
    
    [_firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstBgView.mas_top).with.offset(0);
        make.left.equalTo(_firstBgView.mas_left).with.offset(0);
        make.bottom.equalTo(_firstBgView.mas_bottom).with.offset(0);
        make.width.equalTo(@((ScreenWidth-20)*3.2/5));
    }];
    
    UIImageView *firstCoverImageView = [[UIImageView alloc] init];
    firstCoverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    firstCoverImageView.image = [UIImage imageNamed:@"cover1"];
    firstCoverImageView.userInteractionEnabled = YES;
    [_firstBgView addSubview:firstCoverImageView];
    
    [firstCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstBgView.mas_top).with.offset(0);
        make.bottom.equalTo(_firstBgView.mas_bottom).with.offset(0);
        make.left.equalTo(_firstBgView.mas_left).with.offset(0);
        make.right.equalTo(_firstBgView.mas_right).with.offset(0);
    }];
    
    _firstTitleLabel = [[UILabel alloc] init];
    _firstTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _firstTitleLabel.font = [UIFont systemFontOfSize:10];
    _firstTitleLabel.textAlignment = 1;
    [_firstBgView addSubview:_firstTitleLabel];
    
    UILabel *updateVideoLabel = [[UILabel alloc] init];
    updateVideoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    updateVideoLabel.text = @"更新至";
    updateVideoLabel.font = [UIFont systemFontOfSize:9];
    updateVideoLabel.textAlignment = 2;
    updateVideoLabel.textColor = [UIColor darkGrayColor];
    [_firstBgView addSubview:updateVideoLabel];
    
    _firstVideoLabel = [[UILabel alloc] init];
    _firstVideoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _firstVideoLabel.font = [UIFont systemFontOfSize:9];
    _firstVideoLabel.textColor = [UIColor redColor];
    [_firstBgView addSubview:_firstVideoLabel];
    
    UILabel *rankVideoLabel = [[UILabel alloc] init];
    rankVideoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rankVideoLabel.text = @"评分";
    rankVideoLabel.font = [UIFont systemFontOfSize:9];
    rankVideoLabel.textAlignment = 2;
    rankVideoLabel.textColor = [UIColor darkGrayColor];
    [_firstBgView addSubview:rankVideoLabel];
    
    _firstStarView = [[StarView alloc] init];
    _firstStarView.translatesAutoresizingMaskIntoConstraints = NO;
    [_firstBgView addSubview:_firstStarView];
    
    _firstDescLabel = [[UILabel alloc] init];
    _firstDescLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _firstDescLabel.font = [UIFont systemFontOfSize:9];
    _firstDescLabel.numberOfLines = 0;
    _firstDescLabel.textColor = [UIColor darkGrayColor];
    [_firstBgView addSubview:_firstDescLabel];
    
    [_firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstBgView.mas_top).with.offset(10);
        make.right.equalTo(_firstBgView.mas_right).with.offset(0);
        make.bottom.equalTo(updateVideoLabel.mas_top).with.offset(-5);
        make.bottom.equalTo(_firstVideoLabel.mas_top).with.offset(-5);
        make.width.equalTo(@((ScreenWidth-20)*1.9/5));
    }];
    
    [updateVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstTitleLabel.mas_bottom).with.offset(5);
        make.right.equalTo(_firstVideoLabel.mas_left).with.offset(0);
        make.bottom.equalTo(rankVideoLabel.mas_top).with.offset(-3);
        make.width.equalTo(@((ScreenWidth-20)*0.95/5));
    }];
    
    [_firstVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstTitleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(updateVideoLabel.mas_right).with.offset(0);
        make.right.equalTo(_firstBgView.mas_right).with.offset(0);
        make.bottom.equalTo(_firstStarView.mas_top).with.offset(-3);
        make.width.equalTo(@((ScreenWidth-20)*0.95/5));
    }];
    
    [rankVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(updateVideoLabel.mas_bottom).with.offset(3);
        make.right.equalTo(_firstStarView.mas_left).with.offset(0);
        make.bottom.equalTo(_firstDescLabel.mas_top).with.offset(0);
        make.width.equalTo(@((ScreenWidth-20)*0.95/5));
    }];
    
    [_firstStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstVideoLabel.mas_bottom).with.offset(3);
        make.left.equalTo(rankVideoLabel.mas_right).with.offset(0);
        make.right.equalTo(_firstBgView.mas_right).with.offset(0);
        make.bottom.equalTo(_firstDescLabel.mas_top).with.offset(0);
        make.width.equalTo(@((ScreenWidth-20)*0.95/5));
    }];
    
    [_firstDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rankVideoLabel.mas_bottom).with.offset(0);
        make.top.equalTo(_firstStarView.mas_bottom).with.offset(0);
        make.right.equalTo(_firstBgView.mas_right).with.offset(-3);
        make.bottom.equalTo(_firstBgView.mas_bottom).with.offset(-3);
        make.width.equalTo(@((ScreenWidth-20)*1.9/5));
    }];
    
    //第三部分
    UIImageView *secondCoverImageView = [[UIImageView alloc] init];
    secondCoverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    secondCoverImageView.image = [UIImage imageNamed:@"cover23"];
    [_secondImageView addSubview:secondCoverImageView];
    
    [secondCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondImageView.mas_top).with.offset(0);
        make.bottom.equalTo(_secondImageView.mas_bottom).with.offset(0);
        make.left.equalTo(_secondImageView.mas_left).with.offset(0);
        make.right.equalTo(_secondImageView.mas_right).with.offset(0);
    }];
    
    _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _secondBtn.tag = 101;
    [_secondBtn addTarget:self action:@selector(clickPush:) forControlEvents:UIControlEventTouchUpInside];
    [_secondImageView addSubview:_secondBtn];
    
    _thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _thirdBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _thirdBtn.tag = 102;
    [_thirdBtn addTarget:self action:@selector(clickPush:) forControlEvents:UIControlEventTouchUpInside];
    [_secondImageView addSubview:_thirdBtn];
    
    [_secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondImageView.mas_top).with.offset(0);
        make.left.equalTo(_secondImageView.mas_left).with.offset(0);
        make.bottom.equalTo(_secondImageView.mas_bottom).with.offset(0);
        make.width.equalTo(@((ScreenWidth-20)*2/5));
    }];
    
    [_thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondImageView.mas_top).with.offset(0);
        make.right.equalTo(_secondImageView.mas_right).with.offset(0);
        make.bottom.equalTo(_secondImageView.mas_bottom).with.offset(0);
        make.width.equalTo(@((ScreenWidth-20)*2/5));
    }];
    
    //第四部分
    UITapGestureRecognizer *tapRank1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPush:)];
    RankingView *viewRank1 = [[RankingView alloc] init];
    viewRank1.translatesAutoresizingMaskIntoConstraints = NO;
    viewRank1.tag = 103;
    viewRank1.userInteractionEnabled = YES;
    [viewRank1 addGestureRecognizer:tapRank1];
    [viewRank addSubview:viewRank1];
    
    UITapGestureRecognizer *tapRank2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPush:)];
    RankingView *viewRank2 = [[RankingView alloc] init];
    viewRank2.translatesAutoresizingMaskIntoConstraints = NO;
    viewRank2.tag = 104;
    viewRank2.userInteractionEnabled = YES;
    [viewRank2 addGestureRecognizer:tapRank2];
    [viewRank addSubview:viewRank2];
    
    UITapGestureRecognizer *tapRank3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPush:)];
    RankingView *viewRank3 = [[RankingView alloc] init];
    viewRank3.translatesAutoresizingMaskIntoConstraints = NO;
    viewRank3.tag = 105;
    viewRank3.userInteractionEnabled = YES;
    [viewRank3 addGestureRecognizer:tapRank3];
    [viewRank addSubview:viewRank3];
    
    UITapGestureRecognizer *tapRank4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPush:)];
    RankingView *viewRank4 = [[RankingView alloc] init];
    viewRank4.translatesAutoresizingMaskIntoConstraints = NO;
    viewRank4.tag = 106;
    viewRank4.userInteractionEnabled = YES;
    [viewRank4 addGestureRecognizer:tapRank4];
    [viewRank addSubview:viewRank4];
    
    _array = @[viewRank1, viewRank2, viewRank3, viewRank4];
    
    [viewRank1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRank.mas_top).with.offset(0);
        make.left.equalTo(viewRank.mas_left).with.offset(0);
        make.right.equalTo(viewRank2.mas_left).with.offset(-10);
        make.bottom.equalTo(viewRank3.mas_top).with.offset(-10);
        make.width.equalTo(viewRank2);
        make.height.equalTo(viewRank3);
    }];
    
    [viewRank2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRank.mas_top).with.offset(0);
        make.left.equalTo(viewRank1.mas_right).with.offset(10);
        make.right.equalTo(viewRank.mas_right).with.offset(0);
        make.bottom.equalTo(viewRank4.mas_top).with.offset(-10);
        make.width.equalTo(viewRank1);
        make.height.equalTo(viewRank4);
    }];
    
    [viewRank3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRank1.mas_bottom).with.offset(10);
        make.left.equalTo(viewRank.mas_left).with.offset(0);
        make.right.equalTo(viewRank4.mas_left).with.offset(-10);
        make.bottom.equalTo(viewRank.mas_bottom).with.offset(0);
        make.width.equalTo(viewRank4);
        make.height.equalTo(viewRank1);
    }];
    
    [viewRank4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRank2.mas_bottom).with.offset(10);
        make.left.equalTo(viewRank3.mas_right).with.offset(10);
        make.right.equalTo(viewRank.mas_right).with.offset(0);
        make.bottom.equalTo(viewRank.mas_bottom).with.offset(0);
        make.width.equalTo(viewRank3);
        make.height.equalTo(viewRank2);
    }];
}

- (void)setModel:(RankingModel *)model{
    if(_model != model){
        _model = nil;
        _model = model;
        
        _titleLabel.text = [NSString stringWithFormat:@"%@排行榜", model.type];
        
        ExpressModel *firstModel = _model.postsArray[0];
        [_firstImageView sd_setImageWithURL:[NSURL URLWithString:firstModel.img] placeholderImage:[UIImage imageNamed:@"tcimg"]];
        _firstTitleLabel.text = firstModel.title;
        _firstVideoLabel.text = firstModel.video;
        [_firstStarView setStarRanking:[firstModel.score intValue]];
        _firstDescLabel.text = firstModel.desc;
        
        ExpressModel *secondModel = _model.postsArray[1];
        [_secondImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.img] placeholderImage:[UIImage imageNamed:@"tcimg"]];
        
        for(NSInteger i = 0; i < 4; i++){
            RankingView *rankView = _array[i];
            ExpressModel *expressModel = model.postsArray[i+3];
            
            [rankView.imageView sd_setImageWithURL:[NSURL URLWithString:expressModel.img] placeholderImage:[UIImage imageNamed:@"tcimg"]];
            rankView.titleLabel.text = expressModel.title;
            rankView.videoInfoLabel.text = expressModel.videoInfo;
        }
    }
}

#pragma mark - ClickAction
- (void)moreClick:(UIButton *)btn{
    ListCategoryViewController *lcvc = [[ListCategoryViewController alloc] init];
    lcvc.catId = _model.catId;
    lcvc.typeTitle = _model.type;
    if(self.delegate){
        [self.delegate.navigationController pushViewController:lcvc animated:YES];
    }
}

- (void)clickPush:(id)sender{
    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
        if([((UITapGestureRecognizer *)sender).view isKindOfClass:[UIView class]]){
            NSInteger index = ((UIView *)((UITapGestureRecognizer *)sender).view).tag - 100;
            NSLog(@"%d", index);
        }
    }else if([sender isKindOfClass:[UIButton class]]){
        NSInteger index = ((UIButton *)sender).tag - 100;
        NSLog(@"%d", index);
    }
}

#pragma mark - 系统自带
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
