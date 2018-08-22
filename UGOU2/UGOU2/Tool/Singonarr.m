//
//  Singonarr.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "Singonarr.h"

@implementation Singonarr
@synthesize array;
+(Singonarr *)shareSinglogon{
    static Singonarr *singleTon;
    @synchronized(self) {
        if (singleTon==nil) {
            singleTon=[[Singonarr alloc] init];
            
        }
    }
    return singleTon;
    
    
}
@end
