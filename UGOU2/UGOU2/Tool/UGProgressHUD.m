//
//  UGProgressHUD.m
//  SVPregrossHUBDome
//
//  Created by 靓萌服饰靓萌服饰 on 2017/12/26.
//  Copyright © 2017年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "UGProgressHUD.h"

@implementation UGProgressHUD

+(void)showSuccessText:(NSString *)aText{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"HUD_success"]];
    [SVProgressHUD showSuccessWithStatus:aText];
    
}
+(void)showText:(NSString *)aText{
    //小菊花
    //[SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:aText];
}
+(void)showLoading{
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
}
+(void)showErrorMesessge:(NSString *)aText{
    
    [SVProgressHUD showErrorWithStatus:aText];
    //设置消失时间
    [SVProgressHUD dismissWithDelay:1];
}
+ (void)showProgress:(NSInteger)progress{
    
}
+(void)dismissLoading{
    [SVProgressHUD dismiss];
    
}
+(void)showImage:(UIImage *)image status:(NSString *)status{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showImage:image status:status];
    
}
+ (void)showImage:(UIImage*)image text:(NSString*)aText{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showImage:image status:aText];
}
+(void)showUgTextMesessgeStause:(NSString *)staus{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:staus];
    //[SVProgressHUD showImage:<#(nonnull UIImage *)#> status:<#(nullable NSString *)#>]
}
+(void)showCustemAnimated{
    
    
}
@end
