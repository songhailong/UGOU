//
//  CouponsViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 16/11/23.
//
//

#import <UIKit/UIKit.h>

@protocol OrderPriceDeleget <NSObject>


-(void)selectCouponsId:(NSNumber *)couponsId;

@end

@interface CouponsViewController : UIViewController
//判断是那个界面跳转过来的

//@property(nonatomic,assign)int flagss;
@property(nonatomic,assign)NSInteger money;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,strong)NSNumber* brandid;
@property(nonatomic,strong)NSArray *arrids;
@property(nonatomic,assign)NSInteger buttonpage;
@property(nonatomic,assign)NSInteger buttag;
@property(nonatomic,assign)NSMutableArray *selectarray;
@property(nonatomic,weak)NSMutableArray *couponsarr;
//@property(nonatomic,copy)MyBlockType mysblock;
@property(nonatomic,assign)id <OrderPriceDeleget>orderdeleget;
@property(nonatomic,copy)void(^mysblock)(int text);

@property(nonatomic,copy)void(^ablock)(NSInteger value);
@end
