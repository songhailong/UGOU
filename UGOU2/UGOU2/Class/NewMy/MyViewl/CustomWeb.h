//
//  CustomWeb.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/5/19.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWeb : UIWebView
@property(nonatomic,strong)UIView *view;
@property(nonatomic,copy)void (^WebBlock)(NSInteger text);
@end
