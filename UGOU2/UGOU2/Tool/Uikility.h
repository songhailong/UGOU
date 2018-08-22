//
//  Uikility.h
//  适配测试
//
//  Created by 徐东 on 15/12/2.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CartModel.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "MBProgressHUD.h"
//#import <TencentOpenAPI/TencentOAuth.h>
@class Uikility;
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)
#define  WIDTH              [UIScreen mainScreen].bounds.size.width
#define  HEIGHT    [Uikility iphoneXHeight]
#define KIphoneWH  [Uikility IphoneType]
#define NavHeight  (iPhoneX? 88:64*KIphoneWH)
#define tabHeight 49
#define VERSION [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define IPHONEVERSION [[UIDevice currentDevice]systemVersion]
#define WXAppid @"wx632d6c8a00776b9d"
#define WXAppSecret @"0e141405d57f49123643fd771dacc039"
#define XGAPPKEY @"I32N5Z8J1JFI"
#define MAPAPIKEY @"742ca8b07f70c1cc37e400d324759405"
#define COOKIE    @"setcookie"
#define AESKEY @"4349482757884ers"
#define MAPKEY   @"f088dc82ab494bc9b8832dd4dfa0d045"
#define UMPUSHKEY @"574fee9b67e58ed3f8002e0b"
#define UMPUSHSECRET @"fqrkpuvwlxvfshftueu8jak6qbypwvtb"
#define UGColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
#define THEMEShareSrcName(file) [@"UMSocialSDKResources.bundle/UMSocialPlatformTheme/default" stringByAppendingPathComponent:file]
#define isLocationSucess @"isLocationSucess"
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define unwrapTime @"unwrapTime"
static NSString *const BuildVersion = @"BuildVersion";

static BOOL isLocation;
typedef NS_ENUM(NSInteger, IphoneType){
    IphoneTypeIphone4and4s  = 0,
    IphoneTypeIphone5and5s  = 1,
    IphoneTypeIphone6 = 2,
    IphoneTypeIphone6p = 3
    
};
@interface Uikility : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * wbdescription;
@property(nonatomic,assign)NSData * imagedata;
@property(nonatomic,copy)NSString * shareurl;
@property(nonatomic,copy)NSString * accessToken;
@property(nonatomic,copy)NSString * wbCurrentUserID;
//@property(nonatomic,strong)TencentOAuth *ten;
//适配比例
+(IphoneType)getIphoneType;
+(CGFloat)IphoneType;
+(CGFloat)iphoneXHeight;

+(NSDictionary *)initWithdatajson:(NSDictionary *)dic;
+(NSString *)initWithdatajsonstring:(NSDictionary *)dic;
+ (NSString *)UTF8To859:(NSString *)oldStr;
+(NSString *)DatetoTime:(long) time;
+(NSString *)Datetodatestyle:(long) time;
+(NSMutableArray *)initWithArray:(NSArray *)array;
+(NSString *)getBuildVersion;
//获取当前时间
+(long)readnowtime;
+(void)alert:(NSString *)meg;

+(NSURL *)URLWithString:(NSString *)URLString;
+(NSString *)VideoWithURLString:(NSString *)URLString;
+(UIColor *)colortoRGF:(NSMutableString *)color;
//获取uuid
+(NSString *)takeuuid;
+(NSMutableDictionary *)creatSinGoMutableDictionary;
//将选中的商品按品牌分类
+(id)goodtoBrandificationarr:(NSMutableArray *)mutablearray;
//购物车选中商品的数组
+(NSMutableArray *)calculateSelelctCellVIP:(NSMutableArray *)SelelctArr;
//购物车选中商品的非vip 商品
+(NSMutableArray *)calculateSelelctCellordinary:(NSMutableArray *)SelectArr;
//从小大大排序
+(NSArray* )mintomaxarr:(NSMutableArray *)muarr;
//计算购物车cell高度
+(CGFloat)calculateCellHeight:(NSArray *)array;
//返回最低价
+(CGFloat )priceToCompareVipprice:(NSNumber *)price vipnumber:(NSNumber*)vipnumber;
//购物车计算每一个分区的总价格
+(CGFloat)calculateAllPriceGoods:(NSArray *)goods;
//购物车计算选中商品的价格
+(CGFloat)calculateCellSelectAllPrice:(NSArray *)dataArr;

//计算所有选中的商品
+(NSMutableArray *)calculateCellSelectAlldata:(NSMutableArray *)dataArr;
//比较是否会员显示
+(NSNumber *)ifVIPmemberPprice:(NSNumber *)price VIPnumber:(NSNumber *)vipnumber ;
//分享
-(void)shareQQzoneWithimage:(NSData *)imagedata title:(NSString *)title description:(NSString *)description url:(NSString *)url;
-(void)shareWithWexintext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image;


-(void)shareWithYMWexintext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image viewcontrol:(UIViewController *)UIViewC;


-(void)shareWbsinaWithimage:(NSData *)imagedata title:(NSString *)title description:(NSString *)description url:(NSString *)url;


-(void)shareYMWbsinaWithimage:(NSData *)imagedata title:(NSString *)title description:(NSString *)description url:(NSString *)url viewcontrol:(UIViewController *)UIViewC;

-(void)shareWithWXfrendtext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image;


-(void)shareWithYMWXfrendtext:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(NSData *)imagedata uiiamge:(UIImage *)image viewcontrol:(UIViewController *)UIViewC;
-(void)shareWithYmQQzone:(NSString *)text Withurl:(NSString *)url title:(NSString *)title imagedata:(UIImage *)imagedata imageurl:(NSString *)iamgeurl  viewcontrol:(UIViewController *)UIViewC;


@end
