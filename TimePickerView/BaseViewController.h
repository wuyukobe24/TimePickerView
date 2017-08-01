//
//  BaseViewController.h
//  TimePickerView
//
//  Created by WangXueqi on 17/8/1.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//获取某一天的小时
-(NSString *)getTodayHourStringFromDate:(NSDate *)date;

//获取某一天的分钟
-(NSString *)getTodayMinuteStringFromDate:(NSDate *)date;

//获取某一天的年月和周几
-(NSString *)getFullDateStringFromString:(NSString *)dateStr;

//获取某一天是周几
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

//获取某一天的day
-(NSString *)getOnedayFromString:(NSDate *)date;

//获取某一天的date
-(NSDate *)getOnedayDateFromString:(NSString *)dateStr;

//获取某一天的明天的日期
-(NSDate *)getTomorrowdayDay:(NSDate*)date;

//获取某一天的时间
-(NSString *)getSelectdayDate:(NSDate *)date;


@end
