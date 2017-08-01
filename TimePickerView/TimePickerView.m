//
//  TimePickerView.m
//  VCHelper
//
//  Created by WangXueqi on 17/6/23.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "TimePickerView.h"
#import "SelectDateModel.h"

#define K_ScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])// 当前屏幕宽
#define K_ScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds])// 当前屏幕高
@interface TimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView * datePickView;
@property(nonatomic,strong)NSMutableArray * dateArray;//带有今天明天昨天
@property(nonatomic,strong)NSMutableArray * dateFullArray;//MM年dd月 周几
@property(nonatomic,strong)NSMutableArray * dateNormalArray;//yyyy-MM-dd
@property(nonatomic,strong)NSMutableArray * hourArray;
@property(nonatomic,strong)NSMutableArray * minuteArray;

@property(nonatomic,strong)NSMutableDictionary * dateDict;//选好之后所有数据
@end
@implementation TimePickerView
{
    UIView * baseView;
    UILabel * remindSetLabel;//设置时间
    
    NSInteger numDate;
    NSInteger numHour;
    NSInteger numMinute;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)creatPickerView {

    [self allocInitData];
    [self creatSubView];
    [self creatPickView];
    [self creatBottomView];
}

- (void)allocInitData {
    
    //小时
    for (int j=0; j<24; j++) {
        [self.hourArray addObject:[NSString stringWithFormat:@"%02d",j]];
    }
    
    //分钟
    for (int k=0; k<60; k=k+15) {
        [self.minuteArray addObject:[NSString stringWithFormat:@"%02d",k]];
    }
    
    //获取180天之前的数据
    NSDate * firstDate = [self getTheDayDate:[NSDate date] IsLater:NO andDays:180];
    
    //获取上半年和下半年的数据
    for (int i = 0; i<365; i++) {
        
        if (i == 179) {
            [self.dateArray addObject:@"昨天"];
        }else if (i == 180){
            [self.dateArray addObject:@"今天"];
        }else if (i == 181){
            [self.dateArray addObject:@"明天"];
        }else{
            
            NSString * dateString = [NSString stringWithFormat:@"%@ %@",[self getStringdayFromDate:[self getTheDayDate:firstDate IsLater:YES andDays:i] isNormal:NO], [self weekdayStringFromDate:[self getTheDayDate:firstDate IsLater:YES andDays:i]]];
            [self.dateArray addObject:dateString];
        }
        
        NSString * dateFullString = [NSString stringWithFormat:@"%@ %@",[self getStringdayFromDate:[self getTheDayDate:firstDate IsLater:YES andDays:i] isNormal:NO], [self weekdayStringFromDate:[self getTheDayDate:firstDate IsLater:YES andDays:i]]];
        [self.dateFullArray addObject:dateFullString];
        
        NSString * dateNormalString = [NSString stringWithFormat:@"%@",[self getStringdayFromDate:[self getTheDayDate:firstDate IsLater:YES andDays:i] isNormal:YES]];
        [self.dateNormalArray addObject:dateNormalString];
    }
}

- (void)creatSubView {
    
    baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_ScreenWidth, 280)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    
    remindSetLabel = [self addSubLabel:remindSetLabel andFrame:CGRectMake(20, 0, K_ScreenWidth, 60) andAlignment:NSTextAlignmentLeft andTextFont:17 andColor:[UIColor blackColor] andText:@""];
    [baseView addSubview:remindSetLabel];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, K_ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:lineView];
    
}

- (void)creatPickView {
    
    _datePickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 60, K_ScreenWidth, 160)];
    _datePickView.delegate = self;
    _datePickView.dataSource = self;
    [baseView addSubview:_datePickView];
    
    SelectDateModel * model = [[SelectDateModel alloc]init];
    [model getDateFromDict:_startDateDict];
    remindSetLabel.text = @"设置时间";
    
    //有日期点进来
    for (int m=0; m<self.dateNormalArray.count; m++) {
        
        NSString * oneStr = [NSString stringWithFormat:@"%@",self.dateNormalArray[m]];
        NSString * twoStr = [NSString stringWithFormat:@"%@",model.dateNormal];
        if ([oneStr isEqualToString:twoStr]) {
            numDate = m;
        }
    }
    
    //获取当前小时
    numHour = [model.hour intValue];
    
    //获取当前分钟数
    NSInteger dateNum = [model.minute intValue];
    if (dateNum%15 == 0) {
        numMinute = dateNum/15;
    }else{
        numMinute = dateNum/15+1;
    }
    
    if (numMinute >= 4) {
        
        numMinute = 0;
        
        if (numHour>=23) {
            numHour = 0;
            numDate ++;
        }else{
            numHour += 1;
        }
        
    }else{
        
        numMinute = dateNum/15;
    }
    
    [_datePickView selectRow:numDate inComponent:0 animated:YES];
    [_datePickView selectRow:numHour inComponent:1 animated:YES];
    [_datePickView selectRow:numMinute inComponent:2 animated:YES];
}

//取消和确定
- (void)creatBottomView {
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 220, K_ScreenWidth, 60)];
    [baseView addSubview:bottomView];
    
    UIButton * cancelButton, * achieveButton;
    CALayer * topLayer, * midLayer;
    
    cancelButton = [self addButton:cancelButton andFrame:CGRectMake(0, 0, K_ScreenWidth/2, 60) andNormalImage:nil andSelectImage:nil andTitle:@"取消" andFont:17 andNormalTitleColor:[UIColor blackColor] andSelectTitleColor:nil andAddView:bottomView];
    
    achieveButton = [self addButton:achieveButton andFrame:CGRectMake(K_ScreenWidth/2, 0, K_ScreenWidth/2, 60) andNormalImage:nil andSelectImage:nil andTitle:@"确定" andFont:17 andNormalTitleColor:[UIColor blackColor] andSelectTitleColor:nil andAddView:bottomView];
    
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [achieveButton addTarget:self action:@selector(achieveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    topLayer = [self addSubLayer:topLayer andFrame:CGRectMake(0, 0, K_ScreenWidth, 1) andBackgroundColor:[UIColor lightGrayColor] andBackView:bottomView];
    midLayer = [self addSubLayer:midLayer andFrame:CGRectMake(K_ScreenWidth/2-0.5, 0, 1, 60) andBackgroundColor:[UIColor lightGrayColor] andBackView:bottomView];
    
}

//取消
- (void)cancelButtonClick {
    
    if (_SelectAllDateBlcok) {
        _SelectAllDateBlcok(nil);
    }
}

//确定
- (void)achieveButtonClick {
    
    [self.dateDict setObject:self.dateFullArray[numDate] forKey:@"FullDate"];
    [self.dateDict setObject:self.dateNormalArray[numDate] forKey:@"NormalDate"];
    [self.dateDict setObject:self.hourArray[numHour] forKey:@"Hour"];
    [self.dateDict setObject:self.minuteArray[numMinute] forKey:@"Minute"];
    
    if (_SelectAllDateBlcok) {
        _SelectAllDateBlcok(self.dateDict);
    }
 
}

- (NSMutableDictionary *)dateDict {

    if (!_dateDict) {
        _dateDict = [NSMutableDictionary dictionary];
    }
    return _dateDict;
}

- (NSMutableArray *)dateArray {

    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (NSMutableArray *)dateFullArray {
    
    if (!_dateFullArray) {
        _dateFullArray = [NSMutableArray array];
    }
    return _dateFullArray;
}

- (NSMutableArray *)dateNormalArray {
    
    if (!_dateNormalArray) {
        _dateNormalArray = [NSMutableArray array];
    }
    return _dateNormalArray;
}

- (NSMutableArray *)hourArray {
    
    if (!_hourArray) {
        _hourArray = [NSMutableArray array];
    }
    return _hourArray;
}

- (NSMutableArray *)minuteArray {
    
    if (!_minuteArray) {
        _minuteArray = [NSMutableArray array];
    }
    return _minuteArray;
}

- (NSMutableDictionary *)getDateDictFromDate:(NSString *)dateStr Hour:(NSString *)Hour Minute:(NSString *)Minute {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[self getFullDateStringFromString:dateStr] forKey:@"FullDate"];
    [dict setObject:dateStr forKey:@"NormalDate"];
    [dict setObject:Hour forKey:@"Hour"];
    [dict setObject:Minute forKey:@"Minute"];
    
    return dict;
}

#pragma mark - pickView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.dateArray.count;
        
    }else if (component == 1){
        
        return self.hourArray.count;
        
    }else
        
        return self.minuteArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel * showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (K_ScreenWidth-30)/2, 80)];
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0) {
        
        showLabel.text = self.dateArray[row];
        if (row == numDate) {
            showLabel.textColor = [UIColor blueColor];
        }
        
    }else if (component == 1){
        
        showLabel.text = self.hourArray[row];
        if (row == numHour) {
            showLabel.textColor = [UIColor blueColor];
        }
        
    }else{
        
        showLabel.text = self.minuteArray[row];
        if (row == numMinute) {
            showLabel.textColor = [UIColor blueColor];
        }
        
    }
    return showLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        numDate = row;
    }else if (component == 1){
        numHour = row;
    }else if (component == 2){
        numMinute = row;
    }
    
    [_datePickView reloadAllComponents];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
        return (K_ScreenWidth-30)/2;
    }else  return K_ScreenWidth/6;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 33;
}



#pragma  mark - date
//获取某一天的日期
-(NSDate *)getTheDayDate:(NSDate*)date IsLater:(BOOL) isLater andDays:(NSInteger)num{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSDate *returnDate;
    
    if (isLater) {
        returnDate = [NSDate dateWithTimeInterval:num*60 * 60 * 24 sinceDate:date];
    }else{
        returnDate = [NSDate dateWithTimeInterval:-num*60 * 60 * 24 sinceDate:date];
    }
    
    return returnDate;
}

//获取某一天的时间
-(NSString *)getStringdayFromDate:(NSDate *)date isNormal:(BOOL)isNormal{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (isNormal) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else{
        [formatter setDateFormat:@"MM月dd日"];
    }
    
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


@end
