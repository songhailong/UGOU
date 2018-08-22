//
//  CustomAnnotation.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotation : MAPointAnnotation
@property(nonatomic,strong)NSNumber *longitude;
@property(nonatomic,strong)NSNumber *latitude;
@end
