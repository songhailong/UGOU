//
//  UGMSGoodModel.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/15.
//

#import "UGMSGoodModel.h"

@implementation UGMSGoodModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
+(instancetype)initwithdic:(NSDictionary *)dic{
    UGMSGoodModel *model=[[UGMSGoodModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
