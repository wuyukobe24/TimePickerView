//
//  ViewController.m
//  TimePickerView
//
//  Created by WangXueqi on 17/8/1.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "ViewController.h"
#import "TimePickerView.h"
#import "SelectDateModel.h"

#define K_ScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])// 当前屏幕宽
#define K_ScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds])// 当前屏幕高
@interface ViewController ()
@property(nonatomic,strong)UITextField * textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"时间选择器";
    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f];
    [self addSubView];
}

- (void)addSubView {

    [self.view addSubview:self.textField];
        
    TimePickerView * time = [[TimePickerView alloc]initWithFrame:CGRectMake(0, K_ScreenHeight-280, K_ScreenWidth, 280)];
    time.startDateDict = [self gainTodayDate];
    [time creatPickerView];
    [time setSelectAllDateBlcok:^(NSDictionary * selectTime) {
        if (selectTime) {
            self.textField.text = [self remindTextWithDict:selectTime];
        }else{
            [self.textField resignFirstResponder];
        }
    }];
    
    self.textField.inputView = time;
}

- (NSString *)remindTextWithDict:(NSDictionary *)dict {

    SelectDateModel * model = [[SelectDateModel alloc]init];
    [model getDateFromDict:dict];
    NSString * remindText = [NSString stringWithFormat:@"%@ %@:%@",model.dateFull,model.hour,model.minute];
    
    return remindText;
}

- (UITextField *)textField {

    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, K_ScreenWidth-20, 40)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

- (NSMutableDictionary *)getDateDictFromDate:(NSString *)dateStr Hour:(NSString *)Hour Minute:(NSString *)Minute{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[self getFullDateStringFromString:dateStr] forKey:@"FullDate"];
    [dict setObject:dateStr forKey:@"NormalDate"];
    [dict setObject:Hour forKey:@"Hour"];
    [dict setObject:Minute forKey:@"Minute"];
    
    return dict;
}

- (NSDictionary *)gainTodayDate {

    NSString * starHourString = [self getTodayHourStringFromDate:[NSDate date]];
    NSString * starMinuteString = [self getTodayMinuteStringFromDate:[NSDate date]];
    NSString * dayStart = [self getSelectdayDate:[NSDate date]];
    NSInteger hourStart = [starHourString intValue];
    NSInteger minuteStart = ([starMinuteString intValue]/15+1)*15;
    
    if (minuteStart/15 == 4) {
        minuteStart = 0;
        hourStart++;
        
        if (hourStart > 23) {
            hourStart = hourStart-23;
            dayStart = [self getSelectdayDate:[self getTomorrowdayDay:[self getOnedayDateFromString:dayStart]]];
        }
    }
    
    NSDictionary * startDict = [self getDateDictFromDate:dayStart Hour:[NSString stringWithFormat:@"%ld",(long)hourStart] Minute:[NSString stringWithFormat:@"%.2ld",(long)minuteStart]];
    
    return startDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
