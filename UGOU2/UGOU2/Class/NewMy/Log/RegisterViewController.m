//
//  RegisterViewController.m
//  UgouAppios
//  Created by 靓萌服饰 on 15/9/25.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*xujing2015.9.28.9.24 注册
 */

#import "RegisterViewController.h"
#import "AFManger.h"

//#import "ViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "SecurityUtil.h"
#import "MBProgressHUD.h"
//#define WIDTH  [[UIScreen mainScreen]bounds].size.width
//#define HEIGHT  [[UIScreen mainScreen]bounds].size.height

@interface RegisterViewController ()<UITextFieldDelegate>{
    NSTimer *_timer1;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
     int count;
    MBProgressHUD * HUB;
     NSUserDefaults *de;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count=0;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    [self addbutton];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}
-(void)addbutton{
    #pragma mark 2015.10.15 2.30导航栏取消 定义新的按钮
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH,40*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH)];
    label.text=@"注册";
    //居中
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:24*KIphoneWH];
    label.textColor=[UIColor colorWithRed:179/255.0 green:212/255.0 blue:101/255.0 alpha:1];
    [self.view addSubview:label];
    
    UIButton *leftbut=[[UIButton alloc]init];
    leftbut.frame=CGRectMake(10*KIphoneWH, 40*KIphoneWH, 50*KIphoneWH, 50*KIphoneWH);
    [leftbut setImage:[UIImage imageNamed:@"返回z"] forState:UIControlStateNormal];
    [leftbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    leftbut.tag=1;
    [self.view addSubview:leftbut];
    
    _ufield=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2-165*KIphoneWH, 120*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    [_ufield setBorderStyle:UITextBorderStyleNone];
    _ufield.placeholder=@"手机号";
     _ufield.clearButtonMode=YES;
    _ufield.delegate=self;
    _ufield.tag=1;
    _ufield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    _ufield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:_ufield];
    
    UIImage *img=[UIImage imageNamed:@"长线"];
    UIImageView *imv1=[[UIImageView alloc]initWithImage:img];
    imv1.frame=CGRectMake(WIDTH/2-170*KIphoneWH, 170*KIphoneWH, WIDTH-50*KIphoneWH, 5*KIphoneWH);
    [imv1 sizeToFit];
    [self.view addSubview:imv1];
    
    _mfield=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2-165*KIphoneWH, 200*KIphoneWH, WIDTH-50*KIphoneWH, 50*KIphoneWH)];
    [_mfield setBorderStyle:UITextBorderStyleNone];
    _mfield.placeholder=@"密码";
    _mfield.secureTextEntry=YES;
     _mfield.clearButtonMode=YES;
    _mfield.delegate=self;
    _mfield.tag=2;
    _mfield.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _mfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    [self.view addSubview:_mfield];
  
    UIImageView *imv2=[[UIImageView alloc]initWithImage:img];
    imv2.frame=CGRectMake(WIDTH/2-170*KIphoneWH, 245*KIphoneWH, WIDTH-50*KIphoneWH, 5*KIphoneWH);
    [imv2 sizeToFit];
    [self.view addSubview:imv2];
    
    _yfield=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2-165*KIphoneWH, 260*KIphoneWH, 150*KIphoneWH, 50*KIphoneWH)];
    [_yfield setBorderStyle:UITextBorderStyleNone];
    _yfield.placeholder=@"验证码";
    _yfield.clearButtonMode=YES;
    _yfield.delegate=self;
    _yfield.tag=3;
    _yfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    _yfield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:_yfield];
    
    _but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-150*KIphoneWH,260*KIphoneWH, 150*KIphoneWH, 50*KIphoneWH)];
    [_but setTitle:@"获取验证码" forState:UIControlStateNormal];
    _but.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [_but setTitleColor:[UIColor  colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1] forState:UIControlStateNormal];
    [_but addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    _but.tag=2;
    [self.view addSubview:_but];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-170*KIphoneWH, 260*KIphoneWH, 150*KIphoneWH, 40*KIphoneWH)];
    [self.view addSubview:_label];
    //居中
    _label.textAlignment=NSTextAlignmentCenter;
    _label.text=@"重新获取验证码";
    _label.textColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    self.label.hidden=YES;
    UIImageView *imv3=[[UIImageView alloc]initWithImage:img];
    imv3.frame=CGRectMake(WIDTH/2-170*KIphoneWH, 315*KIphoneWH, WIDTH-50*KIphoneWH, 5*KIphoneWH);
    [imv3 sizeToFit];
    [self.view addSubview:imv3];
    
    _timelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-170*KIphoneWH, 280*KIphoneWH, 150*KIphoneWH, 40*KIphoneWH)];
    _timelabel.textColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _timelabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_timelabel];
    self.timelabel.hidden=YES;
    
    UIButton *dlbut=[[UIButton alloc]init];
    dlbut.frame=CGRectMake(10*KIphoneWH, 325*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH);
    [dlbut setBackgroundImage:[UIImage imageNamed:@"注册2x"] forState:UIControlStateNormal];
    [dlbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    dlbut.tag=3;
    [self.view addSubview:dlbut];
}
#pragma mark 点击后
-(void)push:(UIButton *)but{
    //返回上一页
    if (but.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (but.tag==2){
        
        //短信验证码验证
        if ([self isMobileNumber:_ufield.text]) {
                  //上传号码
            // _ufield.text
           [self sendToSMS];
        }else{
        
            [Uikility alert:@"请填写正确的手机号"];
        }
    }else if (but.tag==3){
        //点击登录按钮
        //if else if 与if else  区别
        if (_ufield.text.length == 0) {
            [Uikility alert:@"手机号不能为空！"];
            return;
        }if (_mfield.text.length == 0){

                [Uikility alert:@"密码不能为空！"];
            return;
        }if (_yfield.text.length == 0){

                [Uikility alert:@"验证码不能为空"];
            return;
        }else{
            
            //验证
            [self commitSMS];
            
        }
    }
}


#pragma mark****************发送短信验证码
-(void)sendToSMS{
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeSendToSMS];
    NSMutableDictionary *smsDic=[Uikility creatSinGoMutableDictionary];
    [smsDic setObject:_ufield.text forKey:@"mobile"];
    NSString *jsonstr=[Uikility initWithdatajsonstring:smsDic];
    NSString *aesstr=[SecurityUtil encryptAESData:jsonstr passwordKey:AESKEY];
    
    NSDictionary *postdic=@{@"param":aesstr};
    
    [AFManger postWithURLString:url parameters:postdic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       
        BOOL sucess=[[objec objectForKey:@"success"]boolValue];
        
        if (sucess) {
            
            [self showHUB:@"获取验证码成功"];
            
            [self showlabel];
            [self addtimer];
           
            
        }else{
        
            [Uikility alert:[objec objectForKey:@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网速不佳"];
    }];
    



}

#pragma mark***************验证验证码是否正确
-(void)commitSMS{
    NSString *comitURL=[BassAPI requestUrlWithPorType:PortTypeCommitToSMS];
    NSMutableDictionary *comitDic=[Uikility creatSinGoMutableDictionary];
    [comitDic setObject:_ufield.text forKey:@"mobile"];
    [comitDic setObject:_yfield.text forKey:@"smsCode"];
    NSString *jsonstr=[Uikility initWithdatajsonstring:comitDic];
//    NSString *aesstr=[SecurityUtil encryptAESData:jsonstr passwordKey:AESKEY];
//    
    NSDictionary *postdic=@{@"param":jsonstr};
    
     [AFManger postWithURLString:comitURL parameters:postdic success:^(id responseObject) {
         id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         
         BOOL sucess=[[objec objectForKey:@"success"]boolValue];
         
         if (sucess) {
             
             [self postMethod];
         }else{
             
             [Uikility alert:[objec objectForKey:@"msg"]];
         }
         
         

         
     } failure:^(NSError *error) {
         [Uikility alert:@"当前网速不佳"];
     }];


}

#pragma mark 再次获取验证码的时间器
-(void)addtimer{
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1
                                               target:self
                                             selector:@selector(updateTime)
                                             userInfo:nil
                                              repeats:YES];
}
#pragma mark 时间改变
-(void)updateTime
{
    count++;
    _timelabel.text = [NSString stringWithFormat:@"%@%i%@",@"(",60-count,@")"];
    if (count==60) {
        [self showButton];
    }
}
#pragma mark 再次获取验证码
-(void)showButton{
    self.timelabel.hidden = YES;
    self.but.hidden = NO;
    self.label.hidden=YES;
    [_but setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    count=0;
    [_timer1 invalidate];
    return;
}
#pragma mark uibutton 和uilabel的更改
-(void)showlabel{
    self.timelabel.hidden = NO;
    self.but.hidden = YES;
    self.label.hidden=NO;
    return;
}
#pragma mark 上传数据到后台
-(void)postMethod{

    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetReg];
//    //xujing2015.9.29.9.04    //数据变json
    NSDictionary *dic=[[NSDictionary alloc] init];
    de=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    [mudic setObject:_ufield.text forKey:@"mobile"];
    [mudic setObject:_mfield.text forKey:@"pass"];
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
     if ([de objectForKey:@"placename"]){
     [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    
    }
    
    if([de objectForKey:@"token"]){
        [mudic setObject:[de objectForKey:@"token"] forKey:@"token"];
    }
    NSDictionary *json1=[Uikility initWithdatajson:mudic];
   [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
       id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
       Boolean success=[[obj objectForKey:@"success"] boolValue];
       
       if (success) {
           
           //xujing2015.9.29.2.02
           //清空  存储
           [Uikility alert:@"注册成功！"];
           
           de=[NSUserDefaults standardUserDefaults];
           
           [de setObject:[obj objectForKey:@"sessionid"] forKey:@"sessionid"];
           [de setObject:[[obj objectForKey:@"data"]objectForKey:@"mobile"]forKey:@"mobile"];
           [de setObject:[obj objectForKey:@"userId"]forKey:@"userId"];
           [de setObject:[obj objectForKey:@"newUserId"] forKey:@"newUserId"];
           [de setObject:_mfield.text forKey:@"pass"];
           //同步存储到磁盘
           [de synchronize];
           //跳到主页界面
        [self.navigationController popToRootViewControllerAnimated:YES];
       }else{
           
           
           [Uikility alert:[obj objectForKey:@"msg"]];}
   } failure:^(NSError *error) {
      [Uikility alert:@"注册失败！"];
   }];
}

#pragma mark 点击后输入按钮边框上方
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addtoolBar];
    if (textField.tag==1) {
        
        label1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 100*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label1.text=@"手机号/用户名";
        label1.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label1.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label1];
    }else if(textField.tag==2){
       
        label2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 180*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label2.text=@"密码";
        label2.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label2.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label2];
    }else if(textField.tag==3){
        
        label3=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 245*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label3.text=@"验证码";
        label3.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label3.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label3];
    }
}


#pragma mark 只允许输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==_ufield) {
        return [self validateNumber:string];
    }
    return YES;
 
}
//只许数字输入
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
#pragma mark 键盘 消失否
-(void)addtoolBar{
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30*KIphoneWH)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [_mfield setInputAccessoryView:topview];
    [_ufield setInputAccessoryView:topview];
    [_yfield setInputAccessoryView:topview];
    
}

#pragma mark 隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_mfield resignFirstResponder];
    [_ufield resignFirstResponder];
    [_yfield resignFirstResponder];
}
-(void)resignKeyboard{
    [_mfield resignFirstResponder];
    [_ufield resignFirstResponder];
    [_yfield resignFirstResponder];
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
-(void)showHUB:(NSString *)text{
    
    HUB=[[MBProgressHUD alloc] initWithView:self.view];
    //HUB.delegate=self;
    [self.view addSubview:HUB];
    HUB.mode=MBProgressHUDModeText;
    HUB.labelText=text;
    HUB.color=[UIColor blackColor];
    //[HUB hide:YES afterDelay:2];
    //[HUB show:YES];
    [HUB showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUB removeFromSuperview];
        
    }];
    //[HUB hide:<#(BOOL)#> afterDelay:<#(NSTimeInterval)#>]
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
