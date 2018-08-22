//
//  DTViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/6.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressViewController.h"
@interface DTViewController : UIViewController<DeaddressDelegate>
@property(retain,nonatomic)id <DeaddressDelegate>delegate;
@end
