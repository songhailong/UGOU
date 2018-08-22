//
//  SFViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/16.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  SFViewControllerDeleget<NSObject>
-(void)Showflag:(NSInteger)flag;
@end
@interface SFViewController : UIViewController
@property(nonatomic,assign)int flag;
@property(nonatomic,strong)NSString *attribute;
@property(nonatomic,strong)NSString *ids;
@property(nonatomic,assign)int flagsdg;
@property(nonatomic,assign)NSInteger flagdg;
@property(nonatomic,weak)id <SFViewControllerDeleget>deleget;
@end
