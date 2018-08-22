//
//  VipModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/10/10.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipModel : NSObject
@property(nonatomic,strong)NSString *brandName;
@property(nonatomic,strong)NSString *details;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *type;
+(VipModel *)initWithVipModeldic:(NSDictionary *)dic;
@end
