//
//  GuidancePageViewController.h
//  UgouAppios
//
//  Created by LHW on 16/1/26.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuidancePagedelegate <NSObject>

-(void)showHomePage:(UIViewController *)ViewController;

@end

@interface GuidancePageViewController : UIViewController

@property (nonatomic, weak) id<GuidancePagedelegate>delegate;

@property (nonatomic, strong)UIScrollView *guidancePageScrollView;

@end
