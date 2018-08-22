//
//  OrderDiscountModel.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 16/11/19.
//
//

#import <Foundation/Foundation.h>

@interface OrderDiscountModel : NSObject
@property(nonatomic,strong)NSNumber *money01;
@property(nonatomic,strong)NSNumber *money02;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSString *regulation;
@property(nonatomic,strong)NSNumber *days;
@property(nonatomic,strong)NSNumber *validity;
@property(nonatomic,strong)NSString *brandName;
+(OrderDiscountModel *)initWithKeysDic:(NSDictionary *)dic;
@end
