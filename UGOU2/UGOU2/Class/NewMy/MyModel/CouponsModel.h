//
//  CouponsModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/1.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponsModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *brandName;
@property(nonatomic,strong)NSNumber *days;
@property(nonatomic,strong)NSNumber * flag;
@property(nonatomic,strong)NSNumber * preid;
@property(nonatomic,strong)NSNumber *  money01 ;
@property(nonatomic,strong)NSNumber *  money02 ;
@property(nonatomic,strong)NSNumber *  come ;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong)NSNumber * validity;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,copy)NSString *regulation;
@property(nonatomic,copy)NSString *buttag;
@property(nonatomic,copy)NSNumber *brandids;
@property(nonatomic,strong)NSNumber *money;
@property(nonatomic,strong)NSNumber *userVoucherId;

/**
 优惠券图片
 */
@property(nonatomic,strong)NSString *banner;

@property(nonatomic,strong)NSString *img ;
@property(nonatomic,strong)NSString *imgUrl;
@property(nonatomic,strong)NSString *intro;
@property(nonatomic,strong)NSString *title;

@property(nonatomic,assign)BOOL receiveFlag;
+(instancetype)initWithModeldic:(NSDictionary *)dic;
@end
