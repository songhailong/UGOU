//
//  NSTimer+UG_BlockSupport.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/15.
//

#import "NSTimer+UG_BlockSupport.h"

@implementation NSTimer (UG_BlockSupport)
+(NSTimer *)bp_timerWithTimeInterval:(NSTimeInterval)ti
                             repeats:(BOOL)yesOrNo
                               block:(void(^)())block{
    return [self timerWithTimeInterval:ti target:self selector:@selector(bp_blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+(NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)())block{
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(bp_blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)bp_blockInvoke:(NSTimer *)timer{
    void(^block)() = timer.userInfo;
    if (block) {
        block();
    }
}


@end
