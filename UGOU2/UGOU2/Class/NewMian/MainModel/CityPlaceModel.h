//
//  CityPlaceModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/10.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityPlaceModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *id;
+(CityPlaceModel *)initWithdic:(NSDictionary *)dic;
@end
