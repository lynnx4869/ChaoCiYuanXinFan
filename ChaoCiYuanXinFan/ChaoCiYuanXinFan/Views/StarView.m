//
//  StarView.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/25.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "StarView.h"

@implementation StarView

- (void)setStarRanking:(NSInteger)rank{
    NSInteger fullNum = rank / 2;
    NSInteger halfNum = rank % 2;
    NSInteger blankNum = (10 - rank) / 2;
    for(NSInteger i = 0; i < fullNum+halfNum+blankNum; i++){
        if(i < fullNum){
            UIImageView *fullStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*10, 0, 10, 10)];
            fullStar.image = [UIImage imageNamed:@"tjstar_full"];
            [self addSubview:fullStar];
        }else if(i < fullNum+halfNum){
            UIImageView *halfStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*10, 0, 10, 10)];
            halfStar.image = [UIImage imageNamed:@"tjhalfstar"];
            [self addSubview:halfStar];
        }else{
            UIImageView *blankStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*10, 0, 10, 10)];
            blankStar.image = [UIImage imageNamed:@"tjstar"];
            [self addSubview:blankStar];
        }
    }
    
}

@end
