//
//  HYSegmentedControl.h
//  CustomSegControlView
//
//  Created by sxzw on 14-6-12.
//  Copyright (c) 2014年 sxzw. All rights reserved.
//





#import <UIKit/UIKit.h>
@protocol HYSegmentedControlDelegate<NSObject>
@required
//代理函数 获取当前下标
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index;

@end
//#import <UIKit/UIKit.h>
@interface HYSegmentedControl : UIView

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)NSMutableArray *array4Btn;
@property (strong, nonatomic)UIView *bottomLineView;
@property (strong, nonatomic) UIButton *btn;
@property (assign, nonatomic) id<HYSegmentedControlDelegate>delegate;
@property(strong,nonatomic)NSArray *title;
//初始化函数
- (id)initWithOriginY:(CGFloat)y width:(CGFloat)w color:(UIColor*)c Titles:(NSArray *)titles delegate:(id)delegate;
//提供方法改变 index
- (void)changeSegmentedControlWithIndex:(NSInteger)index;

@end
