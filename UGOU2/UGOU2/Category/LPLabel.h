//
//  LPLabel.h
//  label上画横线
//
//  Created by Li Pan on 14-6-30.
//  Copyright (c) 2014年 Pan Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPLabel : UILabel

/**
 是否画线
 */
@property (assign, nonatomic) BOOL strikeThroughEnabled; // 是否画线

/**
 划线颜色
 */
@property (strong, nonatomic) UIColor *strikeThroughColor; // 画线颜色

@end
