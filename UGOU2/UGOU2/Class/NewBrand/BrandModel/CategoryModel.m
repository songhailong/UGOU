//
//  CategoryModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/7.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
+(CategoryModel *)initwithModel:(NSDictionary *)dic{
    CategoryModel *model=[[CategoryModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];

    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
