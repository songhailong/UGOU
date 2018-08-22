//
//  UGofferViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import <UIKit/UIKit.h>
static  NSString * const fullScreenbiddingNotice =@"fullScreenbiddingNotice";
@interface UGofferViewController : UIViewController
/**
竞拍加价
*/
@property(nonatomic,strong)NSNumber *offerPrice;

/**
 最低价
 */
@property(nonatomic,assign)CGFloat lowPrice;

/**
 商品id
 */
@property(nonatomic,strong)NSNumber *auctionId;
@end
