//
//  GroupCell.h
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"

@interface GroupCell : UICollectionViewCell

@property (nonatomic, strong) GroupModel *model;

- (void)setBlankCell;

@end
