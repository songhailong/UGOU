//
//  DiscountModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/9/22.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "DiscountModel.h"

@implementation DiscountModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(instancetype)initWithdictomodel:(NSDictionary *)dic{
    DiscountModel *model=[[DiscountModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


@end
