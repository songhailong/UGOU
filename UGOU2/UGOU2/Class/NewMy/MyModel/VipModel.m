//
//  VipModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/10/10.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "VipModel.h"

@implementation VipModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(VipModel*)initWithVipModeldic:(NSDictionary *)dic{
    
    VipModel *model=[[VipModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;


}
@end
