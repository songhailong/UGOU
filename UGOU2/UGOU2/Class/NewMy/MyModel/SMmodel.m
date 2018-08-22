//
//  SMmodel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/1.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "SMmodel.h"

@implementation SMmodel
+(SMmodel *)initModelWithdic:(NSDictionary *)dic{
    SMmodel *model=[[SMmodel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
  
    return model;

}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
