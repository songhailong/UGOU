//
//  UGMSGoodModel.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/15.
//

#import <Foundation/Foundation.h>

@interface UGMSGoodModel : NSObject

@property(nonatomic,copy)NSString *brandName ;
//秒杀商品 id
@property(nonatomic,strong)NSNumber *id;
/**商品图片*/
@property(nonatomic,copy)NSString *logopicSl;
@property(nonatomic,copy)NSString *goodsName ;

@property(nonatomic,assign)NSInteger quantity;

/**
 颜色尺码id
 */
@property(nonatomic,strong)NSNumber *seUid;
/**原价*/
@property(nonatomic,strong)NSNumber * goodsPrice;
/**秒杀价*/
@property(nonatomic,strong)NSNumber * seprice ;
/**结束时间*/
@property(nonatomic,strong)NSNumber * deadline;
/**件数*/
@property(nonatomic,strong)NSNumber *total;
/**颜色尺码*/
@property(nonatomic,strong)NSString *attribute;
/**
 当前竞拍价
 */
@property(nonatomic,strong)NSNumber *maxSePrice;
+(instancetype)initwithdic:(NSDictionary *)dic;
@end
