//
//  TimeViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/12/25.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DingdanViewController.h"
@interface TimeViewController : UIViewController<TimeDelegate>
@property(nonatomic,assign)NSInteger flag;
@property(retain,nonatomic)id <TimeDelegate>delegate;
@end
