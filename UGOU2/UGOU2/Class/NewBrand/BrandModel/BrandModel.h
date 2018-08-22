//
//  BrandModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandModel : NSObject
@property (nonatomic,copy)NSString*goodsName;
@property (nonatomic,copy)NSString*logopicUrl;
@property (nonatomic,strong)NSNumber *   promotionPrice;
@property (nonatomic,strong)NSNumber*  originalPrice;
+(instancetype)initWithModel:(NSDictionary *)dic;
@end
