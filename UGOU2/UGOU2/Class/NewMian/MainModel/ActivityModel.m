//
//  ActivityModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    

}
+(ActivityModel *)initWithModeldic:(NSDictionary *)dic{
    ActivityModel *model=[[ActivityModel alloc] init];
   
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
