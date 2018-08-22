//
//  DiscountModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/9/22.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountModel : NSObject
@property(nonatomic,copy)NSString *money;
@property(nonatomic,strong)NSNumber *count;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *brandId;
@property(nonatomic,strong)NSNumber *discount;
@property(nonatomic,assign)BOOL vipFlag;
+(instancetype)initWithdictomodel:(NSDictionary *)dic;

@end
