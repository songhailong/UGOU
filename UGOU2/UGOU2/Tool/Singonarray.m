//
//  Singonarray.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "Singonarray.h"

@implementation Singonarray
+(Singonarray *)shareSinglogon{
    static Singonarray *singleTon;
    @synchronized(self) {
        if (singleTon==nil) {
            singleTon=[[Singonarray alloc] init];
            
        }
    }
    return singleTon;


}
@end
