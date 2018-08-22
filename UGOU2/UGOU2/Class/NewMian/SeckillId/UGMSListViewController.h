//
//  UGMSListViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/15.
//

#import <UIKit/UIKit.h>

@interface UGMSListViewController : UIViewController
@property(nonatomic,strong)NSNumber *brandID;

/**
 1 代表秒杀  2代表拍卖
 */
@property(nonatomic,assign)NSInteger flag;
@end
