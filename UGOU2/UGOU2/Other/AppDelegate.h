//
//  AppDelegate.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WeibologinDelegate<NSObject>
-(void)getAccessToken: (NSString *)accseeToken withUserId:(NSString *)userId;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabbar;
@property (retain, nonatomic) UINavigationController *nav;
@property(nonatomic,strong)UIViewController *controller;
@property (nonatomic,assign)  id<WeibologinDelegate>wdelegate;
@property(nonatomic,copy)void(^myblock)(NSString *accseeToken,NSString *userId);
@end

