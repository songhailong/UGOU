//
//  CategoryModel.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/7.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property(nonatomic,copy)NSString*name;
@property(nonatomic,strong)NSNumber *id ;
+(CategoryModel *)initwithModel:(NSDictionary *)dic;
@end
