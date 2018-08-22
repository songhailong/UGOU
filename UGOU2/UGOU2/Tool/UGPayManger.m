//
//  UGPayManger.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/12/14.
//

#import "UGPayManger.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

//#import "UPPaymentControl.h"
//#import "UPAPayPluginDelegate.h"
#define kMode_Development @"00"//银联 测试01 正式00
#define kURL_TN_Normal                @"http://101.231.204.84:8091/sim/getacptn"
#define WXAppID @"wx632d6c8a00776b9d"
@interface UGPayManger ()<WXApiDelegate>{
    NSMutableData* _responseData;
    UIViewController *vc;
}

@end
@implementation UGPayManger
+(instancetype)SharedManager{
    static UGPayManger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[UGPayManger alloc] init];
    });
    return instance;
}
+(void)setUGPayAppID{
    //微信注册
    //[WXApi registerApp:WXAppID enableMTA:YES];
    [WXApi registerApp:WXAppID];
    
}
+(void)creatPayMent:(NSDictionary *)charge viewController:(UIViewController *)viewController payType:(UGPayObjctType)payType payCompletion:( UGPayCompletion )paycompletion{
    UGPayManger *manger=[UGPayManger SharedManager];
    
        switch (payType) {
            case UGPayObjctTypeWX:
                [manger sendPayWXPayChareObject:charge payCompletion:paycompletion];
                break;
            case UGPayObjctTypeALPay:
                [manger sendPayALPayChareObjec:charge payCompletion:paycompletion];
                break;
            case UGPayObjctTypeUPAPay:
            
            [manger sendPayUPAchareObjce:charge viewControler:viewController payCompletion:paycompletion];
                break;
                
            default:
                break;
        }
    
    
}
#pragma mark*********  发起银联支付
-(void)sendPayUPAchareObjce:(NSDictionary *)chare viewControler:(UIViewController *)viewController payCompletion:(UGPayCompletion )payCompletion{
//   // NSData jssonDate = [NSData data]
//    if(chare==nil){
//
//        return;
//    }
//
//    NSString* tn = [[chare objectForKey:@"data"]objectForKey:@"tn"];
//   // NSLog(@"签名字符串%@",tn);
//    //判断字符串
//    if (tn != nil && tn.length > 0)
//    {
//
//   BOOL isPaysucess=[[UPPaymentControl defaultControl] startPay:tn fromScheme:WXAppID mode:kMode_Development viewController:viewController];
//        if (isPaysucess) {
//
//       }
//    self.wxCompletion=^(NSString * result){
//            if (payCompletion) {
//
//                payCompletion(result);
//            }
//
//        };
//    }
}
#pragma mark*************发起支付宝支付
-(void)sendPayALPayChareObjec:(NSDictionary *)chare payCompletion:(UGPayCompletion)payCompletion{
    
    NSString *tn=[[chare objectForKey:@"data"] objectForKey:@"appPayResponse"];
    if (tn != nil && tn.length > 0){
    [[AlipaySDK defaultService] payOrder:tn fromScheme:WXAppID callback:^(NSDictionary *resultDic) {
       // NSLog(@"支付宝返回%@",resultDic);
        if ([resultDic objectForKey:@"resultStatus"]!=nil) {
            NSString *resultStatus=[resultDic objectForKey:@"resultStatus"];
            //resultStatus 结果码为9000是支付成功
//            if ([resultStatus isEqualToString:@"9000"]) {
//                UGPayManger *manger=[UGPayManger SharedManager];
//                if (manger.wxCompletion) {
//                    manger.wxCompletion(SUCESS);
//                }
//            }
        }
    }];
    }
    self.wxCompletion = ^(NSString *result) {
        if (payCompletion) {
            payCompletion(result);
        }
    };
    
    
}
#pragma mark***************  发起微信支付
-(void)sendPayWXPayChareObject:(NSDictionary *)chare payCompletion:(UGPayCompletion )payCompletion{
    NSDictionary *dic=[[chare objectForKey:@"data"] objectForKey:@"msg"];
    if (dic==nil) {
        return;
    }
    NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
    PayReq * req=[[PayReq alloc] init];
    //商家id
    req.partnerId=[dic objectForKey:@"partnerid"];
    //预支付订单
    req.prepayId=[dic objectForKey:@"prepayid"];
    //随机串 防重发
    req.nonceStr=[dic objectForKey:@"noncestr"];
    //时间戳 防止重发
    req.timeStamp=stamp.intValue;
    //商家根据财付通文档填写的数据和签名
    req.package=[dic objectForKey:@"package"];
    // 商家根据微信开放平台文档对数据做的签名
    req.sign=[dic objectForKey:@"sign"];
    [WXApi sendReq:req];
    
    
    UGPayCompletion complet=^(NSString * result){
        if (payCompletion) {

            payCompletion(result);
        }

    };
     self.wxCompletion=complet;
    
    
}
+(BOOL)handleOpenURL:(NSURL *)url{
    //BOOL result=NO;
   
    if([url.host isEqualToString:@"safepay"])
    {  //支付宝
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            if ([resultDic objectForKey:@"resultStatus"]!=nil) {
                NSString *resultStatus=[resultDic objectForKey:@"resultStatus"];
                if ([resultStatus isEqualToString:@"9000"]) {
                        UGPayManger *manger=[UGPayManger SharedManager];
                    if (manger.wxCompletion) {
                        manger.wxCompletion(SUCESS);
                                }
                }
            }
        }];
        
        
    }else if ([url.host isEqualToString:@"pay"]){
        //微信
  BOOL result= [WXApi handleOpenURL:url delegate:[UGPayManger SharedManager]];
        return result;
    }else if([url.host isEqualToString:@"uppayresult"]){
      //银联
//
//        [[UPPaymentControl defaultControl]handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
//
//            if([code isEqualToString:@"success"]){
//
//                //支付成功
//                UGPayManger *manger=[UGPayManger SharedManager];
//                if (manger.wxCompletion) {
//                    manger.wxCompletion(SUCESS);
//                }
//            }
//        }];
        
    }
    
    return YES;
}
#pragma mark******** 返回支付结果的微信代理
-(void)onResp:(BaseResp *)resp{
    //判断是否是 微信支付结果类
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
                //支付成功
                
                if (_wxCompletion) {
                    _wxCompletion(SUCESS);
                }
                break;
                
           case WXErrCodeCommon:
                //发送失败
                break;
            case WXErrCodeAuthDeny:
                //授权失败
                break;
            case WXErrCodeSentFail:
                //发送失败
                break;
            case WXErrCodeUnsupport:
                //微信不支持
                break;
            case WXErrCodeUserCancel:
                //用户取消
                break;
            default:
                break;
        }
    }
    
}
- (void)startNetWithURL:(NSURL *)url
{
    //[_curField resignFirstResponder];
    //_curField = nil;
    //[self showAlertWait];
    
    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSInteger code = [rsp statusCode];
    if (code != 200)
    {
        
       // [self showAlertMessage:kErrorNet];
        [connection cancel];
    }
    else
    {
        
        _responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //[self hideAlert];
    NSString* tn = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    
    if (tn != nil && tn.length > 0)
    {
        
        
//        [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"wx632d6c8a00776b9d" mode:@"01" viewController:vc];
        
    }
    
    
}


@end
