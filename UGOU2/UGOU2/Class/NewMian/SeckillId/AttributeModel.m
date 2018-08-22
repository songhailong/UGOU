//
//  AttributeModel.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/16.
//

#import "AttributeModel.h"

@implementation AttributeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
+(instancetype)initAttributeModelwithdic:(NSDictionary *)dic{
    AttributeModel *model=[[AttributeModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
