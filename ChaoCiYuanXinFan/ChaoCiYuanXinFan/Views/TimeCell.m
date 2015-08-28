//
//  TimeCell.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "TimeCell.h"
#import "UIImageView+WebCache.h"
#import "TimeModel.h"
#import "TimeView.h"
#import "MyUtil.h"

@implementation TimeCell

- (void)setWeek:(NSInteger)week{
    _week = week;
    
    for(UIView *view in self.contentView.subviews){
        [view removeFromSuperview];
    }
    
    UIImageView *dayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
    if(week == [MyUtil getWeekDay]){
        switch (week) {
            case 0:
                dayImageView.image = [UIImage imageNamed:@"mon"];
                break;
            case 1:
                dayImageView.image = [UIImage imageNamed:@"tue"];
                break;
            case 2:
                dayImageView.image = [UIImage imageNamed:@"wed"];
                break;
            case 3:
                dayImageView.image = [UIImage imageNamed:@"thu"];
                break;
            case 4:
                dayImageView.image = [UIImage imageNamed:@"fri"];
                break;
            case 5:
                dayImageView.image = [UIImage imageNamed:@"sat"];
                break;
            case 6:
                dayImageView.image = [UIImage imageNamed:@"sun"];
                break;
            default:
                break;
        }
    }else{
        switch (week) {
            case 0:
                dayImageView.image = [UIImage imageNamed:@"mon2"];
                break;
            case 1:
                dayImageView.image = [UIImage imageNamed:@"tue2"];
                break;
            case 2:
                dayImageView.image = [UIImage imageNamed:@"wed2"];
                break;
            case 3:
                dayImageView.image = [UIImage imageNamed:@"thu2"];
                break;
            case 4:
                dayImageView.image = [UIImage imageNamed:@"fri2"];
                break;
            case 5:
                dayImageView.image = [UIImage imageNamed:@"sat2"];
                break;
            case 6:
                dayImageView.image = [UIImage imageNamed:@"sun2"];
                break;
            default:
                break;
        }
    }
    [self.contentView addSubview:dayImageView];
    
    for(NSInteger i = 0; i < _array.count; i++){
        TimeModel *model = _array[i];
        
        NSInteger row = i / 4;
        NSInteger col = i % 4;
        
        TimeView *timeView = [[TimeView alloc] initWithFrame:CGRectMake(45+((ScreenWidth-85)/4+10)*col, 100*row, (ScreenWidth-85)/4, 90)];
        timeView.tag = 500 + i;
        [self.contentView addSubview:timeView];
        
        [timeView.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.image]
                                    placeholderImage:[UIImage imageNamed:@"tcimg"]];
        timeView.nameLabel.text = model.name;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTimeView:)];
        [timeView addGestureRecognizer:tap];
    }
}

- (void)clickTimeView:(UITapGestureRecognizer *)gr{
    TimeView *timeView = (TimeView *)gr.view;
    TimeModel *model = _array[timeView.tag-500];
    NSLog(@"%@", model.name);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
