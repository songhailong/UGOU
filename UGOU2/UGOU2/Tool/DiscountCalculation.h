//
//  DiscountCalculation.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 16/11/16.
//
//

#import <Foundation/Foundation.h>
#import "ZheKouModel.h"
@interface DiscountCalculation : NSObject
/*
     满件折扣(满多少件减多少钱)
     modelArr :非vip商品
     VipArr  ; vip 商品
   OrderDiscountDic：非vip商品折扣
    VIPDiscountDic ：vip商品折扣
*/
+(id)fullDiscountCalculationOrderData:(NSMutableArray *)modelArr VipData :(NSMutableArray *)VipArr  OrderDiscountDic:(NSDictionary *)OrderDiscountDic  VIPDiscountDic:(NSDictionary *) VIPDiscountDic pageFlag:(NSInteger)flag;
/*
 满件折扣(满多少钱打多少折)
 modelArr :非vip商品
 VipArr  ; vip 商品
 OrderDiscountDic：非vip商品折扣
 VIPDiscountDic ：vip商品折扣
 */

+(id)fullCountZheKouOrderArray:(NSMutableArray *)oredrerArr VipArr:(NSMutableArray *)VipArr orderZhekouDic:(NSDictionary *)orderZheKouDic vipZheKouDic:(NSDictionary *)vipZheKouDic money:(NSArray *)money;

@end
