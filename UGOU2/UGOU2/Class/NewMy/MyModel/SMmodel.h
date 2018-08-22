//
//  SMmodel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/1.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMmodel : NSObject
@property(nonatomic,copy)NSString *body;
@property(nonatomic,strong)NSNumber *flag;

@property(nonatomic,strong)NSNumber *id;

@property(nonatomic,strong)NSNumber *time;

@property(nonatomic,copy)NSString *title;
+(SMmodel *)initModelWithdic:(NSDictionary *)dic;

@end
