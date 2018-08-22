//
//  LoginViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/25.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*xujing2015.9.25.9.20 登录
 */

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UGHeader.h"
//#import "WeiboSDK.h"
#import "PMViewController.h"
#import "MyViewController.h"
//#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
//#import <UMShare/UMShare.h>
#import "BindMobileViewController.h"
#import "UMSocialQQHandler.h"
#import "AFNetworking.h"
#import "GTMBase64.h"
#import "ThreeloginModel.h"
#import "BindMobileViewController.h"
//#define WIDTH  [[UIScreen mainScreen]bounds].size.width
//#define HEIGHT  [[UIScreen mainScreen]bounds].size.height
@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>{
    
     NSDictionary *dic;
     UILabel *label3;
    UILabel *label4;
     NSUserDefaults *de;
    //TencentOAuth *_tencentoauth;
    NSArray *arr;
    NSMutableDictionary *dictionarys;

}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    dictionarys=[[NSMutableDictionary alloc] init];
    [self addbutton];
    AppDelegate *app=[[AppDelegate alloc] init];
    //app.wdelegate=self;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    de=[NSUserDefaults standardUserDefaults];
    if (_flag==1) {
        [self addimg];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;

}

-(void)addimg{
    
    //////NSLog(@"--------------");
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark 按钮控件
-(void)addbutton{
    //2015.10.15 1.30导航栏取消 定义新的按钮
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH,40*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH)];
    label.text=@"登录";
    //居中
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:24*KIphoneWH];
    label.textColor=[UIColor colorWithRed:179/255.0 green:212/255.0 blue:101/255.0 alpha:1];
    [self.view addSubview:label];
    
    UIButton *rightbut=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbut.frame=CGRectMake(WIDTH-100*KIphoneWH, 40*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH);
    [rightbut setTitle:@"注册" forState:UIControlStateNormal];
    [rightbut setTitleColor:[UIColor colorWithRed:179/255.0 green:212/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal];
    [rightbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    rightbut.tag=10;
    [self.view addSubview:rightbut];
    
    //返回按钮
    UIButton *leftbut=[[UIButton alloc]init];
    leftbut.frame=CGRectMake(10*KIphoneWH, 40*KIphoneWH, 50*KIphoneWH, 50*KIphoneWH);
    [leftbut setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [leftbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    leftbut.tag=11;
    [self.view addSubview:leftbut];
    
    _ufield=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2-165*KIphoneWH, 120*KIphoneWH, WIDTH-50*KIphoneWH, 50*KIphoneWH)];
    _ufield.tag=1;
    [_ufield setBorderStyle:UITextBorderStyleNone];
    _ufield.placeholder=@"手机号/用户名";
    _ufield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    _ufield.clearButtonMode=YES;
    _ufield.delegate=self;
    _ufield.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:_ufield];
    UIImage *img=[UIImage imageNamed:@"长线"];
    UIImageView *imv1=[[UIImageView alloc]initWithImage:img];
    imv1.frame=CGRectMake(WIDTH/2-170*KIphoneWH, 175*KIphoneWH, WIDTH-50*KIphoneWH, 5*KIphoneWH);
    [imv1 sizeToFit];
    [self.view addSubview:imv1];
 
    _mfield=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2-165*KIphoneWH, 200*KIphoneWH, WIDTH-50*KIphoneWH, 50*KIphoneWH)];
    _mfield.tag=2;
    [_mfield setBorderStyle:UITextBorderStyleNone];
    _mfield.placeholder=@"密码";
    _mfield.secureTextEntry=YES;
     _mfield.clearButtonMode=YES;
    _mfield.delegate=self;
    _mfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    _mfield.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_mfield];
    UIImageView *imv2=[[UIImageView alloc]initWithImage:img];
    imv2.frame=CGRectMake(WIDTH/2-170*KIphoneWH, 255*KIphoneWH, WIDTH-50*KIphoneWH, 5*KIphoneWH);
    [imv2 sizeToFit];
    [self.view addSubview:imv2];
    
    UIButton *dlbut=[[UIButton alloc]init];
    dlbut.frame=CGRectMake(10*KIphoneWH, 265*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH);
    [dlbut setImage:[UIImage imageNamed:@"登陆2x"] forState:UIControlStateNormal];
    [dlbut addTarget:self action:@selector(dpush) forControlEvents:UIControlEventTouchUpInside];
    dlbut.tag=12;
    [self.view addSubview:dlbut];
    UIButton *zbut=[UIButton buttonWithType:UIButtonTypeSystem];
    zbut.frame=CGRectMake(WIDTH-100*KIphoneWH, 315*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH);
    [zbut setTitle:@"忘记密码" forState:UIControlStateNormal];
    [zbut setTintColor:[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1]];
    [zbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    zbut.tag=13;
    [self.view addSubview:zbut];
     #pragma mark 第三方登录
    UIImage *imge=[UIImage imageNamed:@"短线"];
    UIImageView *imgv1=[[UIImageView alloc]initWithImage:imge];
    imgv1.frame=CGRectMake(20*KIphoneWH, HEIGHT-190*KIphoneWH, (WIDTH-130*KIphoneWH)/2, 5*KIphoneWH);
    [imgv1 sizeToFit];
    [self.view addSubview:imgv1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40*KIphoneWH, HEIGHT-215*KIphoneWH, 220*KIphoneWH, 50*KIphoneWH)];
    label2.text=@"合作账号登录";
    label2.font=[UIFont systemFontOfSize:12*KIphoneWH];
    label2.textColor=[UIColor grayColor];
    [self.view addSubview:label2];
    UIImageView *imgv2=[[UIImageView alloc]initWithImage:imge];
    imgv2.frame=CGRectMake(100*KIphoneWH+(WIDTH-130*KIphoneWH)/2, HEIGHT-190*KIphoneWH, (WIDTH-130*KIphoneWH)/2, 5*KIphoneWH);
    [imgv2 sizeToFit];
    [self.view addSubview:imgv2];
  
   
    
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
           arr=@[@"qq登录",@"微博登录",@"微信登录"];
    }else {
         arr=@[@"qq登录",@"微博登录"];
    
    }
    for (int i=0; i<arr.count; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.tag=i+1;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame=CGRectMake(20*KIphoneWH+i*((WIDTH-180*KIphoneWH)/3+70*KIphoneWH), HEIGHT-140*KIphoneWH, (WIDTH-180*KIphoneWH)/3, 70*KIphoneWH);
        [button setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
#pragma mark 2015.10.15 10.00点击后输入按钮边框上方
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addtoolBar];
    if (textField.tag==1) {
        
        label3=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 100*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label3.text=@"手机号/用户名";
        label3.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label3.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label3];
    }else if(textField.tag==2){
     
        label4=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 185*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label4.text=@"密码";
        label4.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label4.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
         [self.view addSubview:label4];
    }
}
#pragma mark *****点击三方登陆的按钮
-(void)push:(UIButton *)but{
    
    if (but.tag==10) {
        //注册界面
        
        RegisterViewController *reg=[[RegisterViewController alloc]init];
        
        //BindMobileViewController *bin=[[BindMobileViewController alloc] init];
        
        [self.navigationController pushViewController:reg  animated:YES];
        
        if ([de objectForKey:@""]) {
            
        }
        
    }else if (but.tag==11){
        //返回上一页
        
        //self.navigationController.navigationBar.hidden=NO;
      [self.navigationController popViewControllerAnimated:YES];
    //[self  dismissViewControllerAnimated:YES completion:nil];
       // [self ]
        
    }else if (but.tag==12){
        //判断 是否可以上传
        if (_ufield.text.length == 0) {

            [Uikility alert:@"手机号或用户名不能为空！"];
            return;
        }if (_mfield.text.length == 0){

            [Uikility alert:@"密码不能为空！"];
            return;
        }else{
            [self dpush];
        }
    }else if (but.tag==13){
        PMViewController *pm=[[PMViewController alloc]init];
        pm.flag=1;
        BOOL flag=[self isMobileNumber:_ufield.text];
        //判断 手机号  和用户名
        if (!flag) {

            [Uikility alert:@"请输入手机号！"];
            return;
        }else{
        pm.phone=_ufield.text;
        }
        [self.navigationController pushViewController:pm animated:YES];
       
    }else if (but.tag==1){
        //要改
        //[self qqlog];
#pragma mark-----------qq登录
        
        [self umthreeqqlog];
        
        
        
    }else if (but.tag==2){
        //要改
        
        //[self weibolog];
        [self umthreewblog];
        
       
    }else if (but.tag==3){
        
        
        
        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
            SendAuthReq *rep=[[SendAuthReq alloc]init];
            rep.scope=@"snsapi_userinfo";
            rep.state=@"123";
            [WXApi sendReq:rep];
            [self  umthreeweixinlog];
            
            }
    }
    
}
-(void)umthreewblog{
   
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
           
            [self getlogid:resp.uid withuserName:resp.name andwithUrl:nil andwithheadImg:resp.iconurl andgender:resp.gender andverified:nil  andfollowMe:nil  andlei:@"wb"];

            // 第三方平台SDK源数据
            ThreeloginModel *model=[[ThreeloginModel alloc] init];
            model.uid=resp.uid;
            model.name=resp.name;
            model.gender=resp.gender;
            model.iconurl=resp.iconurl;
            model.lei=@"wb";
            
            //[self VerifyIsThreelogin:model];
            
        }
    }];

}

-(void)umthreeqqlog{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            [self getlogid:resp.uid withuserName:resp.name andwithUrl:nil andwithheadImg:resp.iconurl andgender:resp.gender andverified:nil  andfollowMe:nil  andlei:@"qq"];
            
            // 第三方平台SDK源数据
            ThreeloginModel *model=[[ThreeloginModel alloc] init];
            model.uid=resp.uid;
            model.name=resp.name;
            model.gender=resp.gender;
            model.iconurl=resp.iconurl;
            model.lei=@"qq";
           
            //[self VerifyIsThreelogin:model];
            
        }
    }];


    
   


}

-(void)umthreeweixinlog{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
           
        } else {
            UMSocialUserInfoResponse *resp = result;
           [self getlogid:resp.uid withuserName:resp.name andwithUrl:nil andwithheadImg:resp.iconurl andgender:resp.gender andverified:nil  andfollowMe:nil  andlei:@"wx"];
            
            
            ThreeloginModel *model=[[ThreeloginModel alloc] init];
            model.uid=resp.uid;
            model.name=resp.name;
            model.gender=resp.gender;
            model.iconurl=resp.iconurl;
            model.lei=@"wx";
            
            //[self VerifyIsThreelogin:model];
            
            // 第三方平台SDK源数据
            }
    }];

    
    
    


};

#pragma mark*********  验证第三方是否绑定
-(void)VerifyIsThreelogin:(ThreeloginModel *)LogModel{
    NSMutableDictionary *logdic=[[NSMutableDictionary alloc] init];
    NSString *verlogurl=[BassAPI requestUrlWithPorType:PortTypeVerifyThreeLogin];
    [logdic setObject:LogModel.uid forKey:@"sinaId"];
    if ([LogModel.lei isEqualToString:@"wb"]) {
        [logdic setObject:@2 forKey:@"flag"];
    }else if ([LogModel.lei isEqualToString:@"qq"]){
        [logdic setObject:@3 forKey:@"flag"];
    
    }else if([LogModel.lei isEqualToString:@"wx"]){
        [logdic setObject:@4 forKey:@"flag"];
    }
    NSDictionary*jsonstr=[Uikility initWithdatajson:logdic];
    [AFManger postWithURLString:verlogurl parameters:jsonstr success:^(id responseObject) {
        id  objsct=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL sucess=[[objsct objectForKey:@"success"] boolValue];
        if (sucess) {
           
            NSNumber *mobileFlag=[[objsct objectForKey:@"data"]objectForKey:@"mobileFlag"];
            if (mobileFlag.integerValue) {
                [self getlogid:LogModel.uid withuserName:LogModel.name andwithUrl:nil andwithheadImg:LogModel.iconurl andgender:LogModel.gender andverified:nil andfollowMe:nil andlei:LogModel.lei];
            }else{
            
            BindMobileViewController *bmv=[[BindMobileViewController alloc] init];
                bmv.datamodel=LogModel;
                [self.navigationController pushViewController:bmv animated:YES];
                //[self presentViewController:bmv animated:YES completion:nil];
            }
            
        }else{
        
        
        }
        
        
       // NSLog(@"%@",objsct);
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网络出现问题"];
    }];
    

}
//微信

-(void)getAccessTokenWithCode:(NSString *)code{
    
    [Uikility alert:@"方法调用"];
    
    NSString *strurl=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAppid,WXAppSecret,code];
    NSString *str=[NSString stringWithContentsOfURL:[NSURL URLWithString:strurl] encoding:NSUTF8StringEncoding error:nil];
     ////////////////////////NSLog(@"%@",str);
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    id   d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [Uikility alert:[NSString stringWithFormat:@"%@",d]];
    if ([d objectForKey:@"errcode"]){
    }else{
        
        [Uikility alert:@"token获取成功"];
        [self getUserInfoWithAccessToken:[d objectForKey:@"access_token"] andOpenid:[d objectForKey:@"openid"]];
    
    }
        


}
//微信
-(void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenid:(NSString *)openId{
    
    NSString *strurl=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    NSString *str=[NSString stringWithContentsOfURL:[NSURL URLWithString:strurl] encoding:NSUTF8StringEncoding error:nil];
   
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    id   d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
   
    if ([d objectForKey:@"errcode"]){
        [Uikility alert:@"数据接受失败！"];
    }else{
        
        [Uikility alert:@"头像获取成功"];
        [self getlogid:openId withuserName:[d objectForKey:@"nickname"] andwithUrl:nil andwithheadImg:[d objectForKey:@"headimgurl"] andgender:[d objectForKey:@"sex"] andverified:nil andfollowMe:nil andlei:@"wx"];
            }
}



#pragma mark 正则判断是否是手机号
- (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark xujing2015.9.30.9.04   登录成功否
-(void)dpush{
    //上传数据到后台判断
    
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetLog];
    //xujing2015.10.8.10.20 区分手机号和用户名
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
  BOOL flag=[self isMobileNumber:_ufield.text];
    
    
    //判断 手机号  和用户名
    if (!flag) {
        if ([de objectForKey:@"token"]) {
            [mudic setObject:_ufield.text forKey:@"username"];
            [mudic setObject:_mfield.text forKey:@"pass"];
            [mudic setObject:@1 forKey:@"model"];
            [mudic setObject:VERSION forKey:@"ios_version"];
            [mudic setObject:[de objectForKey:@"token"] forKey:@"token"];
           // dic=@{@"username":_ufield.text,@"pass":_mfield.text,@"model":@true,@"ios_version":VERSION,@"token":[de objectForKey:@"token"]
                  //};
        }else{
            [mudic setObject:_ufield.text forKey:@"username"];
            [mudic setObject:_mfield.text forKey:@"pass"];
            [mudic setObject:@1 forKey:@"model"];
            [mudic setObject:VERSION forKey:@"ios_version"];
        //dic=@{@"username":_ufield.text,@"pass":_mfield.text,@"model":@true,@"ios_version":VERSION
              //};
        }
    }else{
        if ([de objectForKey:@"token"]) {
            [mudic setObject:_ufield.text forKey:@"mobile"];
            [mudic setObject:_mfield.text forKey:@"pass"];
            [mudic setObject:@1 forKey:@"model"];
            [mudic setObject:VERSION forKey:@"ios_version"];
            [mudic setObject:[de objectForKey:@"token"] forKey:@"token"];
           
        }else{
            [mudic setObject:_ufield.text forKey:@"mobile"];
            [mudic setObject:_mfield.text forKey:@"pass"];
            [mudic setObject:@1 forKey:@"model"];
            [mudic setObject:VERSION forKey:@"ios_version"];
            
        
        }
    }
    
    if ([de objectForKey:@"placename"]) {
        [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    }
    
    NSDictionary *json1=[Uikility initWithdatajson:mudic];
   [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
       id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
      
       Boolean success=[[obj objectForKey:@"success"] boolValue];
       //  NSString *msg=[obj objectForKey:@"msg"];
       if (success) {
           //清空 存储
           [de setObject:[obj objectForKey:@"sessionid"] forKey:@"sessionid"];
           [de setObject:[obj objectForKey:@"userId"]forKey:@"userId"];
           [de setObject:[obj objectForKey:@"newUserId"] forKey:@"newUserId"];
           if ([[obj objectForKey:@"data"] objectForKey:@"headImg"]) {
               [de setObject:[[obj objectForKey:@"data"] objectForKey:@"headImg"] forKey:@"headimg"];
           }
           if ([[obj objectForKey:@"data"] objectForKey:@"userName"]) {
               [de setObject:[[obj objectForKey:@"data"] objectForKey:@"userName"]forKey:@"username"];
               
           }
           if ([[obj objectForKey:@"data"]objectForKey:@"mobile"]) {
               
               [de setObject:[[obj objectForKey:@"data"]objectForKey:@"mobile"]forKey:@"mobile"];
           }
           [de setObject:_mfield.text forKey:@"pass"];
           //同步存储到磁盘
           [de synchronize];// 要改
           //返回到上一页
           //[self  dismissViewControllerAnimated:YES completion:nil];
           [self.navigationController popViewControllerAnimated:YES];
           [self AccessSecretKey];
       }else{
           //
           [Uikility alert:[obj objectForKey:@"msg"]];
       }

   } failure:^(NSError *error) {
       [Uikility alert:@"连接失败！"];
   }];
 }
#pragma mark******获取加密秘钥
-(void)AccessSecretKey{
  NSDictionary *d=[[NSDictionary alloc]init];
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    if ([de objectForKey:@"placename"]) {
        [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
        
    }
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    if ([de objectForKey:@"userId"]) {
        
        [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
    }
    
   d =[Uikility initWithdatajson:mudic];
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetHome];
    
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer=[AFHTTPResponseSerializer serializer];
    //manger.requestSerializer.HTTPShouldHandleCookies=YES;
    [manger POST:url parameters:d progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *respons=(NSHTTPURLResponse *)task.response;
        [de setObject:respons.allHeaderFields[@"Set-Cookie"] forKey:@"setcookie"];//setcookie
        //BindMobileViewController *bmv=[[BindMobileViewController alloc] init];
        //NSLog(@"跳转执行");
        //[self.navigationController pushViewController:bmv animated:YES];
        //[Uikility alert:@"登陆成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Uikility alert:@"请求失败"];
    }];



}
#pragma mark*********绑定手机号
-(void)bindingMobilePhone{
    
    

}
#pragma mark **********************微博登录
//-(void)weibolog{
//
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    //回调页
//    request.redirectURI = @"http://www.umeng.com/social";
//
//
//    //NSLog(@"执行了自己微博登录");
//    /**
//     微博开放平台第三方应用scope，多个scrope用逗号分隔
//
//     参考 http://open.weibo.com/wiki/%E6%8E%88%E6%9D%83%E6%9C%BA%E5%88%B6%E8%AF%B4%E6%98%8E#scope
//     */
//    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    [WeiboSDK sendRequest:request];
//
//
//}



//新浪登录
-(void)getAccessToken:(NSString *)accseeToken withUserId:(NSString *)userId{
    //用户id 必须
     // @"https://api.weibo.com/oauth2/authorize"
    NSString *url=@"https://api.weibo.com/2/users/show.json";
        //NSString *url=@"https://api.weibo.com/2/users/show.json";
        NSDictionary *dics=@{
                            @"source":@"866304116",
                            
                            @"access_token":accseeToken,
                            @"uid":userId,
                            };
    
          
    
    [AFManger getWithURLString:url parameters:dics success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
       
        if ([obj objectForKey:@"errcode"]){
            [Uikility alert:@"数据接受失败！"];
            
        }else{
            [self getlogid:userId withuserName: [obj objectForKey:@"screen_name"]andwithUrl:[obj objectForKey:@"url"]  andwithheadImg:[obj objectForKey:@"profile_image_url"] andgender:[obj objectForKey:@"gender"] andverified:[obj objectForKey:@"verified"] andfollowMe:[obj objectForKey:@"follow_me"]andlei:@"wb"];
        }

        
    } failure:^(NSError *error) {
       // NSLog(@"失败原因%@",error);
        [Uikility alert:@"请求失败！"];
    }];
    
    
    
//       [AFManger postWithURLString:url parameters:dics success:^(id responseObject) {
//           id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
//           
//           if ([obj objectForKey:@"errcode"]){
//               [Uikility alert:@"数据接受失败！"];
//               
//           }else{
//               [self getlogid:userId withuserName: [obj objectForKey:@"screen_name"]andwithUrl:[obj objectForKey:@"url"]  andwithheadImg:[obj objectForKey:@"profile_image_url"] andgender:[obj objectForKey:@"gender"] andverified:[obj objectForKey:@"verified"] andfollowMe:[obj objectForKey:@"follow_me"]andlei:@"wb"];
//           }
//
//       } failure:^(NSError *error) {
//           NSLog(@"失败原因%@",error);
//         [Uikility alert:@"请求失败！"];
//           
//       }];
    
}

//-(void)qqlog{
// _tencentoauth=[[TencentOAuth alloc]initWithAppId:@"1103583193" andDelegate:self];
// NSArray *   permissions = [NSArray arrayWithObjects:
//                    @"get_user_info",@"get_simple_userinfo",@"add_t",
//                    //                            kOPEN_PERMISSION_GET_USER_INFO,
//                    //                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                    //                            kOPEN_PERMISSION_ADD_ALBUM,
//                    //                            kOPEN_PERMISSION_ADD_IDOL,
//                    //                            kOPEN_PERMISSION_ADD_ONE_BLOG,
//                    //                            kOPEN_PERMISSION_ADD_PIC_T,
//                    //                            kOPEN_PERMISSION_ADD_SHARE,
//                    //                            kOPEN_PERMISSION_ADD_TOPIC,
//                    //                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
//                    //                            kOPEN_PERMISSION_DEL_IDOL,
//                    //                            kOPEN_PERMISSION_DEL_T,
//                    //                            kOPEN_PERMISSION_GET_FANSLIST,
//                    //                            kOPEN_PERMISSION_GET_IDOLLIST,
//                    //                            kOPEN_PERMISSION_GET_INFO,
//                    //                            kOPEN_PERMISSION_GET_OTHER_INFO,
//                    //                            kOPEN_PERMISSION_GET_REPOST_LIST,
//                    //                            kOPEN_PERMISSION_LIST_ALBUM,
//                    //                            kOPEN_PERMISSION_UPLOAD_PIC,
//                    //                            kOPEN_PERMISSION_GET_VIP_INFO,
//                    //                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
//                    //                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
//                    //                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
//                    nil];
//     [_tencentoauth authorize:permissions inSafari:NO];
//
//}

//-(void)tencentDidLogin{
//  //  _labeltitle.text=@"登录成功";
//    if (_tencentoauth.accessToken &&0!=[_tencentoauth.accessToken length]) {
//       // _labelaccesstoken.text=_tencentoauth.accessToken;
//
//
//
//
//        NSString *url=[NSString stringWithFormat:@"https://graph.qq.com/user/get_user_info?access_token=%@&oauth_consumer_key=%@&openid=%@",_tencentoauth.accessToken,_tencentoauth.appId, _tencentoauth.openId];
//
//        NSString *str=[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
//
//        NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
//
//     id   ds = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//
//        if ([ds objectForKey:@"errcode"]){
//             [Uikility alert:@"数据接受失败！"];
//
//        }else{
//            NSString *a=[ds objectForKey:@"nickname"];
//
//            ////////////////NSLog(@"1---%@",_tencentoauth.openId);
//
//
//            [self getlogid:_tencentoauth.openId withuserName:[ds objectForKey:@"nickname" ] andwithUrl:nil andwithheadImg:[ds objectForKey:@"figureurl_qq_1" ] andgender:[ds objectForKey:@"gender" ]  andverified:nil  andfollowMe:nil  andlei:@"qq"];
//
//
//        }
//
//
//    }else{
//
//        [Uikility alert:@"授权失败！"];
//    }
//
//}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {

        [Uikility alert:@"登录取消！"];
    }else{
 
        [Uikility alert:@"登录失败！"];
    }
    
}
-(void)tencentDidNotNetWork{

    [Uikility alert:@"连接失败！"];
}
#pragma mark***************自己服务器的登录
-(void)getlogid:(NSString *)userId withuserName:(NSString *)userName andwithUrl:(NSURL *)Url andwithheadImg:(NSString *)headImg andgender:(NSString *)gender andverified:(NSString *)verified andfollowMe:(NSString *)followMe andlei:(NSString *)lei{
    dictionarys=[[NSMutableDictionary alloc] init];
     //NSLog(@"------touxiang%@",headImg);
    [UGProgressHUD showLoading];
    NSString *url1=[BassAPI requestUrlWithPorType:PortTypeGetSdkLog];
    if ([lei isEqualToString:@"wb"]) {
       
        if ([de objectForKey:@"token"]) {
            [dictionarys setObject:[de objectForKey:@"token"] forKey:@"token"];
        }else{
        
        }
    
        [dictionarys setObject:userId forKey:@"sinaId"];
        [dictionarys setObject:userName forKey:@"userName"];
        //[dictionarys setObject:Url forKey:@"url"];
        [dictionarys setObject:headImg forKey:@"headImg"];
        [dictionarys setObject:gender forKey:@"gender"];
        //[dictionarys setObject:verified forKey:@"verified"];
       // [dictionarys setObject:followMe forKey:@"followMe"];
        [dictionarys setObject:@true forKey:@"model"];
        [dictionarys setObject:@2 forKey:@"flag"];
        [dictionarys setObject:VERSION forKey:@"ios_version"];
        if ([de objectForKey:@"placename"]) {
            [dictionarys setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
        
    }else if ([lei isEqualToString:@"qq"]){
        if ([de objectForKey:@"token"]) {
           [dictionarys setObject:[de objectForKey:@"token"] forKey:@"token"];
        }
        if ([de objectForKey:@"placename"]) {
            [dictionarys setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
        
        [dictionarys setObject:userId forKey:@"sinaId"];
        [dictionarys setObject:userName forKey:@"userName"];
        
        [dictionarys setObject:headImg forKey:@"headImg"];
        [dictionarys setObject:gender forKey:@"gender"];
       [dictionarys setObject:@true forKey:@"model"];
        [dictionarys setObject:@3 forKey:@"flag"];
        [dictionarys setObject:VERSION forKey:@"ios_version"];
    
    }else if ([lei isEqualToString:@"wx"]){
        if ([de objectForKey:@"token"]) {
            [dictionarys setObject:[de objectForKey:@"token"] forKey:@"token"];
        }
        [dictionarys setObject:userId forKey:@"sinaId"];
        [dictionarys setObject:userName forKey:@"userName"];
        [dictionarys setObject:headImg forKey:@"headImg"];
        [dictionarys setObject:gender forKey:@"gender"];
        [dictionarys setObject:@true forKey:@"model"];
        [dictionarys setObject:@4 forKey:@"flag"];
        [dictionarys setObject:VERSION forKey:@"ios_version"];
        if ([de objectForKey:@"placename"]) {
            [dictionarys setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
        
    }
    
    NSDictionary *json1=[Uikility initWithdatajson:dictionarys];
   
    
   [AFManger postWithURLString:url1 parameters:json1 success:^(id responseObject) {
       id obj1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       Boolean successsss=[[obj1 objectForKey:@"success"] boolValue];
    
       if (successsss) {
         
           [UGProgressHUD dismissLoading];
           [self AccessSecretKey];
          
           BOOL bindingFlag=[[obj1 objectForKey:@"bindingFlag"] boolValue];
           if (bindingFlag) {
            de=[NSUserDefaults standardUserDefaults];
           [de setObject:[obj1 objectForKey:@"sessionid"] forKey:@"sessionid"];
            [de setObject:[obj1 objectForKey:@"userId"]forKey:@"userId"];
        [de setObject:[obj1 objectForKey:@"newUserId"] forKey:@"newUserId"];
               
        [de setObject:headImg forKey:@"headimg"];
               
        if ([[obj1 objectForKey:@"data"] objectForKey:@"userName"]) {
            [de setObject:[[obj1 objectForKey:@"data"] objectForKey:@"userName"]forKey:@"username"];
            
        }
               //同步存储到磁盘
            [de synchronize];// 要改
          self.navigationController.navigationBar.hidden=NO;
            [self.navigationController popViewControllerAnimated:YES];
           }else{
               if ([[obj1 objectForKey:@"data"] objectForKey:@"userName"]) {
                   [de setObject:[[obj1 objectForKey:@"data"] objectForKey:@"userName"]forKey:@"username"];
                    [de setObject:[[obj1 objectForKey:@"data"]objectForKey:@"headImg"] forKey:@"headimg"];
               }
               
               
               
               BindMobileViewController *mobileVC=[[BindMobileViewController alloc] init];
               mobileVC.UserId=[obj1 objectForKey:@"newUserId"];
               //[de setObject:headImg forKey:@"headimg"];
               [self.navigationController pushViewController:mobileVC animated:YES];
           }
           
//        de=[NSUserDefaults standardUserDefaults];
//        [de setObject:[obj1 objectForKey:@"sessionid"] forKey:@"sessionid"];
//        [de setObject:[obj1 objectForKey:@"userId"]forKey:@"userId"];
//        [de setObject:[obj1 objectForKey:@"newUserId"] forKey:@"newUserId"];
//
//        [de setObject:headImg forKey:@"headimg"];
//
//           if ([[obj1 objectForKey:@"data"] objectForKey:@"userName"]) {
//
//
//               [de setObject:[[obj1 objectForKey:@"data"] objectForKey:@"userName"]forKey:@"username"];
//
//           }
//
//
//           //同步存储到磁盘
//           [de synchronize];// 要改
           
           
           //[Uikility alert:@"登录成功！"];
           //self.navigationController.navigationBar.hidden=NO;
            [self AccessSecretKey];
           
           
           
           
//           if ([lei isEqualToString:@"wb"]) {
//               [self.navigationController popViewControllerAnimated:YES];
//           }else{
//
//               [self.navigationController popViewControllerAnimated:YES];
//           }
           
           
           
           
       }else{
           [Uikility alert:@"登录失败！"];
           [Uikility alert:[obj1 objectForKey:@"msg"]];
       }
       
   } failure:^(NSError *error) {
       [Uikility alert:@"连接失败！"];
   }];

}


#pragma mark 键盘 完成建
-(void)addtoolBar{
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [_mfield setInputAccessoryView:topview];
    [_ufield setInputAccessoryView:topview];
    
}
-(void)resignKeyboard{
    [_mfield resignFirstResponder];
    [_ufield resignFirstResponder];
}
#pragma mark 点击空白 键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_mfield resignFirstResponder];
    [_ufield resignFirstResponder];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
