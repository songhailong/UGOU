//
//  ReturngoodsViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/21.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"
@interface ReturngoodsViewController : UIViewController
@property(nonatomic,strong)NSNumber *apporderid;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,assign)NSInteger customerflag;
@property(nonatomic,strong)CartModel *model;
@property(nonatomic,copy)void(^returnblock)(NSInteger text,NSInteger index);
@end
