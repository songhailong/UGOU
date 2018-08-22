//
//  WelcomeViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/2.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol welcomePagedelegate <NSObject>

-(void)showHomePage:(UIViewController *)ViewController;

@end
@interface WelcomeViewController : UIViewController
@property (nonatomic, weak) id<welcomePagedelegate>delegate;

@property (nonatomic, strong)UIScrollView *guidancePageScrollView;
@end
