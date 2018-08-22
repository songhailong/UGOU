//
//  FMDBSingleTon.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/19.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartModel.h"
@interface FMDBSingleTon : NSObject
+(FMDBSingleTon *)shareSinglotn;
-(void)addshop:(CartModel *)model;
-(NSArray *)selectshop;
@end
