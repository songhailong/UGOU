//
//  UGBiddingTimer.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import "UGBiddingTimer.h"
#import "UGHeader.h"
#import "BassAPI.h"

@implementation UGBiddingTimer
-(instancetype)init{
    self=[super init];
    if (self) {
        [self ug_creatTimer];
    }
    return self;
}
-(void)ug_creatTimer{
    
    __weak typeof(self)weakself=self;
    dispatch_queue_t queuet=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //dispatch_queue_t queuet=dispatch_get_main_queue();
    /**
       第一个参数：   DISPATCH_SOURCE_TYPE_TIMER, 表示定时器
     */
    _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queuet);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 5.0*NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
     
        [weakself ug_postNowBestHeightPrice];
    });
     dispatch_resume(_timer);
}
-(void)ug_postNowBestHeightPrice{
   
    NSString *url=[BassAPI requestUrlWithPorType:portTypeGiveTimingMessage];
    NSMutableDictionary *pamerDic=[Uikility creatSinGoMutableDictionary];
    [pamerDic setObject:self.seckillIds forKey:@"auctionId"];
    NSDictionary *postDic=[Uikility initWithdatajson:pamerDic];
    [AFManger postWithURLString:url parameters:postDic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL isSusecss=[[object objectForKey:@"success"] boolValue];
        if (isSusecss) {
            [_delegate BinddingGetBestHeightPriceObjiect:[object objectForKey:@"data"]];
            BOOL auctionEnd=[[[object objectForKey:@"data"] objectForKey:@"auctionEnd"] boolValue];
            if (auctionEnd) {
                //[[NSNotificationCenter defaultCenter] postNotificationName:SecondskillEndNotifi object:nil];
                [self ug_stopTimer];
            }
            
        }else{
            NSLog(@"%@",[object objectForKey:@"msg"]);
        }
    } failure:^(NSError *error) {

    }];
    
    
}
-(void)ug_stopTimer{
    /**
     dispatch source 并没有提供用于检测 source 本身的挂起计数的 API，也就是说外部不能得知一个 source 当前是不是挂起状态，在设计代码逻辑时需要考虑到这一点。
     dispatch_source_cancel 则是真正意义上的取消 Timer。被取消之后如果想再次执行 Timer，只能重新创建新的 Timer。这个过程类似于对 NSTimer 执行 invalidate*/
    dispatch_source_cancel(_timer);
    _timer=nil;
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
