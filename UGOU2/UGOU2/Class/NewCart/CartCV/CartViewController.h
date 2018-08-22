//
//  CartViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UbassViewController.h"
@interface CartViewController : UbassViewController
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,copy)void(^block)(NSString *text);
@property(nonatomic,assign)int back;
@end
