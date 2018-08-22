//
//  UGPayManger.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/12/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SUCESS @"success"
typedef void(^UGPayCompletion)(NSString * result);
typedef NS_ENUM(NSInteger,UGPayObjctType){
    UGPayObjctTypeWX,
    UGPayObjctTypeALPay,
    UGPayObjctTypeUPAPay
};
@interface UGPayManger : NSObject

@property(nonatomic,copy)void(^wxCompletion)(NSString * result);
/**初始化单例*/
+(instancetype)SharedManager;
/**返回结果处理*/
+(BOOL)handleOpenURL:(NSURL*)url;
/**注册各大支付平台的appid*/
+(void)setUGPayAppID;
/**
 发起支付
 @param charge           Charge 对象(JSON 格式字符串 或 NSDictionary)
 @param viewController   银联支付需要的控制器
 @param payType          支付方式
 @param payCompletion    支付结果的block回调
 */
+(void)creatPayMent:(NSObject *)charge viewController:(UIViewController*)viewController payType:(UGPayObjctType)payType payCompletion:(UGPayCompletion )payCompletion;
@end
