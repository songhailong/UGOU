//
//  DingdanViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/29.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimeDelegate
-(void)passtime:(NSString *)time;
@end

@interface DingdanViewController : UIViewController<TimeDelegate>

// 订单 模型组
@property(nonatomic,strong)NSMutableArray *array;
//是否是购物车跳转
@property(nonatomic,assign)BOOL IsCart;
//普通 上门 和到店
@property(nonatomic,assign)NSInteger flag;
//总个数
@property(nonatomic,assign) NSInteger gs;
//支付方式是否是线下支付
@property(nonatomic,assign)NSInteger pagenumer;
//总价
@property(nonatomic,assign)CGFloat allprice;
//订单号
@property(nonatomic,strong)NSString *order;
//商店号
@property(nonatomic,strong)NSNumber *StoresId;
//有没有预定时间
@property(nonatomic,assign)NSInteger Time;
//满件折扣的数组
@property(nonatomic,strong)NSArray *discountIds;

//满件打折的模型数组
@property(nonatomic,strong)NSMutableArray *ZheKouIDs;

//block 回调
@property(nonatomic,copy)void(^mysblock)(NSInteger text);
@property(nonatomic,copy)void(^ordercblock)(NSInteger   text);
//-(IBAction)auth:(id)sender;
@end
