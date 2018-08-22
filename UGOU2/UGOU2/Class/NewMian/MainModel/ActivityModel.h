//
//  ActivityModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *logopicUrl;
@property(nonatomic,strong)NSNumber *barCode;
@property(nonatomic,strong)NSNumber *promotionPrice;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *saleCount;
@property(nonatomic,copy)NSMutableString *brannerColor;
@property(nonatomic,copy)NSString *brannerFont;
@property(nonatomic,copy)NSString *images;
@property(nonatomic,strong)NSNumber *reTime ;

+(ActivityModel *)initWithModeldic:(NSDictionary *)dic;
@end
