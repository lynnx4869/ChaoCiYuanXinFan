//
//  MyUtil.m
//  ChaoCiYuanXinFan
//
//  Created by qianfeng on 15/8/21.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "MyUtil.h"

@implementation MyUtil

+ (UIButton *)createBtn:(CGRect)frame
                  image:(NSString *)imageName
              highImage:(NSString *)highImageName
               selected:(NSString *)selectedName
                 target:(id)target
                 action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    if(highImageName){
        [btn setImage:[[UIImage imageNamed:highImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    if(selectedName){
        [btn setImage:[[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    }
    
    if(target && action){
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

+ (UIColor *)getColorFromString:(NSString *)colorString{
    if([colorString isEqualToString:@""]){
        return [UIColor blackColor];
    }
    
    CGFloat num1 = [self changeFromChar:[colorString characterAtIndex:0]];
    CGFloat num2 = [self changeFromChar:[colorString characterAtIndex:1]];
    CGFloat num3 = [self changeFromChar:[colorString characterAtIndex:2]];
    CGFloat num4 = [self changeFromChar:[colorString characterAtIndex:3]];
    CGFloat num5 = [self changeFromChar:[colorString characterAtIndex:4]];
    CGFloat num6 = [self changeFromChar:[colorString characterAtIndex:5]];
    
    UIColor *color = [UIColor colorWithRed:(num1*16.0+num2)/255.0 green:(num3*16.0+num4)/255.0 blue:(num5*16.0+num6)/255.0 alpha:1.0];
    return color;
}

+ (CGFloat)changeFromChar:(unichar)c{
    switch (c) {
        case '0':
            return 0.0;
        case '1':
            return 1.0;
        case '2':
            return 2.0;
        case '3':
            return 3.0;
        case '4':
            return 4.0;
        case '5':
            return 5.0;
        case '6':
            return 6.0;
        case '7':
            return 7.0;
        case '8':
            return 8.0;
        case '9':
            return 9.0;
        case 'A':
            return 10.0;
        case 'B':
            return 11.0;
        case 'C':
            return 12.0;
        case 'D':
            return 13.0;
        case 'E':
            return 14.0;
        case 'F':
            return 15.0;
        default:
            return 0.0;
    }
}

+ (NSInteger)getWeekDay{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger week = [dateComponent weekday];
    
    week = week - 2;
    if(week == -1){
        week = 6;
    }
    
    return week;
}

@end
