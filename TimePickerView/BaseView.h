//
//  BaseView.h
//  VCHelper
//
//  Created by WangXueqi on 16/12/10.
//  Copyright © 2016年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView


//调整标题行间距
//-(CGSize)getLabelTextSelfAdaptionWithLabel:(UILabel *)label
//                                 withTitle:(NSString *)title
//                              withLineHigh:(NSInteger)lineHigh
//                             withTitleFont:(CGFloat)font
//                            withTitleWidth:(CGFloat)width;

//-(UIImageView *)setImageViewBox:(UIImageView *)ImageView
//                       andFrame:(CGRect)frame
//                    andImageStr:(NSString *)imageStr;

-(UILabel *)addSubLabel:(UILabel *)label
               andFrame:(CGRect)frame
           andAlignment:(NSTextAlignment)textAlignment
            andTextFont:(NSInteger)Font
               andColor:(UIColor*)color
                andText:(NSString*)text;

-(CALayer *)addSubLayer:(CALayer *)layer
               andFrame:(CGRect)frame
     andBackgroundColor:(UIColor *)color
            andBackView:(UIView *)baseView;

-(UIButton *)addButton:(UIButton *)button
              andFrame:(CGRect)frame
        andNormalImage:(NSString *)normalImage
        andSelectImage:(NSString *)selectImage
              andTitle:(NSString *)title
               andFont:(NSInteger)font
   andNormalTitleColor:(UIColor *)normalColor
   andSelectTitleColor:(UIColor *)selectColor
            andAddView:(UIView *)subView;

//- (void)changeTextColorWithLabel:(UILabel *)label
//                            Text:(NSString *)text
//                      startRange:(NSInteger)star
//                        endRange:(NSInteger)end
//                            font:(NSInteger)font
//                           color:(UIColor *)color;

//获取今天时间的字符串
//-(NSString *)getFullStringTodayFromDate:(NSDate *)date;

//获取某一天的date
-(NSDate *)getOnedayDateFromString:(NSString *)dateStr;

//获取标准的某天时间格式
//-(NSString *)getStandardDateStringFromOtherString:(NSString *)dateStr;

//获取今天时间的年和月字符串
//-(NSString *)getStringTodayFromDate:(NSDate *)date;

//获取某一天是周几
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

//根据周几获取对应的index
//-(NSInteger)getIndexNumWithWeekdayString:(NSString *)weekdayStr;

//获取某一天的昨天的日期
-(NSDate *)getYesterdayDay:(NSDate*)date;

//获取某一天的day
//-(NSString *)getOnedayFromString:(NSString *)dateStr;

//获取某一天的年和月
//-(NSString *)getYearAndMonthFromString:(NSString *)dateStr;

//获取某一天的时间
//-(NSString *)getSelectdayDate:(NSDate *)date;

//获取某一天的七天后的日期
//-(NSDate *)getDayAfterSevenDay:(NSDate*)date;

//获取某一天的七天前的日期
//-(NSDate *)getDayBeforeSevenDay:(NSDate*)date;

//获取某一天所在的周数据（周一和周日）
//-(NSArray *)getWeekDateInOneDay:(NSDate *)selectDate;

//获取某天之前或之后几个月的当天时间
//- (NSString *)getMonthDateFromSelectDate:(NSString *)dateStr withMonth:(int)month;

//获取某天所在月的第一天
//- (NSString *)getFirstDayInMonthFromSelectDate:(NSString *)dateStr;

//-(NSInteger)day:(NSDate *)date;

//-(NSInteger)month:(NSDate *)date;

//-(NSInteger)year:(NSDate *)date;

//默认周一开始
//-(NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

//-(NSInteger)totaldaysInThisMonth:(NSDate *)date;
//某个月总共多少天
//- (NSInteger)totaldaysInMonth:(NSDate *)date;

//上一个月
//- (NSDate *)lastMonth:(NSDate *)date;

//下一个月
//- (NSDate*)nextMonth:(NSDate *)date;

//获取某一天的明天的日期
//-(NSDate *)getTomorrowdayDay:(NSDate*)date;

//获取某一天的date
//-(NSDate *)getLocalNotificationDateFromString:(NSString *)dateStr
//                                     withHour:(NSString *)hourStr
//                                   withMinute:(NSString *)minStr;

//- (UIActivityIndicatorView*)getActivityIndicatorViewInChildView;
@end
