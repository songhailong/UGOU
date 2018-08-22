//
//  AdvertisingpageViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvertisingDeleget <NSObject>

-(void)Showrootview:(UIViewController *)vct;

@end




@interface AdvertisingpageViewController : UIViewController



@property(nonatomic,assign)id <AdvertisingDeleget>AdverDeleget;
@property(nonatomic,strong)UIView *rootview;
@end
