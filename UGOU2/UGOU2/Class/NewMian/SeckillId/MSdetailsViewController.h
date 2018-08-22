//
//  MSdetailsViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/14.
//

#import <UIKit/UIKit.h>
@class CountdownVidew;
@interface MSdetailsViewController : UIViewController
@property(nonatomic,strong)NSString* _Nullable goodsId;
@property(nonatomic,retain)NSDictionary * _Nullable dictionary;
@property(nonatomic,retain)NSString * _Nullable string;
@property(nonatomic,strong)NSNumber * _Nullable storeId;

@property(nonatomic,strong)CountdownVidew * _Nullable countview;
@property(nonatomic,assign)long time;

/**
 秒杀商品id
 */
@property(nonatomic,strong,nonnull)NSNumber *seckillId;
@end
