//
//  PushModle.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/18.
//

#import "PushModle.h"

@implementation PushModle
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
+(PushModle *)initWithDic:(NSDictionary *)dic{
    PushModle *model=[[PushModle alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
