//
//  LoginViewController.h
//  UgouAppiOS
//
//  Created by 靓萌服饰 on 15/9/25.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(nonatomic,strong)UITextField *ufield;
@property(nonatomic,strong)UITextField *mfield;
//@property(nonatomic,strong)NSUserDefaults *de;
@property(nonatomic,assign)NSInteger flag;
-(void)getAccessTokenWithCode:(NSString *)code;
-(void)getAccessToken: (NSString *)accseeToken withUserId:(NSString *)userId;
@end
