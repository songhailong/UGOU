//
//  ThemeModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/21.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{};
+(ThemeModel *)initWithModeldic:(NSDictionary *)dic{
    ThemeModel *model=[[ThemeModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
