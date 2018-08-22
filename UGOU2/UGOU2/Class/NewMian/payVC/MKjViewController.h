//
//  MKjViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/3.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderPriceDeleget <NSObject>

-(void)preferentialchangge:(NSInteger)text page:(NSInteger)page;

@end

//typedef void (^MyBlockType)(NSInteger);
@interface MKjViewController : UIViewController

//判断是那个界面跳转过来的

@property(nonatomic,assign)int flagss;
@property(nonatomic,assign)NSInteger money;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,strong)NSNumber* brandid;
@property(nonatomic,strong)NSArray *arrids;
@property(nonatomic,assign)NSInteger buttonpage;
@property(nonatomic,assign)NSInteger buttag;
@property(nonatomic,assign)NSMutableArray *selectarray;

@property(nonatomic,strong)NSMutableArray *dataarr;
//@property(nonatomic,copy)MyBlockType mysblock;
@property(nonatomic,weak)id <OrderPriceDeleget>orderdeleget;


@property(nonatomic,copy)void(^mysblock)(int text);

@property(nonatomic,copy)void(^ablock)(NSInteger value);
@end
