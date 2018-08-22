//
//  NSTimer+UG_BlockSupport.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/15.
//

#import <Foundation/Foundation.h>

@interface NSTimer (UG_BlockSupport)
+(NSTimer *)bp_timerWithTimeInterval:(NSTimeInterval)ti
                             repeats:(BOOL)yesOrNo
                               block:(void(^)())block;



+(NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                      repeats:(BOOL)yesOrNo
                                        block:(void(^)())block;


@end
