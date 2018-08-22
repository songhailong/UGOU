//
//  UGProgressHUD.h
//  SVPregrossHUBDome
//
//  Created by 靓萌服饰靓萌服饰 on 2017/12/26.
//  Copyright © 2017年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "SVProgressHUD.h"

@interface UGProgressHUD : SVProgressHUD
/**
*  显示纯文本 加一个转圈
*
*  @param aText 要显示的文本
*/
+(void)showText:(NSString *)aText;
/**
 *  显示错误信息
 *
 *  @aText 错误信息文本
 */
+(void)showErrorMesessge:(NSString *)aText;

/**
 *  显示成功信息
 *
 *  @param aText 成功信息文本
 */
+(void)showSuccessText:(NSString *)aText;

/**
 *  只显示一个加载框
 */
+(void)showLoading;

/**
 *  隐藏加载框（所有类型的加载框 都可以通过这个方法 隐藏）
 */
+ (void)dismissLoading;

/**
 *  显示百分比
 *
 *  @param progress 百分比（整型 100 = 100%）
 */
+ (void)showProgress:(NSInteger)progress;

/**
 *  显示图文提示
 *
 *  @param image 自定义的图片
 *  @param aText 要显示的文本
 */
+ (void)showImage:(UIImage*)image text:(NSString*)aText;


/**
 只显示文本

 @param staus 显示的文字
 */
+(void)showUgTextMesessgeStause:(NSString*)staus;
/**
 显示自定义动画
 */
+(void)showCustemAnimated;
@end
