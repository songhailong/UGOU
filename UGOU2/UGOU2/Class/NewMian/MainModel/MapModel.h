//
//  MapModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/4/11.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface MapModel : NSObject
@property(nonatomic,strong)NSString *logopicUrl;
@property(nonatomic,strong)NSString *shopName;
//@property(nonatomic,strong)NSString *shopTele;
@property(nonatomic,strong)NSString *shopAddr;
@property(nonatomic,strong)NSString *businessHours;
@property(nonatomic,strong)NSString *showpic;
//  纬度
@property(nonatomic,strong)NSNumber*latitude;
//经度
@property(nonatomic,strong)NSNumber *longitude ;
@property(nonatomic,strong)NSString *shopTele;
@property(nonatomic,strong)NSNumber *flag;
@property(nonatomic,strong)NSNumber  * id;
@property(nonatomic,strong)NSNumber *  appbrandId;
@property(nonatomic,assign) CLLocationDistance distance;
+(MapModel *)initWithModeldic:(NSDictionary *)dic;

@end
