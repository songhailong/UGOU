//
//  BrandModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
+(instancetype)initWithModel:(NSDictionary *)dic{
    BrandModel *model=[[BrandModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
