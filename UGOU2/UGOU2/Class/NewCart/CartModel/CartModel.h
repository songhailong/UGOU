//
//  CartModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartModel : NSObject<NSCoding>
//品牌名称
@property(nonatomic,copy)NSString *brandName ;
//品牌 id
@property(nonatomic,strong)NSNumber *brandid;
@property(nonatomic,copy)NSString *logopic;
@property(nonatomic,copy)NSString *goodsName ;
@property(nonatomic,copy)NSString *logopicUrl ;
//原价
@property(nonatomic,strong)NSNumber * goodsPrice;
//折扣价
@property(nonatomic,strong)NSNumber * promotionPrice ;
//vip价格
@property(nonatomic,strong)NSNumber * vipPrice;
@property(nonatomic,copy)NSString * attribute ;
//商品数量
@property(nonatomic,assign)NSInteger  quantity ;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *money;
//订单号
@property(nonatomic,strong)NSNumber *orderNo;
//订单状态
@property(nonatomic,strong)NSNumber *flag;
//详情页网址
@property(nonatomic,copy)NSString *detail;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,strong)NSNumber * reTime;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,assign)NSInteger customerFlag ;
//商品id
@property(nonatomic,strong)NSNumber *goodsid;
//商品详情 图片
@property(nonatomic,copy)NSString *  goodsNewDetail;
//是否选中
@property(nonatomic,assign,getter=isediting)BOOL editing;
//优惠的价格
@property(nonatomic,strong)NSNumber *salePrice;

@property(nonatomic,copy)NSString *company;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *expressNo;
@property(nonatomic,strong)NSNumber *appStoresId;
@property(nonatomic,strong)NSNumber *saleCount;
@property(nonatomic,strong)NSNumber *cardgoodid;
@property(nonatomic,strong)NSNumber *customerStartTime;
//是否是vip 
@property(nonatomic,assign)BOOL vipFlag;
//申请退货时间
@property(nonatomic,strong)NSNumber * customerReTime;
//退货原因
@property(nonatomic,strong)NSString * customerProblem;
//收货时间
@property(nonatomic,strong)NSNumber *customerCenterTime;
//退货时间
@property(nonatomic,strong)NSNumber *customerEndTime;
+(instancetype)initwithdic:(NSDictionary *)dic;
@end
