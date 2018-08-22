
//
//  Uikility.m
//  适配测试
//
//  Created by 徐东 on 15/12/2.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import "Uikility.h"
#import "FMDB.h"

#import "UMSocialQQHandler.h"
#import "CartModel.h"
#import "DiscountModel.h"
#import "AllcardModel.h"
//#import <TencentOpenAPI/QQApiInterface.h>
#import <UIKit/UIKit.h>
#import "UGCustomNavView.h"
@implementation Uikility
+(IphoneType)getIphoneType{
    if (CGSizeEqualToSize(CGSizeMake(640.0, 960.0), [[UIScreen mainScreen] currentMode].size)) {
        return IphoneTypeIphone4and4s;
    }else if (CGSizeEqualToSize(CGSizeMake(640.0, 1136.0), [[UIScreen mainScreen] currentMode].size)){
        return IphoneTypeIphone5and5s;
    }else if (CGSizeEqualToSize(CGSizeMake(750.0, 1334.0), [[UIScreen mainScreen] currentMode].size)){
        return IphoneTypeIphone6;
    }else if (CGSizeEqualToSize(CGSizeMake(1242.0, 2208.0), [[UIScreen mainScreen] currentMode].size)){
        return IphoneTypeIphone6p;
    }else{
        return IphoneTypeIphone5and5s;
    }
}
+(CGFloat)IphoneType{
    if (CGSizeEqualToSize(CGSizeMake(640.0, 1136.0), [[UIScreen mainScreen] currentMode].size)){
        return 320.0/375;
    }else if (CGSizeEqualToSize(CGSizeMake(750.0, 1334.0), [[UIScreen mainScreen] currentMode].size)){
        return 1.0;
    }else if (CGSizeEqualToSize(CGSizeMake(1242.0, 2208.0), [[UIScreen mainScreen] currentMode].size)){
        return 414.0/375;
    }
    else if (CGSizeEqualToSize(CGSizeMake(640.0, 960.0), [[UIScreen mainScreen] currentMode].size)){
        return 320.0/375;
    }
    else{
        return 1.0;
    }
}
+(CGFloat)iphoneXHeight{
    return IS_IPHONEX ? ([[UIScreen mainScreen]bounds].size.height-34):([[UIScreen mainScreen] bounds].size.height);
    
}
+(NSString *)initWithdatajsonstring:(NSDictionary *)dic{
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *json=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@""  withString:@"" ];
    //json=[json stringByReplacingOccurrencesOfString:@"\""  withString:@"" ];
    return json;

}

+(NSDictionary *)initWithdatajson:(NSDictionary *)dic{
    
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSString *sss=@"\";
 
    json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
    json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
    json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
    json=[json stringByReplacingOccurrencesOfString:@"\\" withString:@""];
     //json=[json stringByReplacingOccurrencesOfString:@"id\ " withString:@"id"];
    json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSDictionary *json1=@{@"param":json
                          };
        return json1;
    
}
+(NSMutableDictionary *)creatSinGoMutableDictionary{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        [dic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [dic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [dic setObject:[de objectForKey:@"newUserId" ] forKey:@"newUserId"];
        }

    }
    [dic setObject:@1 forKey:@"model"];
    [dic setObject:VERSION forKey:@"ios_version"];

    return dic;

}
+(NSString *)DatetoTime:(long)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp =[NSDate dateWithTimeIntervalSince1970:time];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+(CGFloat)calculateAllPriceGoods:(NSArray *)goods{
    CGFloat all=0;
    for (CartModel *model in goods) {
    if (model.quantity) {
            NSInteger s=model.quantity;
            if (model.vipFlag) {
                all=all+model.vipPrice.floatValue*s;
            }else{
            
            all=all+model.promotionPrice.floatValue*s;
            }
          
        }else{
            if (model.vipFlag) {
                all=all+model.vipPrice.floatValue;
            }else{
                
                all=all+model.promotionPrice.floatValue;
            }
        }
        
    }
    
    return all;
}
+(CGFloat)calculateCellSelectAllPrice:(NSArray *)dataArr{
    CGFloat all=0;
    for (AllcardModel *allmodel in dataArr) {
        for (NSArray * arr in allmodel.goods) {
            
            for (CartModel *model in arr) {
                if (model.editing) {
                    if (model.quantity) {
                        NSInteger s=model.quantity;
                        if (model.vipFlag) {
                            all=all+model.vipPrice.floatValue*s;
                        }else{
                            
                            all=all+model.promotionPrice.floatValue*s;
                        }
                        
                    }else{
                        if (model.vipFlag) {
                            all=all+model.vipPrice.floatValue;
                        }else{
                            
                            all=all+model.promotionPrice.floatValue;
                        }
                    }
                }
            }
        }
    }

    return all;
}
+(NSMutableArray *)calculateSelelctCellordinary:(NSMutableArray *)SelectArr{
    NSMutableArray *muarr=[[NSMutableArray alloc] init];
    for (CartModel *model in  SelectArr) {
        if (model.vipFlag) {
            
        }else{
            [muarr addObject:model];
        
        }
    }
    return muarr;
}
+(NSMutableArray *)calculateSelelctCellVIP:(NSMutableArray *)SelelctArr{
    NSMutableArray *muarr=[[NSMutableArray alloc] init];
    for (CartModel *model in  SelelctArr) {
        if (model.vipFlag) {
            [muarr addObject:model];
        }else{
            
            
        }
    }
    return muarr;
    

}
+(NSMutableArray *)calculateCellSelectAlldata:(NSMutableArray *)dataArr{
    NSMutableArray *allselect=[[NSMutableArray alloc] init];
    for (AllcardModel *allmodel in dataArr) {
        for (NSArray * arr in allmodel.goods) {
            
            for (CartModel *model in arr) {
            if (model.editing) {
               [allselect addObject:model];
             }
            }
        }
    }


    return allselect;
}
+(NSString *)Datetodatestyle:(long) time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
   // [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp =[NSDate dateWithTimeIntervalSince1970:time];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;


}
+(long)readnowtime{
    //s=[NSMutableString stringWithFormat:@"%ld-%@:%d%D",(long)comps.year,s,0,0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
   // NSDate* date = [formatter dateFromString:s]; //------------将字符串按formatter转成nsdate
    
    //            时间转时间戳的方法:
    long recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    
  
    

    return recordTime;
    
    
}
+ (NSString *)UTF8To859:(NSString *)oldStr
{
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    //char converted[([oldStr length] + 1)];
    //return [NSString stringWithUTF8String:[oldStr cStringUsingEncoding:enc]];
   
  const  char *converted=[oldStr cStringUsingEncoding:NSISOLatin1StringEncoding];
    return [NSString  stringWithCString:converted encoding:NSUTF8StringEncoding];
}
+(NSMutableArray *)initWithArray:(NSArray *)array{
     NSMutableArray *datarry=[NSMutableArray array];
    if (array.count) {
    for (NSInteger i =array.count-1;i>=0;i--) {
        [datarry addObject:array[i]];
    }}else{
    
        return nil;
    }
    return datarry;
}
+(CGFloat)calculateCellHeight:(NSArray *)array{
    if(array.count){
        CGFloat all=0;
        for (NSArray *arr in array) {
            all=50*KIphoneWH+all;
            all=100*KIphoneWH*arr.count+all;
        }
        return all;
    }

    return 0;

}
+(NSString *)getBuildVersion{
    
    NSDictionary  *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *buildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return buildVersion;
}
+(NSURL *)URLWithString:(NSString *)URLString{
    
    NSString *string=[URLString stringByReplacingOccurrencesOfString:@"http://139.129.116.242:80/" withString:@"https://www.ugouchina.com/"];
    NSString *  stringurl=[string stringByReplacingOccurrencesOfString:@"http://www.ugouchina.com:80/" withString:@"https://www.ugouchina.com/"];
    NSString *  urlhttps=[stringurl stringByReplacingOccurrencesOfString:@"http://www.ugouchina.com/" withString:@"https://www.ugouchina.com/"];
     NSString *  urlimage=[urlhttps stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    
    return [NSURL URLWithString:urlimage];
}
+(NSString *)VideoWithURLString:(NSString *)URLString{
    NSString *string=[URLString stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
    
    return string;

}
+(void)alert:(NSString *)meg{
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:meg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
  
       
      [Uikility  performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.5];
 
   
}

+(void) dimissAlert:(UIAlertView *)alert {
    if(alert)     {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
      
    }
}

+(UIColor *)colortoRGF:(NSMutableString *)color{
    //[color insertString:@"111" atIndex:2];
   [color replaceCharactersInRange:NSMakeRange(0, 1) withString:@"0x"];
    
    long colorLong=strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    int r=(colorLong & 0xFF0000 )>>16;
    int g=(colorLong &  0x00FF00)>>8;
    int b=colorLong & 0x0000FF;
   
    
    UIColor *wordColor=[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    return wordColor;
}
+(NSString *)takeuuid{

    
        CFUUIDRef uuid_ref=CFUUIDCreate(nil);
        CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
        CFRelease(uuid_ref);
        NSString *uuid=[NSString stringWithString:(__bridge NSString * _Nonnull)(uuid_string_ref)];
        CFRelease(uuid_string_ref);
        return uuid;
}
//比较价格
+(CGFloat )priceToCompareVipprice:(NSNumber *)price vipnumber:(NSNumber*)vipnumber{
    CGFloat s=price.floatValue;
    CGFloat vips=vipnumber.floatValue;
    if (vipnumber==nil) {
        return s;
    }else{
    
        if (s>vips) {
            return vips;
        }else{
            return s;
        
        }
    
    
    }
    
    
  //return <#expression#>
}
+(NSNumber *)ifVIPmemberPprice:(NSNumber *)price VIPnumber:(NSNumber *)vipnumbe
{
    CGFloat s=price.floatValue;
    CGFloat vips=vipnumbe.floatValue;
    if (vipnumbe==nil) {
        
        return @0;
    }else{
        
        if (s>vips) {
            return @1;
        }else{
            
            return @0;
            
        }
        
        
    }


}
//-(void)shareWbsinaWithimage:(NSData *)imagedata title:(NSString *)title description:(NSString *)description url:(NSString *)url{
//   //微博小于32k
//    _imagedata=imagedata;
//    _title=title;
//    _wbdescription=description;
//    _shareurl=url;
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = @"https://api.weibo.com/oauth2/authorize";
//    authRequest.scope = @"all";
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:_accessToken];
//     
//    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
//    [WeiboSDK sendRequest:request];
//}
//
//- (WBMessageObject *)messageToShare
//{
//    WBMessageObject *message = [WBMessageObject message];
//    
//        if (self.shareurl!=nil)
//        {
//            message.text = NSLocalizedString(_title, nil);
//            WBWebpageObject *webpage = [WBWebpageObject object];
//            webpage.objectID = @"identifier1";
//            webpage.title = NSLocalizedString(_wbdescription, nil);
//            webpage.description = [NSString stringWithFormat:NSLocalizedString(@"%@-%.0f", nil),_wbdescription ,[[NSDate date] timeIntervalSince1970]];
//            webpage.thumbnailData = _imagedata;
//            webpage.webpageUrl = _shareurl;
//            message.mediaObject = webpage;
//        }else{
//        //WBMessageObject *message = [WBMessageObject message];
//        message.text = NSLocalizedString(_title, nil);
//            WBImageObject *image = [WBImageObject object];
//            image.imageData = _imagedata;
//            message.imageObject = image;
//        
//        }
//    
//    return message;
//}

-(void)shareYMWbsinaWithimage:(NSData *)imagedata title:(NSString *)title description:(NSString *)description url:(NSString *)url viewcontrol:(UIViewController *)UIViewC{

    UMSocialMessageObject *messageObject=[UMSocialMessageObject messageObject];
    //[UMSocialData defaultData].extConfig.qzoneData.title=title;
    if (url) {
        UMShareWebpageObject *shareObject=[UMShareWebpageObject shareObjectWithTitle:title descr:description thumImage:imagedata];
        
        shareObject.webpageUrl=url;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            if (error) {
                
            }else{
                
            }
        }];
        
        
    }else{
        
        messageObject.text=description;
        
        UMShareImageObject *shareObject=[[UMShareImageObject alloc] init];
        shareObject.thumbImage=imagedata;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager]shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            
        }];
    }

    

}
-(void)shareWithWexintext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image{
    
    
            if(url!=nil){
    
            WXMediaMessage *message=[WXMediaMessage message];
            message.title=title;
            message.description=text;
            [message setThumbImage:image];
            WXWebpageObject *webpageObject=[WXWebpageObject object];
            webpageObject.webpageUrl=url;
            message.mediaObject=webpageObject;
            SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
            req.bText=NO;
            req.message=message;
            req.scene=WXSceneTimeline;
            [WXApi sendReq:req];
            }else{
                WXMediaMessage *message=[[WXMediaMessage alloc] init];
               // message.title=title;
                // message.description=text;
                [message setThumbImage:[UIImage imageNamed:@"uuu.png"]];
                WXImageObject *imageobject=[WXImageObject object];
                imageobject.imageData=imagedata;
                message.mediaObject=imageobject;
                SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
                req.bText=NO;
                req.message=message;
                req.scene=WXSceneTimeline;
                [WXApi sendReq:req];
            
            
            
            }




}
-(void)shareWithYMWexintext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image viewcontrol:(UIViewController *)UIViewC{
    UMSocialMessageObject *messageObject=[UMSocialMessageObject messageObject];
    //[UMSocialData defaultData].extConfig.qzoneData.title=title;
    if (url) {
        UMShareWebpageObject *shareObject=[UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:imagedata];
        
        shareObject.webpageUrl=url;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            if (error) {
                
            }else{
                
            }
        }];
        
        
    }else{
        
        messageObject.text=text;
        
        UMShareImageObject *shareObject=[[UMShareImageObject alloc] init];
        shareObject.thumbImage=imagedata;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager]shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            
        }];
    }
}
-(void)shareWithWXfrendtext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image{
     
    if(url!=nil){
        
        WXMediaMessage *message=[WXMediaMessage message];
        message.title=title;
        message.description=text;
        [message setThumbImage:image];//微信小于128k
        //[message setth]
        WXWebpageObject *webpageObject=[WXWebpageObject object];
        webpageObject.webpageUrl=url;
        message.mediaObject=webpageObject;
        SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
        req.bText=NO;
        req.message=message;
        req.scene=WXSceneSession;
        [WXApi sendReq:req];
    }else{
        WXMediaMessage *message=[[WXMediaMessage alloc] init];
        //message.description=text;
        //message.title=title;
        [message setThumbImage:[UIImage imageNamed:@"uuu.png"]];
        WXImageObject *imageobject=[WXImageObject object];
        imageobject.imageData=imagedata;
        message.mediaObject=imageobject;
        SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
        req.bText=NO;
        req.message=message;
        req.scene=WXSceneSession;
        [WXApi sendReq:req];
        
        
        
    }

    
    
    
    
}
-(void)shareWithYMWXfrendtext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image viewcontrol:(UIViewController *)UIViewC{
    
    UMSocialMessageObject *messageObject=[UMSocialMessageObject messageObject];
    //[UMSocialData defaultData].extConfig.qzoneData.title=title;
    if (url) {
        UMShareWebpageObject *shareObject=[UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:imagedata];
        
        shareObject.webpageUrl=url;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            if (error) {
                
            }else{
                
            }
        }];
        
        
    }else{
        
        messageObject.text=text;
        
        UMShareImageObject *shareObject=[[UMShareImageObject alloc] init];
        shareObject.thumbImage=imagedata;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager]shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            
        }];
        
        
        
        
    }




}
//-(void)shareQQzoneWithimage:(NSData *)imagedata title:(NSString *)title description:(NSString *)description url:(NSString *)url{
//     _ten=[[TencentOAuth alloc]initWithAppId:@"1103583193" andDelegate:self];
//    
//    
//    if (imagedata!=nil) {
//        QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imagedata previewImageData:imagedata title:title  description:description];
//        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
//        //将内容分享到qq
//        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//        //[self handleSendResult:sent];
//    }else if(url!=nil){
//        NSString *utf8String = url;
//               NSString *description = @"新闻描述";
//        NSString *previewImageUrl = url;
//        QQApiNewsObject *newsObj = [QQApiNewsObject
//                                    objectWithURL:[NSURL URLWithString:utf8String]
//                                    title:title
//                                    description:description
//                                    previewImageURL:[NSURL URLWithString:previewImageUrl]];
//        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
//        //将内容分享到qq
//        //QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//        //将内容分享到qzone
//        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
//        //[self handleSendResult:sent];
//    }else{
//        QQApiTextObject *textobject=[QQApiTextObject objectWithText:title];
//        SendMessageToQQReq *req=[SendMessageToQQReq reqWithContent:textobject];
//        QQApiSendResultCode sent=[QQApiInterface sendReq:req];
//       // [self handleSendResult:sent];
//    }
//   
//
// 
//    
//    
//    
//}
//友盟分享qq空间

-(void)shareWithYmQQzone:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(UIImage *)imagedata imageurl:(NSString *)iamgeurl viewcontrol:(UIViewController *)UIViewC  {
  
    UMSocialMessageObject *messageObject=[UMSocialMessageObject messageObject];
    //[UMSocialData defaultData].extConfig.qzoneData.title=title;
    if (url) {
    UMShareWebpageObject *shareObject=[UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:imagedata];
        
        shareObject.webpageUrl=url;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            if (error) {
                
            }else{
                
            }
        }];
        
        
    }else{
        
        messageObject.text=text;
        
        UMShareImageObject *shareObject=[[UMShareImageObject alloc] init];
        shareObject.thumbImage=imagedata;
        messageObject.shareObject=shareObject;
        [[UMSocialManager defaultManager]shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:UIViewC completion:^(id result, NSError *error) {
            
        }];
        
        
        
        
   }
    
    
}

//- (void)handleSendResult:(QQApiSendResultCode)sendResult
//{
//    switch (sendResult)
//    {
//        case EQQAPIAPPNOTREGISTED:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//
//            break;
//        }
//        case EQQAPIMESSAGECONTENTINVALID:
//        case EQQAPIMESSAGECONTENTNULL:
//        case EQQAPIMESSAGETYPEINVALID:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//
//            break;
//        }
//        case EQQAPIQQNOTINSTALLED:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//
//            break;
//        }
//        case EQQAPIQQNOTSUPPORTAPI:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//
//            break;
//        }
//        case EQQAPISENDFAILD:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//
//            break;
//        }
//        default:
//        {
//            break;
//        }
//    }
//}

+(id)goodtoBrandificationarr:(NSMutableArray *)mutablearray{
    NSMutableArray *_groupArr = [NSMutableArray array];
    NSMutableArray *currentArr = [NSMutableArray array];
    
    // 因为肯定有一个字典返回,先添加一个
    if (mutablearray.count>0) {
        [currentArr addObject:mutablearray[0]];
    [_groupArr addObject:currentArr];
    // 如果不止一个,才要动画添加
    if(mutablearray.count > 1){
        for (int i = 1; i < mutablearray.count; i++) {
            // 先取出组数组中  上一个模型数组的第一个字典模型的groupID
            NSMutableArray *preModelArr = [_groupArr objectAtIndex:_groupArr.count-1];
            CartModel *model=[preModelArr objectAtIndex:0];
            NSString *preGroupID = model.brandName ;
            // 取出当前字典,根据groupID比较,如果相同则添加到同一个模型数组;如果不相同,说明不是同一个组的
            CartModel *currentDict =mutablearray[i];
            NSString *groupID = currentDict.brandName ;
            if ([groupID isEqualToString: preGroupID]) {
                [currentArr addObject:currentDict];
            }else{
                // 如果不相同,说明 有新的一组,那么创建一个模型数组,并添加到组数组_groupArr
                currentArr = [NSMutableArray array];
                [currentArr addObject:currentDict];
                [_groupArr addObject:currentArr];
            }
        }
    }
    

        return _groupArr;
    }
    return mutablearray;

}
+(NSArray* )mintomaxarr:(NSMutableArray *)muarr{
    
    for (int i=0; i<muarr.count-1; i++) {
        for (int j=0; j<muarr.count-1-i; j++) {
            
            DiscountModel *fistmodel=muarr[j];
            DiscountModel *secodmodel=muarr[j+1];
            if (fistmodel.count.intValue>secodmodel.count.intValue) {
                muarr[j]=secodmodel;
               muarr[j+1]=fistmodel;
            }
            
        }
        
    }

    return muarr;


}
/**
- (BOOL)getIntimateFriends:(NSMutableDictionary *)params{}


 * QZone定向分享，可以@到具体好友，完成后将触发responseDidReceived:forMessage:回调，message：“SendStory”
 * \param params 参数字典
 * \param fopenIdArray 第三方应用预传人好友列表，好友以openid标识
 * \return 处理结果，YES表示API调用成功，NO表示API调用失败，登录态失败，重新登录
**/
@end
