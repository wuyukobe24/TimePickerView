//
//  BaseViewController.m
//  TimePickerView
//
//  Created by WangXueqi on 17/8/1.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//获取某一天的小时
-(NSString *)getTodayHourStringFromDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH"];
    
    return [formatter stringFromDate:date];
    
}

//获取某一天的分钟
-(NSString *)getTodayMinuteStringFromDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"mm"];
    
    return [formatter stringFromDate:date];
    
}

//获取某一天的年月和周几
-(NSString *)getFullDateStringFromString:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    NSString * weekStr = [self weekdayStringFromDate:date];
    
    [formatter setDateFormat:@"MM月dd日"];
    
    NSString * fullDateStr = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:date],weekStr];
    
    return fullDateStr;
    
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

//获取某一天的day
-(NSString *)getOnedayFromString:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
    
}

//获取某一天的date
-(NSDate *)getOnedayDateFromString:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date =  [formatter dateFromString:dateStr];
    
    return date;
    
}

//获取某一天的明天的日期
-(NSDate *)getTomorrowdayDay:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *yesterday = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    
    return yesterday;
}

//获取某一天的时间
-(NSString *)getSelectdayDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
