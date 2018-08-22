//
//  ThemeModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/21.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeModel : NSObject
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *imgUrl;
@property(nonatomic,strong)NSNumber *flag;
@property(nonatomic,strong)NSNumber *brandId;
@property(nonatomic,strong)NSString *intro;
+(ThemeModel*)initWithModeldic:(NSDictionary *)dic;
@end
