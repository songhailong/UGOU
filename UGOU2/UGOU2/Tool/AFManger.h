//
//  AFManger.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/2.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFManger : NSObject
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
+ (void)getWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
+ (void)headerFilePostWithURLString:(NSString *)URLString
                         parameters:(id)parameters Hearfile:(id)Hearfile
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

+(CGSize)downloadImageSizeWithURL:(id)imageURL;

@end
