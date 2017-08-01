//
//  TimePickerView.h
//  VCHelper
//
//  Created by WangXueqi on 17/6/23.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "BaseView.h"

@interface TimePickerView : BaseView
@property(nonatomic,strong)NSDictionary * startDateDict;//开始时间
@property(nonatomic,copy)void(^SelectAllDateBlcok)(NSDictionary * dateDict);

- (void)creatPickerView;
@end
