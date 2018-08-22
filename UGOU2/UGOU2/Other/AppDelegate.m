//
//  AppDelegate.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*xujing2015.9.21.9.20 导航栏 标签栏
*/

#import "AppDelegate.h"
#import "WXApi.h"
#import "MainViewController.h"
#import "BrandViewController.h"
#import "TheViewController.h"
#import "MyViewController.h"
#import "CartViewController.h"
//#import "WeiboSDK.h"
#import "UGPayManger.h"
#import "UGHeader.h"
#import "GuidancePageViewController.h"
#import "LoginViewController.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "LoginViewController.h"
#import "XHLaunchAd.h"
#import "BassAPI.h"
#import "Uikility.h"
#import "WelcomeViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <UserNotifications/UserNotifications.h>
#import "UMessage.h"
#import "SpViewController.h"
#import "UITabBar+Category.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()<UITabBarControllerDelegate,GuidancePagedelegate,WXApiDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate,welcomePagedelegate,UIAlertViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,UNUserNotificationCenterDelegate>{
    NSString *message;
    //TencentOAuth *_tencentoauh;
    XHLaunchAd*_lauchAd;
    CLLocationManager *_locationmanger;
    CGFloat latitude;
    CGFloat  longitude;
    NSInteger _p;
    AMapSearchAPI *search;
   // AMapLocationManager  *locationManager;
}
@property(nonatomic,strong) AMapLocationManager  *locationManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSInteger oldVersion = [[NSUserDefaults standardUserDefaults]integerForKey:BuildVersion];
    NSInteger newVersion  = [[Uikility getBuildVersion]integerValue];
     //[Bugly startWithAppId:@"3bf0f30c5e"];
    
    if (newVersion > oldVersion) {
        [[NSUserDefaults standardUserDefaults]setInteger:newVersion forKey:BuildVersion];
        [[NSUserDefaults standardUserDefaults]synchronize];
        WelcomeViewController *guidancePageViewController = [[WelcomeViewController alloc]init];
        guidancePageViewController.delegate = self;
        
       
        self.window.rootViewController = guidancePageViewController;
        
    }else{
        [self loadTabBar];
    }
    #pragma mark 2015.10.16.9.10 微博登录
   // [WeiboSDK enableDebugMode:YES];
    //[WeiboSDK registerApp:@"866304116"];
    //[UMessage setLogEnabled:YES];
    [UMessage startWithAppkey:UMPUSHKEY launchOptions:launchOptions httpsenable:YES ];
    //[UMessage registerForRemoteNotifications];
    [self registerAPNS];
     //[UMessage setLogEnabled:YES];
    [[UMSocialManager defaultManager]setUmSocialAppkey:@"574fee9b67e58ed3f8002e0b"];
    
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx632d6c8a00776b9d" appSecret:@"0e141405d57f49123643fd771dacc039" redirectURL:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1103583193" appSecret:@"bPTrpX2kockqgAes" redirectURL:@"http://www.umeng.com/social"];
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_Sina appKey:@"866304116" appSecret:@"cc642572970f33f26b656f7d59912208" redirectURL:@"http://www.umeng.com/social"];
     [UGPayManger setUGPayAppID];
    [self  Reversegeocoding];
    //[self loicationauthorization];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    
    return YES;
}
-(void)jPushRegis{




}
-(void)registerAPNS{
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVer >= 10) {
        // iOS 10
        [self registerPush10];
    } else {
        // iOS 8-9
        [self registerPush8to9];

    }
}
    
-(void)registerPush10{
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        }else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    

}
-(void)registerPush8to9{
    [UMessage registerForRemoteNotifications];

}

//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }

}

-(void)Reversegeocoding{
    [AMapServices sharedServices].apiKey =@"f088dc82ab494bc9b8832dd4dfa0d045";
    [[AMapServices sharedServices]setEnableHTTPS:YES];
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //[self.locationManager setLocatingWithReGeocode:YES];
    //[self.locationManager setloca]
    [self.locationManager startUpdatingLocation];

}
//高德地图成功定位
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{

    if (reGeocode.adcode) {
        NSUserDefaults *    de=[NSUserDefaults standardUserDefaults];
        [de setObject:reGeocode.adcode forKey:@"placename"];
    }else{
    
        search = [[AMapSearchAPI alloc] init];
        search.delegate = self;
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location= [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        regeo.requireExtension= YES;
        [search AMapReGoecodeSearch:regeo];
        [self.locationManager stopUpdatingLocation];
    
    
    }



}


-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
   
}
//高德地图逆地理编码成功的代理
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil){
       
        
        NSUserDefaults *    de=[NSUserDefaults standardUserDefaults];
    [de setObject:response.regeocode.addressComponent.adcode forKey:@"placename"];
        
    
    }
}
-(void)registerPushForIOS8{
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];

   


}
-(void)loadTabBar{
    [self  readXHLaunch];
    
    //_lauchAd=[[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)andDuration:4];
    _window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _window.backgroundColor=[UIColor whiteColor];
//底部导航页
    _tabbar=[[UITabBarController alloc]init];
    MainViewController *main=[[MainViewController alloc]init];
    UINavigationController *namain=[[UINavigationController alloc]initWithRootViewController:main];
    namain.tabBarItem.title=@"主页";
    namain.tabBarItem.selectedImage = [[UIImage imageNamed:@"home-选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    namain.tabBarItem.image = [[UIImage imageNamed:@"home@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _controller=main;
    BrandViewController *brand=[[BrandViewController alloc]init];
    UINavigationController *nabrand=[[UINavigationController alloc]initWithRootViewController:brand];
    nabrand.tabBarItem.title=@"品牌";
    nabrand.tabBarItem.selectedImage = [[UIImage imageNamed:@"品牌选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    nabrand.tabBarItem.image = [[UIImage imageNamed:@"品牌@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    TheViewController *the=[[TheViewController alloc]init];
    UINavigationController *nathe=[[UINavigationController alloc]initWithRootViewController:the];
    nathe.tabBarItem.title=@"主题";
    nathe.tabBarItem.selectedImage = [[UIImage imageNamed:@"主题选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    nathe.tabBarItem.image = [[UIImage imageNamed:@"主题@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MyViewController *my=[[MyViewController alloc]init];
    UINavigationController *namy=[[UINavigationController alloc]initWithRootViewController:my];
    namy.tabBarItem.title=@"我的";
    namy.tabBarItem.selectedImage = [[UIImage imageNamed:@"我的选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    namy.tabBarItem.image = [[UIImage imageNamed:@"我的@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
       CartViewController *cart=[[CartViewController alloc]init];
    UINavigationController *nacart=[[UINavigationController alloc]initWithRootViewController:cart];
    nacart.tabBarItem.selectedImage = [[UIImage imageNamed:@"购物车-选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nacart.tabBarItem.image = [[UIImage imageNamed:@"购物车1@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nacart.tabBarItem.title=@"" ;
    
    
    LoginViewController *login=[[LoginViewController alloc] init];
    UINavigationController *log=[[UINavigationController alloc]initWithRootViewController:login];
    log.tabBarItem.selectedImage = [[UIImage imageNamed:@"购物车-选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    log.tabBarItem.image = [[UIImage imageNamed:@"购物车1@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    log.tabBarItem.title=@"";
    
    _tabbar.viewControllers=@[namain,nabrand,nathe,namy,nacart];
    
    
    UITabBar *tab=[_tabbar tabBar];
    [tab setShadowImage:[UIImage new]];
    UIImage *im=[UIImage imageNamed:@"底部导航"];
    _tabbar.delegate=self;
    [tab setBackgroundImage:im];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    _window.rootViewController=_tabbar;
    _window.superview.backgroundColor=[UIColor whiteColor];
    
    [_window makeKeyAndVisible];
    [self readIsShowPushMessage];
    
}
-(void)readIsShowPushMessage{
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    [dic setObject:@0 forKey:@"min"];
    [dic setObject:@20 forKey:@"max"];
    NSDictionary *postDic=[Uikility initWithdatajson:dic];
    NSString *urlstr=[BassAPI requestUrlWithPorType:portTypeGetPushMessage];
    if (urlstr==nil) {
        return;
    }
    [AFManger postWithURLString:urlstr parameters:postDic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL issucess=[[object objectForKey:@"success"] boolValue];
        
        if (issucess) {
            //NSLog(@"%@",object);
            NSArray *dataArr=[object objectForKey:@"data"];
            for (int i=0;i<dataArr.count;i++) {
                if (i==0) {
                    NSDictionary *fistDic=[dataArr objectAtIndex:0];
                    NSString *retime=[fistDic objectForKey:@"reTime"];
                    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                    long unwrap=[def integerForKey:unwrapTime];
                    if (unwrap==0) {
                        [self.tabbar.tabBar showBadgeOnItemIdex:3];
                        [def setBool:YES forKey:@"isshowredicon"];
                    }else{
                        
                        long fistTime=retime.longLongValue;
                        if (fistTime>unwrap) {
                            [self.tabbar.tabBar showBadgeOnItemIdex:3];
                            [def setBool:YES forKey:@"isshowredicon"];
                        }
                    }
                   
                }
            }
            
        }
    } failure:^(NSError *error) {
       
    }];
    
}
-(void)creatbar{

    _window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _window.backgroundColor=[UIColor whiteColor];
#pragma mark 2015.10.16.4.00 底部导航页
    _tabbar=[[UITabBarController alloc]init];
    MainViewController *main=[[MainViewController alloc]init];
    main.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *namain=[[UINavigationController alloc]initWithRootViewController:main];
    namain.tabBarItem.title=@"主页";
    namain.tabBarItem.selectedImage = [[UIImage imageNamed:@"home-选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    namain.tabBarItem.image = [[UIImage imageNamed:@"home@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _controller=main;
    BrandViewController *brand=[[BrandViewController alloc]init];
    UINavigationController *nabrand=[[UINavigationController alloc]initWithRootViewController:brand];
    nabrand.tabBarItem.title=@"品牌";
    nabrand.tabBarItem.selectedImage = [[UIImage imageNamed:@"品牌选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    nabrand.tabBarItem.image = [[UIImage imageNamed:@"品牌@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    TheViewController *the=[[TheViewController alloc]init];
    UINavigationController *nathe=[[UINavigationController alloc]initWithRootViewController:the];
    nathe.tabBarItem.title=@"主题";
    nathe.tabBarItem.selectedImage = [[UIImage imageNamed:@"主题选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    nathe.tabBarItem.image = [[UIImage imageNamed:@"主题@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MyViewController *my=[[MyViewController alloc]init];
    UINavigationController *namy=[[UINavigationController alloc]initWithRootViewController:my];
    namy.tabBarItem.title=@"我的";
    namy.tabBarItem.selectedImage = [[UIImage imageNamed:@"我的选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    namy.tabBarItem.image = [[UIImage imageNamed:@"我的@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    CartViewController *cart=[[CartViewController alloc]init];
    UINavigationController *nacart=[[UINavigationController alloc]initWithRootViewController:cart];
    nacart.tabBarItem.selectedImage = [[UIImage imageNamed:@"购物车-选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nacart.tabBarItem.image = [[UIImage imageNamed:@"购物车1@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nacart.tabBarItem.title=@"" ;
    
    
    LoginViewController *login=[[LoginViewController alloc] init];
    UINavigationController *log=[[UINavigationController alloc]initWithRootViewController:login];
    log.tabBarItem.selectedImage = [[UIImage imageNamed:@"购物车-选中@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    log.tabBarItem.image = [[UIImage imageNamed:@"购物车1@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    log.tabBarItem.title=@"" ;
    
    _tabbar.viewControllers=@[namain,nabrand,nathe,namy,nacart];
    
    
    UITabBar *tab=[_tabbar tabBar];
    [tab setShadowImage:[UIImage new]];
    UIImage *im=[UIImage imageNamed:@"底部导航"];
    _tabbar.delegate=self;
    [tab setBackgroundImage:im];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    _window.rootViewController=_tabbar;
    
    _window.backgroundColor=[UIColor whiteColor];
    [_window makeKeyAndVisible];
    
}
-(void)readXHLaunch{
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if (iPhoneX) {
         _lauchAd=[[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT+34)andDuration:6];
    }else{
         _lauchAd=[[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)andDuration:6];
    }
   NSString *url=[BassAPI requestUrlWithPorType:PortTypeStartpicture];
    NSDictionary *dicurl=nil;
    
    if ([def objectForKey:@"placename"]) {
        dicurl=@{@"model":@1,@"ios_version":VERSION,@"area":[def objectForKey:@"placename"]};
    }else{
    
    dicurl=@{@"model":@1,@"ios_version":VERSION};
    }

    NSDictionary *jsondic=[Uikility initWithdatajson:dicurl];
 
    [AFManger postWithURLString:url parameters:jsondic success:^(id responseObject) {
        id  object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       
        Boolean  secess=[[object objectForKey:@"success"] boolValue];
            if (secess) {
                
                
            NSDictionary *dic1=[object objectForKey:@"data"];
                
                isLocation=[dic1 objectForKey:@"locationFlag"];
            NSString *imgUrlString =[dic1 objectForKey:@"images"];
           
                NSString *imgstr=[imgUrlString stringByReplacingOccurrencesOfString:@"http://139.129.116.242:80/" withString:@"https://www.ugouchina.com/"];
               
            [_lauchAd imgUrlString:imgstr options:XHWebImageRefreshCached completed:^(UIImage *image, NSURL *url) {
                //异步加载图片完成回调(若需根据图片实际尺寸,刷新广告frame,可在这里操作)
                //_lauchAd.adFrame = CGRectMake(0, 0, WIDTH, HEIGHT);
                //NSLog(@"------------------加载图片完成加载图片完成%@",imgUrlString);
               
            }];
            
        }
  
    } failure:^(NSError *error) {
        
    }];
    //_lauchAd.hideSkip=NO;
 //_lauchAd=[[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)andDuration:4];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
  

//    NSString *deviceTokenStr = [XGPush registerDevice:deviceToken account:nil successCallback:^{
//        NSLog(@"[XGDemo] register push success成功");
//    } errorCallback:^{
//        
//    }];
//   
//
//    
//    NSUserDefaults *de =[NSUserDefaults standardUserDefaults];
//    [de setObject:deviceTokenStr forKey:@"token"];
  //注册devicetoken
    
    [UMessage registerDeviceToken:deviceToken];

}



//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: 获取不到的原因%@",err];
    
    
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}
/**
 收到通知的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 */

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    
    
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    
}
//iOS10新增：处理后台点击通知的代理方法

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSArray *arr=tabBarController.viewControllers;
    
    UINavigationController *ta=arr[4];
    if (tabBarController.selectedViewController==ta) {
        NSUserDefaults *defou=[NSUserDefaults standardUserDefaults];
        if ([defou objectForKey:@"userId"]) {
            
        ta.tabBarItem.title=@"购物车";
        
        }else{
             ta.tabBarItem.title=@"购物车";
                  }
        
       }else{
        
        ta.tabBarItem.title=@"";
        
        
    }
    _controller=viewController;

}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
   
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    if (![viewController.tabBarItem.title isEqualToString:@""]) {
        
        
        
        
//        if ([def objectForKey:@"placename"]) {
//            
//        }else{
//            UIAlertView *alteview=[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请进入系统《设置》《隐私》《定位服务》中打开开关，并允许U购使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
//            
//            [alteview show];
//            
//            
//            
//            return NO;
//        
//        }
        }
    
 
    if ([viewController.tabBarItem.title isEqualToString:@""]||[viewController.tabBarItem.title isEqualToString:@"主题"]) {
        if ([def objectForKey:@"userId"]) {
            return YES;
        }else{
            //if ([def objectForKey:@"placename"]) {
                
            
            LoginViewController *log=[[LoginViewController alloc] init];
           [((UINavigationController *)tabBarController.selectedViewController) pushViewController:log animated:YES];
        
            return NO;
            //}else{
            
              //  return NO;
            //}
            
        }
    }

    return YES;

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    if(buttonIndex==0){
        [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES]; 
    
    }else if (buttonIndex==1){
      [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    
    }

   

}
-(void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{

}
-(void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed{



}
#pragma mark*******引导页的代理
-(void)showHomePage:(UIViewController *)ViewController{
    
    WelcomeViewController *guidancePageViewController = (WelcomeViewController *)ViewController;
    [guidancePageViewController.view removeFromSuperview];
    guidancePageViewController.view.backgroundColor=[UIColor whiteColor];
    _window.rootViewController=nil;
    [self loadTabBar];
    
}
#pragma mark********ios9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *string=[url absoluteString];
    
    if ([string containsString:@"ugou://www.ugouchina.com/?goodsId="]) {
        NSRange goodIdRange=[string rangeOfString:@"goodsId="];
        
        NSInteger IDLocation=goodIdRange.location+goodIdRange.length;
        
        NSString *goodIdStr=[string substringFromIndex:IDLocation];
        
        SpViewController  *sp=[[SpViewController alloc] init];
        sp.goodsId=goodIdStr;
        sp.flag=1;
        sp.hidesBottomBarWhenPushed=YES;
        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *navc=tab.selectedViewController;
        [navc pushViewController:sp animated:YES];
        return YES;
    }

    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        //BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        BOOL canHandleURL = [UGPayManger handleOpenURL:url];
       return canHandleURL;
    }
    return result;
    
    
}
#pragma mark********iOS  10
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
   NSString *string=[url absoluteString];
   
    if ([string containsString:@"ugou://www.ugouchina.com/?goodsId="]) {
        NSRange goodIdRange=[string rangeOfString:@"goodsId="];
       
        NSInteger IDLocation=goodIdRange.location+goodIdRange.length;
        
        NSString *goodIdStr=[string substringFromIndex:IDLocation];
        
        SpViewController  *sp=[[SpViewController alloc] init];
        sp.goodsId=goodIdStr;
        sp.flag=1;
        sp.hidesBottomBarWhenPushed=YES;
       UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *navc=tab.selectedViewController;
        
        [navc pushViewController:sp animated:YES];
        
        
       
        return YES;
    }
    
    
   BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        //调用其他SDK，例如支付宝SDK等
        
            //BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
         BOOL canHandleURL = [UGPayManger handleOpenURL:url];
            return canHandleURL;

    }
    return result;
    
}
#pragma mark********* 其他应用程序打开时调用（iOS9 以下）
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *string=[url absoluteString];
    if ([string containsString:@"ugou://www.ugouchina.com/?goodsId="]) {
        NSRange goodIdRange=[string rangeOfString:@"goodsId="];
        
        NSInteger IDLocation=goodIdRange.location+goodIdRange.length;
        
        NSString *goodIdStr=[string substringFromIndex:IDLocation];
        
        SpViewController  *sp=[[SpViewController alloc] init];
        sp.goodsId=goodIdStr;
        sp.flag=1;
        sp.hidesBottomBarWhenPushed=YES;
        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *navc=tab.selectedViewController;
        [navc pushViewController:sp animated:YES];
                return YES;
    }
    

//    if ([string hasPrefix:@"wb"]) {
//
//         //return [WeiboSDK handleOpenURL:url delegate:self];
//    }else if ([string hasPrefix:@"tencentopenapi"]){
//
//       // return [TencentOAuth HandleOpenURL:url];
//
//    }else {
        return [WXApi handleOpenURL:url delegate:self];
    //}
   
   
}
#pragma mark 接受微博数据然后上传给后台并得到数据
//-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
//    NSLog(@"hcdsbcdbcsncndsjkbcsdnscsdvjhcbsd");
//    if ((int)response.statusCode==-1) {
//        
//    }else{
//        if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
//        {
//        
//        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
//        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
//        if (accessToken)
//        {    Uikility *kiv=[[Uikility alloc] init];
//             kiv.accessToken = accessToken;
//        }
//        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
//        if (userID) {
//            Uikility *kiv=[[Uikility alloc] init];
//           kiv.wbCurrentUserID = userID;
//            
//        }
//        } else if ([response isKindOfClass:WBAuthorizeResponse.class])
//        {
//     NSString *str =[NSString stringWithFormat:@"%@", [(WBAuthorizeResponse *)response userID]];
//    NSString *wbRefreshToken = [(WBAuthorizeResponse *)response accessToken];
//            
//        LoginViewController *log=[[LoginViewController alloc]init];
//        [log getAccessToken:wbRefreshToken withUserId:str];
//    
//            
//        }
//    }
//}

-(void)onReq:(BaseReq *)req{

      



}

-(void)onResp:(BaseResp *)resp{
    if (resp.errCode==0){
        
        SendAuthResp *aresp=(SendAuthResp *)resp;
       // [Uikility alert:@"微信返回，获取code"];
        LoginViewController *login=[[LoginViewController alloc] init];
        [login getAccessTokenWithCode:aresp.code];
    }else if (resp.errCode==-4)
    {
       
    }else if(resp.errCode==-2){
        
    
    }


}
- (void)tencentDidNotLogin:(BOOL)cancelled{


    [Uikility alert:@"你已取消操作"];

}
- (void)tencentDidLogin{

    [Uikility alert:@"授权成功"];
   

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //////////////////NSLog(@"从后台进入前台");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manger=[SDWebImageManager sharedManager];
    //NSLog(@"内存警告");
    //取消下载
    //[manger cancelAll];
    //清除内存中的所有图片
   // [manger.imageCache clearMemory];
    //清除磁盘空间
    //[manger.imageCache cleanDisk];
}

@end
