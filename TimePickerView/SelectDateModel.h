//
//  SelectDateModel.h
//  VCHelper
//
//  Created by WangXueqi on 16/12/26.
//  Copyright © 2016年 JingBei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectDateModel : NSObject
@property(nonatomic,copy)NSString * dateFull;
@property(nonatomic,copy)NSString * dateNormal;
@property(nonatomic,copy)NSString * hour;
@property(nonatomic,copy)NSString * minute;

-(void)getDateFromDict:(NSDictionary *)dict;

@end



