//
//  CityPlaceModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/10.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CityPlaceModel.h"

@implementation CityPlaceModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(CityPlaceModel *)initWithdic:(NSDictionary *)dic{
    CityPlaceModel *model=[[CityPlaceModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;

}
@end
