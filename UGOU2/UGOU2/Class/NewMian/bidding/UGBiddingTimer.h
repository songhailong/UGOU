//
//  UGBiddingTimer.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import <Foundation/Foundation.h>
@protocol UGBiddingTimerDlegate<NSObject>
-(void)BinddingGetBestHeightPriceObjiect:(id)object;
@end
@interface UGBiddingTimer : NSObject
@property(nonatomic,weak)id<UGBiddingTimerDlegate>delegate;

@property (nonatomic ,strong)dispatch_source_t timer;
@property(nonatomic,strong)NSNumber *seckillIds;
@end
