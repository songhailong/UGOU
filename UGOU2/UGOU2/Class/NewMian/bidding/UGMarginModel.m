//
//  UGMarginModel.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/26.
//

#import "UGMarginModel.h"

@implementation UGMarginModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(UGMarginModel*)initModelWithDic:(NSDictionary *)dic{
    UGMarginModel *model=[[UGMarginModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
