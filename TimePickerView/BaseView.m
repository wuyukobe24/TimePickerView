//
//  BaseView.m
//  VCHelper
//
//  Created by WangXueqi on 16/12/10.
//  Copyright © 2016年 JingBei. All rights reserved.
//

#import "BaseView.h"
@implementation BaseView

-(UIImageView *)setImageViewBox:(UIImageView *)ImageView
                       andFrame:(CGRect)frame
                    andImageStr:(NSString *)imageStr
{
    ImageView = [[UIImageView alloc]initWithFrame:frame];
    ImageView.image = [UIImage imageNamed:imageStr];
    return ImageView;
    
}

-(UILabel *)addSubLabel:(UILabel*)label
              andFrame:(CGRect)frame
          andAlignment:(NSTextAlignment)textAlignment
           andTextFont:(NSInteger)Font andColor:(UIColor*)color
               andText:(NSString*)text
{
    
    label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:Font];
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
    
}

-(CALayer *)addSubLayer:(CALayer *)layer
               andFrame:(CGRect)frame
     andBackgroundColor:(UIColor *)color
            andBackView:(UIView *)baseView{
    
    layer = [[CALayer alloc]init];
    layer.frame = frame;
    layer.backgroundColor = [color CGColor];
    [baseView.layer addSublayer:layer];
    return layer;
}

-(UIButton *)addButton:(UIButton *)button
              andFrame:(CGRect)frame
        andNormalImage:(NSString *)normalImage
        andSelectImage:(NSString *)selectImage
              andTitle:(NSString *)title
               andFont:(NSInteger)font
   andNormalTitleColor:(UIColor *)normalColor
   andSelectTitleColor:(UIColor *)selectColor
            andAddView:(UIView *)subView{
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    [subView addSubview:button];
    
    return button;
}

- (void)changeTextColorWithLabel:(UILabel *)label Text:(NSString *)text startRange:(NSInteger)star endRange:(NSInteger)end font:(NSInteger)font color:(UIColor *)color{

    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    
//    [AttributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:font]
//                          range:NSMakeRange(star, end)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:NSMakeRange(star, end)];
    label.attributedText= AttributedStr;
    
}

//下载会员图像
-(void)downloadUserimage:(UIImageView*)userimage
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *userimageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserHeadPortrait"];
        
        
        if (userimageData) {
            userimage.image = [UIImage imageWithData:userimageData];
        }
        else
        {
//            userimageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@",k_server_base,PE.Icon_imageUrl]]];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:userimageData forKey:@"UserHeadPortrait"];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            userimage.image = [UIImage imageWithData:userimageData];
            
        });
        
    });
    
}


//调整标题行间距
-(CGSize )getLabelTextSelfAdaptionWithLabel:(UILabel *)label
                                  withTitle:(NSString *)title
                               withLineHigh:(NSInteger)lineHigh
                              withTitleFont:(CGFloat)font
                             withTitleWidth:(CGFloat)width{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineHigh];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    
    label.attributedText = attributedString;
    
    
    CGSize labSize = [title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    
    [label sizeToFit];
    
    CGSize labelSize = [label sizeThatFits:labSize];
    
    return labelSize;
}

//获取今天时间的字符串
-(NSString *)getFullStringTodayFromDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:date];
}

//获取某一天的date
-(NSDate *)getOnedayDateFromString:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    return date;
    
}

//获取标准的某天时间格式
-(NSString *)getStandardDateStringFromOtherString:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    return [formatter stringFromDate:date];
}

//获取今天时间的年和月字符串
-(NSString *)getStringTodayFromDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    return [formatter stringFromDate:date];
}

//获取某一天是周几
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//根据周几获取对应的index
-(NSInteger)getIndexNumWithWeekdayString:(NSString *)weekdayStr{

    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", nil];
    
    NSInteger  indexNum = 0;
    
    for (int i=0; i<weekdays.count; i++) {
        if ([weekdayStr isEqualToString:weekdays[i]]) {
            indexNum = i;
        }
    }
    
    return indexNum-1;
    
}

//获取某一天的昨天的日期
-(NSDate *)getYesterdayDay:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    
    return yesterday;
}

//获取某一天的day
-(NSString *)getOnedayFromString:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
    
}

//获取某一天的年和月
-(NSString *)getYearAndMonthFromString:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    return [formatter stringFromDate:date];
    
}

//获取某一天的时间
-(NSString *)getSelectdayDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:date];
}

//获取某一天的七天后的日期
-(NSDate *)getDayAfterSevenDay:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:7*60 * 60 * 24 sinceDate:date];
    
    return tomorrow;
}

//获取某一天的七天前的日期
-(NSDate *)getDayBeforeSevenDay:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *yesterday = [NSDate dateWithTimeInterval:-7*60 * 60 * 24 sinceDate:date];
    
    return yesterday;
}

//获取某一天所在的周数据（周一和周日）
- (NSArray *)getWeekDateInOneDay:(NSDate *)selectDate{
    
    double interval = 0;
    NSDate * beginDate = nil;
    NSDate * endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&beginDate interval:&interval forDate:selectDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-2];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //获取一周每一天
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i<7; i++) {
        NSDate *dayDate = [NSDate dateWithTimeInterval:i*60 * 60 * 24 sinceDate:beginDate];
        [myDateFormatter setDateFormat:@"dd"];
        NSString * dayStr = [myDateFormatter stringFromDate:dayDate];
        [array addObject:[NSString stringWithFormat:@"%d",[dayStr intValue]]];
    }
    
    NSMutableArray * weekArray = [NSMutableArray array];
    
    for (int i = 0; i<7; i++) {
        NSDate *dayDate = [NSDate dateWithTimeInterval:i*60 * 60 * 24 sinceDate:beginDate];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString * dayStr = [myDateFormatter stringFromDate:dayDate];
        [weekArray addObject:dayStr];
    }
    
    return weekArray;
}

//获取某天之前或之后几个月的当天时间
- (NSString *)getMonthDateFromSelectDate:(NSString *)dateStr withMonth:(int)month
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[formatter dateFromString:dateStr] options:0];
    
    return [formatter stringFromDate:mDate];
    
}

//获取某天所在月的第一天
- (NSString *)getFirstDayInMonthFromSelectDate:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    return [[formatter stringFromDate:date] stringByAppendingString:@"-01"];
}

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

//默认周一开始
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
//某个月总共多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}



//上一个月
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//下一个月
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//获取某一天的明天的日期
-(NSDate *)getTomorrowdayDay:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *yesterday = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    
    return yesterday;
}

//获取某一天的date
-(NSDate *)getLocalNotificationDateFromString:(NSString *)dateStr
                                     withHour:(NSString *)hourStr
                                   withMinute:(NSString *)minStr
{
    
    NSString * wholeDate = [NSString stringWithFormat:@"%@ %@:%@:00",dateStr,hourStr,minStr];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date =  [formatter dateFromString:wholeDate];
    
    return date;
}

-(UIActivityIndicatorView*)getActivityIndicatorViewInChildView
{
    
   UIActivityIndicatorView * activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = self.center;
    return activityIndicatorView;
}


@end
