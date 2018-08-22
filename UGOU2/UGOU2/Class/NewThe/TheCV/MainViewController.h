//
//  MainViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/23.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property(strong,nonatomic)UIView *headview;
@property(strong,nonatomic)UIScrollView *headscroll;
@property(strong,nonatomic)UIPageControl *page;
@property(strong,nonatomic)NSMutableArray *imgarr;
@property(strong,nonatomic)UINavigationBar *nabar;
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)UITabBarController *tabbar;

@end
