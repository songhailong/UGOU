//
//  StoresmapViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/4/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresmapViewController : UIViewController
//经纬度数据
@property(nonatomic,strong)NSMutableArray *maparray;

@property(nonatomic,copy)NSString *city;
@end
