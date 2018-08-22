//
//  AdressViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/11.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DeaddressDelegate
-(void)passAdress:(NSMutableDictionary *)deaddress;
@end
@interface AdressViewController : UIViewController<DeaddressDelegate>
//判断 是否修改
@property(nonatomic,assign)int flage;
// 传过来得
@property(nonatomic,strong)NSDictionary *d;

//@property(nonatomic,assign)int sucess;
//
//@property(nonatomic,strong)NSString *str;

@end
