//
//  PpViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/4.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"
@interface PpViewController : UIViewController
@property(nonatomic,assign)int flag;
@property(nonatomic,strong)NSNumber *appstoreId;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)MapModel *model;
@property(nonatomic,assign)int  indexint;
@property(nonatomic,strong)NSString *appbrandId;
// x 判断按什么方式排序
@property(nonatomic,assign)int numberpage;
@property(nonatomic,assign)BOOL SCy;
@end
