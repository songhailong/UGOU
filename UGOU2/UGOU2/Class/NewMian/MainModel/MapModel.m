//
//  MapModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/4/11.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "MapModel.h"

@implementation MapModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
       
}
+(MapModel *)initWithModeldic:(NSDictionary *)dic{
    MapModel*model=[[MapModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
