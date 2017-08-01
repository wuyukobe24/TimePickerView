//
//  SelectDateModel.m
//  VCHelper
//
//  Created by WangXueqi on 16/12/26.
//  Copyright © 2016年 JingBei. All rights reserved.
//

#import "SelectDateModel.h"

@implementation SelectDateModel


-(void)getDateFromDict:(NSDictionary *)dict{

    _dateFull = dict[@"FullDate"];
    _dateNormal = dict[@"NormalDate"];
    _hour = dict[@"Hour"];
    _minute = dict[@"Minute"];

}
@end
