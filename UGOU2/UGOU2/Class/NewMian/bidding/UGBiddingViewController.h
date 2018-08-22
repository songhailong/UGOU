//
//  UGBiddingViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import <UIKit/UIKit.h>
@class CountdownVidew;
@class UGMarginModel;
@interface UGBiddingViewController : UIViewController
@property(nonatomic,strong)NSString* _Nullable goodsId;
@property(nonatomic,retain)NSDictionary * _Nullable dictionary;
@property(nonatomic,retain)UGMarginModel * _Nullable MarginModel;
@property(nonatomic,strong)NSNumber * _Nullable maxSePrice;
@property(nonatomic,assign)long time;
@property(nonatomic,strong)CountdownVidew * _Nullable countview;
/**
 秒杀商品id
 */
@property(nonatomic,strong,nonnull)NSNumber *seckillIds;
@end
