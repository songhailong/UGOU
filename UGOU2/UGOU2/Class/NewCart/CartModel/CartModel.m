//
//  CartModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
+(instancetype)initwithdic:(NSDictionary *)dic{
    CartModel *model=[[CartModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.brandName forKey:@"brandName"];
    [aCoder encodeObject:self.logopic forKey:@"logopic"];
    [aCoder encodeObject:self.goodsName forKey:@"goodsName"];
    [aCoder encodeObject:self.logopicUrl forKey:@"logopicUrl"];
    [aCoder encodeObject:self.goodsPrice forKey:@"goodsPrice"];
    [aCoder encodeObject:self.promotionPrice forKey:@"promotionPrice"];
    [aCoder encodeObject:self.attribute forKey:@"attribute"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.money forKey:@"money"];
    [aCoder encodeObject:self.orderNo forKey:@"orderNo"];
    [aCoder encodeObject:self.flag forKey:@"flag"];
    [aCoder encodeInteger:self.quantity forKey:@"quantity"];
    [aCoder encodeObject:self.appStoresId forKey:@"appStoresId"];
    [aCoder encodeInteger:self.customerFlag forKey:@"customerFlag"];
    [aCoder encodeObject:self.customerStartTime forKey:@"customerStartTime"];
    [aCoder encodeObject:self.customerProblem forKey:@"customerProblem"];
    [aCoder encodeObject:self.customerReTime forKey:@"customerReTime"];
    [aCoder encodeObject:self.customerCenterTime forKey:@"customerCenterTime"];
    [aCoder encodeObject:self.customerEndTime forKey:@"customerEndTime"];
    [aCoder encodeObject:self.cardgoodid forKey:@"cardgoodid"];
    [aCoder encodeObject:self.vipPrice forKey:@"vipPrice"];
    [aCoder encodeBool:self.vipFlag forKey:@"vipFlag"];
    //[aCoder encodeBool:self.vipFlag  forKey:@"vipFlag"];
    
    [aCoder encodeBool:self.editing forKey:@"editing"];
    [aCoder encodeObject:self.saleCount forKey:@"saleCount"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
       self=[super init];
    if (self) {
        self.brandName=[aDecoder decodeObjectForKey:@"brandName"];
        self.logopic=[aDecoder decodeObjectForKey:@"logopic"];
        self.goodsName=[aDecoder decodeObjectForKey:@"goodsName"];
        self.logopicUrl=[aDecoder decodeObjectForKey:@"logopicUrl"];
        self.goodsPrice=[aDecoder decodeObjectForKey:@"goodsPrice"];
        self.promotionPrice=[aDecoder decodeObjectForKey:@"promotionPrice"];
        self.attribute=[aDecoder decodeObjectForKey:@"attribute"];
        self.id=[aDecoder decodeObjectForKey:@"id"];
        self.money=[aDecoder decodeObjectForKey:@"money"];
        self.orderNo=[aDecoder decodeObjectForKey:@"orderNo"];
        self.flag=[aDecoder decodeObjectForKey:@"flag"];
        self.quantity=[aDecoder decodeIntegerForKey:@"quantity"];
        self.appStoresId=[aDecoder decodeObjectForKey:@"appStoresId"];
        self.customerFlag=[aDecoder decodeIntForKey:@"customerFlag"];
        self.customerStartTime=[aDecoder decodeObjectForKey:@"customerStartTime"];
        self.customerProblem=[aDecoder decodeObjectForKey:@"customerProblem"];
        self.customerReTime=[aDecoder decodeObjectForKey:@"customerReTime"];
        self.customerCenterTime=[aDecoder decodeObjectForKey:@"customerCenterTime"];
        self.customerEndTime=[aDecoder decodeObjectForKey:@"customerEndTime"];
        self.cardgoodid=[aDecoder decodeObjectForKey:@"cardgoodid"];
        self.vipPrice=[aDecoder decodeObjectForKey:@"vipPrice"];
        //self.vipFlag=[aDecoder decodeObjectForKey:@"vipFlag"];
        self.vipFlag=[aDecoder decodeBoolForKey:@"vipFlag"];
        self.editing=[aDecoder decodeBoolForKey:@"editing"];
        self.saleCount=[aDecoder decodeObjectForKey:@"saleCount"];
    }
    return self;
}
@end
