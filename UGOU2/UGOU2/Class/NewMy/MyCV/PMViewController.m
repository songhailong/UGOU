//
//  PMViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/3.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.3.10.44 手机号 密码
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "PMViewController.h"
#import "AFManger.h"
#import "XgViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "SecurityUtil.h"
#import "MBProgressHUD.h"
@interface PMViewController ()<UITextFieldDelegate>{
    UITextField *pfield;
    UITextField *yfield;
    UITextField *jfield;
    UITextField *xfield;
    UITextField *mfield;
    UITextField *zfield;
    UIButton *_but;
    UILabel *_label;
    UILabel *_timelabel;
     NSTimer *_timer1;
    UIButton *dlbut;
    NSDictionary *dic;
    NSString *url;
    // de;
    UILabel *titlelabel;
    MBProgressHUD *HUB;
     int count;
  
}
@end

@implementation PMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count=0;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden=NO;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(push:)];
    leftButton.tag=1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftButton;
   titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    titlelabel.textColor=[UIColor whiteColor];
    
    titlelabel.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=titlelabel;
    UIImage *img=[UIImage imageNamed:@"昵称下分割线"];
    for (int i=0; i<2; i++) {
        UIImageView *imv1=[[UIImageView alloc]initWithImage:img];
        imv1.frame=CGRectMake(10, 80*KIphoneWH*i+80*KIphoneWH, WIDTH-50*KIphoneWH, 5*KIphoneWH);
        [imv1 sizeToFit];
        [self.view addSubview:imv1];
    }
    dlbut=[[UIButton alloc]init];
    dlbut.frame=CGRectMake(10*KIphoneWH, 180*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH);
    [dlbut setBackgroundImage:[UIImage imageNamed:@"完--成"] forState:UIControlStateNormal];
    [dlbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dlbut];
    if (_flag==1) {
        [self addphoneview];
    }else if (_flag==2) {
         [self addphoneview];
    }else if(_flag==3) {
        [self addpassview];
    }
   
    // Do any additional setup after loading the view.
}
#pragma mark 手机号 忘记密码
-(void)addphoneview{
        dlbut.tag=3;
    if (_flag==1) {
        titlelabel.text=@"忘记密码";

        mfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 40*KIphoneWH, WIDTH-70*KIphoneWH, 30*KIphoneWH)];
        [mfield setBorderStyle:UITextBorderStyleNone];
        mfield.placeholder=@"新密码";
        mfield.clearButtonMode=YES;
        mfield.delegate=self;
        mfield.tag=5;
        mfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
        mfield.keyboardType=UIKeyboardTypeDefault ;
        [self.view addSubview:mfield];
    }else{
        titlelabel.text=@"修改手机号";

    pfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 40*KIphoneWH, WIDTH-70*KIphoneWH, 30*KIphoneWH)];
    [pfield setBorderStyle:UITextBorderStyleNone];
    pfield.placeholder=@"手机号";
    pfield.clearButtonMode=YES;
    pfield.delegate=self;
    pfield.tag=1;
    pfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    pfield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:pfield];
    }
   
    yfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 110*KIphoneWH,100*KIphoneWH, 30*KIphoneWH)];
    [yfield setBorderStyle:UITextBorderStyleNone];
    yfield.placeholder=@"验证码";
    yfield.clearButtonMode=YES;
    yfield.delegate=self;
    yfield.tag=2;
    yfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    yfield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:yfield];
    _but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-150*KIphoneWH,110*KIphoneWH, 150*KIphoneWH, 40*KIphoneWH)];
    [_but setTitle:@"获取验证码" forState:UIControlStateNormal];
    _but.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [_but setTitleColor:[UIColor  colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1] forState:UIControlStateNormal];
    [_but addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    _but.tag=2;
    [self.view addSubview:_but];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-170*KIphoneWH, 100*KIphoneWH, 150*KIphoneWH, 30*KIphoneWH)];
    [self.view addSubview:_label];
    //居中
    _label.textAlignment=NSTextAlignmentCenter;
    _label.text=@"重新获取验证码";
    _label.textColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _label.hidden=YES;
    _label.font=[UIFont systemFontOfSize:18*KIphoneWH];
    _timelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-170*KIphoneWH, 120*KIphoneWH, 150*KIphoneWH, 30*KIphoneWH)];
    _timelabel.textColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _timelabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_timelabel];
    _timelabel.hidden=YES;
    
   
}
#pragma mark 点击后
-(void)push:(UIButton *)but{
    //返回上一页
    if (but.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (but.tag==2){
        if (_flag==1) {
            [self sendToSMS:_phone];
            
        }else if(_flag==2){
            //短信验证码验证
            if (pfield.text.length!=11) {
               [Uikility alert:@"手机号输入错误！"];
            }
            else{
                //上传号码
                [self sendToSMS:pfield.text];
                
            }

        
        }
    }else if (but.tag==3){
        //点击登录按钮
//        //if else if 与if else  区别
        if (_flag==1) {
//            //忘记密码
            if (mfield.text.length == 0) {
              [Uikility alert:@"新密码不能为空！"];
                return;
            }
            if (yfield.text.length == 0){
                 [Uikility alert:@"验证码不能为空！"];
                    return;
            }else{
                [self commitCode:_phone smsCode:yfield.text];
//                [SMSSDK commitVerificationCode:yfield.text phoneNumber:_phone zone:@"86" result:^(NSError *error) {
//                    
//                    if (!error) {
//                        
//                       [self post];
//                        
//                    }
//                    else
//                    {
//                        
//                        
//                       [Uikility alert:@"验证失败！"];
//                        
//                    }
//                    
//                    
//                    
//                }];
                
                
                
            }
        }else if(_flag==2){
            if (pfield.text.length == 0) {
                //更换手机号
              [Uikility alert:@"手机号不能为空！"];
                return;
            }
            if (yfield.text.length == 0){
                  [Uikility alert:@"验证码不能为空！"];
                    return;
            }else{
                [self commitCode:pfield.text smsCode:yfield.text];
                               
            }
         }

      }else if (but.tag==4){
        //点击登录按钮
        //if else if 与if else  区别
        if (jfield.text.length == 0) {
         [Uikility alert:@"旧密码不能为空！"];
            return;
        }if (xfield.text.length == 0){
          [Uikility alert:@"新密码不能为空！"];
            return;
        }else{
        //判断
            [self post];
        }
    }
}




-(void)sendToSMS:(NSString *)iphneNumber{

    NSString *sendurl=[BassAPI requestUrlWithPorType:PortTypeSendToSMS];
    NSMutableDictionary *smsDic=[Uikility creatSinGoMutableDictionary];
    [smsDic setObject:iphneNumber forKey:@"mobile"];
    NSString *jsonstr=[Uikility initWithdatajsonstring:smsDic];
    NSString *aesstr=[SecurityUtil encryptAESData:jsonstr passwordKey:AESKEY];
    
    NSDictionary *postdic=@{@"param":aesstr};
    
    [AFManger postWithURLString:sendurl parameters:postdic success:^(id responseObject) {
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
-(void)commitCode:(NSString*)iphneNumber smsCode:(NSString *)smsCode{
    NSString *comitURL=[BassAPI requestUrlWithPorType:PortTypeCommitToSMS];
    NSMutableDictionary *comitDic=[Uikility creatSinGoMutableDictionary];
    [comitDic setObject:iphneNumber forKey:@"mobile"];
    [comitDic setObject:smsCode forKey:@"smsCode"];
    NSString *jsonstr=[Uikility initWithdatajsonstring:comitDic];
    NSDictionary *postdic=@{@"param":jsonstr};
    
    [AFManger postWithURLString:comitURL parameters:postdic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        BOOL sucess=[[objec objectForKey:@"success"]boolValue];
        
        if (sucess) {
            
           [self post];
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
    _timelabel.hidden = YES;
    _but.hidden = NO;
    _label.hidden=YES;
    [_but setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    count=0;
    [_timer1 invalidate];
    return;
}
#pragma mark uibutton 和uilabel的更改
-(void)showlabel{
    _timelabel.hidden = NO;
    _but.hidden = YES;
   _label.hidden=NO;
    return;
}


#pragma mark 点击后输入按钮边框上方
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addtoolBar];
    if (textField.tag==1) {
        
      UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 20*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label1.text=@"手机号";
        label1.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label1.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label1];
    }else if(textField.tag==2){
    
     UILabel *  label3=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 90*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label3.text=@"验证码";
        label3.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label3.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label3];
    }else  if (textField.tag==3) {
        
        UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 20*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label2.text=@"旧密码";
        label2.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label2.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label2];
    }else if(textField.tag==4){
        
        UILabel *  label4=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 90*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label4.text=@"新密码";
        label4.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label4.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label4];
    }else if(textField.tag==5){
        
        UILabel *  label4=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-170*KIphoneWH, 20*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
        label4.text=@"新密码";
        label4.font=[UIFont systemFontOfSize:12*KIphoneWH];
        label4.textColor=[UIColor colorWithRed:254/255.0 green:202/255.0 blue:57/255.0 alpha:1];
        [self.view addSubview:label4];
    }
}

#pragma mark 只允许输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==pfield) {
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
    [pfield setInputAccessoryView:topview];
    [yfield setInputAccessoryView:topview];
    [jfield setInputAccessoryView:topview];
    [xfield setInputAccessoryView:topview];
    [mfield setInputAccessoryView:topview];
    
}

//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [pfield resignFirstResponder];
    [yfield resignFirstResponder];
    [jfield resignFirstResponder];
    [xfield resignFirstResponder];
    [mfield resignFirstResponder];
    
}
-(void)resignKeyboard{
    [pfield resignFirstResponder];
    [yfield resignFirstResponder];
    [jfield resignFirstResponder];
    [xfield resignFirstResponder];
    [mfield resignFirstResponder];
}
#pragma mark 修改密码
-(void)addpassview{
     titlelabel.text=@"修改密码";
    dlbut.tag=4;
    jfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 40*KIphoneWH, WIDTH-70*KIphoneWH, 30*KIphoneWH)];
    [jfield setBorderStyle:UITextBorderStyleNone];
    jfield.placeholder=@"旧密码";
    jfield.clearButtonMode=YES;
    jfield.delegate=self;
    jfield.tag=3;
    jfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    jfield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:jfield];
    
    xfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 110*KIphoneWH,WIDTH-70*KIphoneWH, 30*KIphoneWH)];
    [xfield setBorderStyle:UITextBorderStyleNone];
    xfield.placeholder=@"新密码";
    xfield.clearButtonMode=YES;
    xfield.delegate=self;
    xfield.tag=4;
    //xfield.secureTextEntry=YES;
    xfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    xfield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:xfield];

}
#pragma mark 上传数据到后台
-(void)post{
 NSUserDefaults * de = [NSUserDefaults standardUserDefaults];
    //if ([de objectForKey: @"userId"]) {
        
    
    if (_flag==3) {
        url=[BassAPI requestUrlWithPorType:PortTypeGetUpPass];
        //    //xujing2015.9.29.9.04    //数据变json
        if ([de objectForKey:@"userId"]) {
            if ([de objectForKey:@"newUserId"]) {
                dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"pass":jfield.text,@"newPass":xfield.text,@"model":@1,@"ios_version":VERSION
                      };
            }else{
            
                dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"pass":jfield.text,@"newPass":xfield.text,@"model":@1,@"ios_version":VERSION
                      };
            }
   
        }else{
            return;
        
        }
    }else if (_flag==2){
        url=[BassAPI requestUrlWithPorType:PortTypeGetUpMobile];
    //    //xujing2015.9.29.9.04    //数据变json
        if ([de objectForKey:@"userId"]) {
            if ([de objectForKey:@"newUserId"]) {
                dic=@{@"mobile":pfield.text,@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"model":@1,@"ios_version":VERSION
                      };
            }else{
                dic=@{@"mobile":pfield.text,@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"model":@1,@"ios_version":VERSION
                      };
            
            }
        
    
        }else{
        
            return;
        }
    }else if (_flag==1){
         url=[BassAPI requestUrlWithPorType:PortTypeChangePassWorde];
        dic=@{@"mobile":_phone,@"pass":mfield.text,@"model":@1,@"ios_version":VERSION};
    }
   
    NSDictionary *json1=[Uikility initWithdatajson:dic];
    
        [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
            Boolean success=[[obj objectForKey:@"success"] boolValue];
            
            if (success) {
                
                //跳回
                if (_flag==1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    if (_flag==2) {
                        //  存储
                        [de setObject:[obj objectForKey:@"sessionid"] forKey:@"sessionid"];
                        [de setObject:pfield.text forKey:@"mobile"];
                        //同步存储到磁盘
                        [de synchronize];
                    }else if(_flag==3){
                        [de setObject:xfield.text forKey:@"pass"];
                        //同步存储到磁盘
                        [de synchronize];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [Uikility alert:[obj objectForKey:@"msg"]];
            }

            
        } failure:^(NSError *error) {
            [Uikility alert:@"连接失败！"];
        }];
    

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
