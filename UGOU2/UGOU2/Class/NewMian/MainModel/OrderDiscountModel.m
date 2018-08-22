//
//  OrderDiscountModel.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 16/11/19.
//
//

#import "OrderDiscountModel.h"

@implementation OrderDiscountModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(OrderDiscountModel*)initWithKeysDic:(NSDictionary *)dic{
    OrderDiscountModel *model=[[OrderDiscountModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
