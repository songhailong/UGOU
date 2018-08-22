//
//  BindMobileViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/2/5.
//
//

#import "BindMobileViewController.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "MyViewController.h"
#import "AFNetworking.h"
#import "UGHeader.h"
#import "SecurityUtil.h"
@interface BindMobileViewController ()<MBProgressHUDDelegate,UGCustomnNavViewDelegate>{
    
    UITextField *_iphnefield;
    UITextField *_codefileld;
    UITextField * _passWordFileld;
    UIButton *_obtainBut;
    NSInteger timeCount;
    NSTimer *time;
    MBProgressHUD *HUB;
    UIView *Allview;
    NSUserDefaults *de;

}
@property(nonatomic,strong)dispatch_source_t  timer;
@end

@implementation BindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self creatNat];
    timeCount=60;
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatNat];
}
-(void)creatNat{
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
   UGCustomNavView  *customNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [customNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
   // [customNav.leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
    customNav.title=@"绑定手机号";
    customNav.titleView.textColor=[UIColor whiteColor];
    customNav.titleView.font=[UIFont systemFontOfSize:20];
    customNav.Delegate=self;
    [self.view addSubview:customNav];
}
#pragma mark******左边的代理
-(void)LeftItemAction{
    //[self.navigationController  popToRootViewControllerAnimated:YES];
}
-(void)creatUI{
    Allview=[[UIView alloc] initWithFrame:self.view.bounds];
    Allview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:Allview];
    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction)];
    [Allview addGestureRecognizer:ges];
    
    UILabel *nameLable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH+NavHeight, 120*KIphoneWH, 50*KIphoneWH)];
    nameLable.text=@"手 机 号:";
    nameLable.textColor=[UIColor blackColor];
    UILabel *codeLable=[[UILabel alloc] init];
    //WithFrame:CGRectMake(10*KIphoneWH, 55*KIphoneWH+NavHeight, 100*KIphoneWH, 50*KIphoneWH)];
    codeLable.text=@"验 证 码:";
    codeLable.textColor=[UIColor blackColor];
    UILabel *passWLable=[[UILabel alloc] init];
    passWLable.text=@"密    码:";
    passWLable.textColor=[UIColor blackColor];
    
    [Allview addSubview:passWLable];
    [Allview addSubview:nameLable];
    [Allview addSubview:codeLable];
    _iphnefield=[[UITextField alloc] initWithFrame:CGRectMake(110*KIphoneWH, 5*KIphoneWH+NavHeight, WIDTH-110*KIphoneWH, 50*KIphoneWH)];
    _iphnefield.placeholder=@"请输入手机号";
    _iphnefield.textColor=[UIColor colorWithRed:150/255.0 green:143/255.0 blue:156/255.0 alpha:1];
    _iphnefield.font=[UIFont systemFontOfSize:20*KIphoneWH];
    _iphnefield.keyboardType=UIKeyboardTypeNumberPad;
    
    _codefileld=[[UITextField alloc] initWithFrame:CGRectMake(110*KIphoneWH, 55*KIphoneWH+NavHeight, WIDTH-220*KIphoneWH, 50*KIphoneWH)];
    _codefileld.placeholder=@"请输入验证码";
    _codefileld.textColor=[UIColor colorWithRed:150/255.0 green:143/255.0 blue:156/255.0 alpha:1];
    _codefileld.font=[UIFont systemFontOfSize:20*KIphoneWH];
    _codefileld.keyboardType=UIKeyboardTypeNumberPad;
    
    _passWordFileld=[[UITextField alloc] init];
    _passWordFileld.placeholder=@"请设置密码";
    _passWordFileld.textColor=UGColor(150, 143, 156);
    _passWordFileld.font=[UIFont systemFontOfSize:20*KIphoneWH];
    _passWordFileld.clearsOnBeginEditing=YES;
    _passWordFileld.secureTextEntry=YES;
    _passWordFileld.keyboardType=UIKeyboardTypeDefault;
    _passWordFileld.returnKeyType=UIReturnKeyDone;
    _passWordFileld.clearButtonMode=UITextFieldViewModeWhileEditing;
    _obtainBut=[[UIButton alloc] init];
               // WithFrame:CGRectMake(WIDTH-110*KIphoneWH, 60*KIphoneWH+NavHeight, 100*KIphoneWH, 40*KIphoneWH)];
    [_obtainBut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_obtainBut setTitleColor:[UIColor colorWithRed:28/255.0 green:180/255.0 blue:73/255.0 alpha:1] forState:UIControlStateNormal];
    _obtainBut.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    _obtainBut.layer.cornerRadius=4*KIphoneWH;
    _obtainBut.layer.borderWidth=1*KIphoneWH;
    _obtainBut.layer.borderColor=[UIColor colorWithRed:28/255.0 green:180/255.0 blue:73/255.0 alpha:1].CGColor;
    [_obtainBut addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [Allview addSubview:_obtainBut];
    [Allview addSubview:nameLable];
    [Allview  addSubview:codeLable];
    [Allview addSubview:_iphnefield];
    [Allview addSubview:_codefileld];
    [Allview addSubview:_passWordFileld];
    UIButton * submitBut=[[UIButton alloc] init];
    [Allview addSubview:submitBut];
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    submitBut.backgroundColor=[UIColor colorWithRed:180/255.0 green:211/255.0 blue:117/255.0 alpha:1];
    submitBut.titleLabel.textAlignment=NSTextAlignmentCenter;
    [submitBut addTarget:self action:@selector(submitBut) forControlEvents:UIControlEventTouchUpInside];
    submitBut.translatesAutoresizingMaskIntoConstraints=NO;
    passWLable.translatesAutoresizingMaskIntoConstraints=NO;
    _passWordFileld.translatesAutoresizingMaskIntoConstraints=NO;
    codeLable.translatesAutoresizingMaskIntoConstraints=NO;
    _codefileld.translatesAutoresizingMaskIntoConstraints=NO;
    _obtainBut.translatesAutoresizingMaskIntoConstraints=NO;
    [passWLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLable.mas_bottom).with.offset(0);
        make.left.mas_equalTo(10*KIphoneWH);
        make.height.mas_equalTo(50*KIphoneWH);
        make.width.mas_equalTo(100*KIphoneWH);
    }];
    [_passWordFileld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWLable.mas_right).with.offset(0);
        make.top.equalTo(_iphnefield.mas_bottom).with.offset(0);
        make.right.mas_equalTo(-10*KIphoneWH);
        make.height.mas_equalTo(50*KIphoneWH);
    }];
    [codeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*KIphoneWH);
        make.top.equalTo(passWLable.mas_bottom).with.offset(0);
        make.width.mas_equalTo(100*KIphoneWH);
        make.height.mas_equalTo(50*KIphoneWH);
    }];
    [_obtainBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passWordFileld.mas_bottom).with.offset(5*KIphoneWH);
        make.right.mas_equalTo(-10*KIphoneWH);
        make.width.mas_equalTo(100*KIphoneWH);
        make.height.mas_equalTo(40*KIphoneWH);
    }];
    [_codefileld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeLable.mas_right).with.offset(0);
        make.right.equalTo(_obtainBut.mas_left).with.offset(0);
        make.top.equalTo(_passWordFileld.mas_bottom).with.offset(0);
        make.height.mas_equalTo(50*KIphoneWH);
    }];
    [submitBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codefileld.mas_bottom).with.offset(60*KIphoneWH);
        //        make.left.equalTo(supview.mas_left).width.offset(20*KIphoneWH);
        //make.right.equalTo(supview.mas_right).width.offset(-20*KIphoneWH);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50*KIphoneWH);
    }];
    
    
}
-(void)showHUB:(NSString *)text{
    
    HUB=[[MBProgressHUD alloc] initWithView:Allview];
    HUB.delegate=self;
    [Allview addSubview:HUB];
    HUB.mode=MBProgressHUDModeText;
    HUB.labelText=text;
    HUB.color=[UIColor blackColor];
    //[HUB hide:YES afterDelay:2];
    //[HUB show:YES];
     [HUB showAnimated:YES whileExecutingBlock:^{
         sleep(2);
     } completionBlock:^{
         [HUB removeFromSuperview];
         
     }];
    //[HUB hide:<#(BOOL)#> afterDelay:<#(NSTimeInterval)#>]
}
-(void)backleft{

}
//判断是不是手机号
- (BOOL)isMobileNumber:(NSString *)mobileNum{
        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";

    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    
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

#pragma mark*********处处键盘
-(void)tapGesAction{
    [_codefileld resignFirstResponder];
    [_iphnefield resignFirstResponder];
    [_passWordFileld resignFirstResponder];
    
}
#pragma mark********提交验证码
-(void)submitBut{
    [_codefileld resignFirstResponder];
    [_iphnefield resignFirstResponder];
    [_passWordFileld resignFirstResponder];
    if([_codefileld.text isEqualToString:@""]){
        [Uikility alert:@"请填写验证码"];
       
        return;
    }
    if ([_passWordFileld.text isEqualToString:@""]) {
        [self showHUB:@"请设置密码"];
        return;
    }
    [self commitValidationSMS];
//    [SMSSDK commitVerificationCode:_codefileld.text phoneNumber:_iphnefield.text zone:@"86" result:^(NSError *error) {
//        if (!error) {
//            
//            [self  getSucessThreeLog];
//        }
//        else
//        {
//            [self showHUB:@"验证码错误"];
//            
//        }
//
//    }];

}

-(void)getSucessThreeLog{
    de=[NSUserDefaults standardUserDefaults];
  NSMutableDictionary *  dictionarys=[[NSMutableDictionary alloc] init];
    NSString *url1=[BassAPI requestUrlWithPorType:PortTypeGetSdkLog];
    
    [dictionarys setObject:_datamodel.uid forKey:@"sinaId"];
    [dictionarys setObject:_datamodel.name forKey:@"userName"];
    [dictionarys setObject:_datamodel.iconurl forKey:@"headImg"];
    [dictionarys setObject:_datamodel.gender forKey:@"gender"];
    [dictionarys setObject:_iphnefield.text forKey:@"mobile"];
    [dictionarys setObject:@true forKey:@"model"];
    [dictionarys setObject:VERSION forKey:@"ios_version"];
    if ([de objectForKey:@"placename"]) {
        [dictionarys setObject:[de objectForKey:@"placename"] forKey:@"area"];
    }
    if ([de objectForKey:@"token"]) {
    [dictionarys setObject:[de objectForKey:@"token"] forKey:@"token"];
    }
   if ([_datamodel.lei  isEqualToString:@"wb"]) {
        [dictionarys setObject:@2 forKey:@"flag"];
       
    }else if ([_datamodel.lei isEqualToString:@"qq"])
    {
    [dictionarys setObject:@3 forKey:@"flag"];
    }else if ([_datamodel.lei isEqualToString:@"wx"]){
    
    [dictionarys setObject:@4 forKey:@"flag"];
    
    }
    
    NSDictionary *json1=[Uikility initWithdatajson:dictionarys];
    [AFManger postWithURLString:url1 parameters:json1 success:^(id responseObject) {
        id obj1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Boolean successsss=[[obj1 objectForKey:@"success"] boolValue];
        
        if (successsss) {
            de=[NSUserDefaults standardUserDefaults];
            [de setObject:[obj1 objectForKey:@"sessionid"] forKey:@"sessionid"];
            [de setObject:[obj1 objectForKey:@"userId"]forKey:@"userId"];
            [de setObject:[obj1 objectForKey:@"newUserId"] forKey:@"newUserId"];
            [de setObject:_datamodel.iconurl forKey:@"headimg"];
            
            if ([[obj1 objectForKey:@"data"] objectForKey:@"userName"]) {
            [de setObject:[[obj1 objectForKey:@"data"] objectForKey:@"userName"]forKey:@"username"];
                
            }
            
            
            //同步存储到磁盘
            [de synchronize];// 要改
            
            
            //[Uikility alert:@"登录成功！"];
            self.navigationController.navigationBar.hidden=NO;
            [self AccessSecretKey];
            [self.navigationController popToRootViewControllerAnimated:YES];
           }else{
            [Uikility alert:@"登录失败！"];
        }
        
    } failure:^(NSError *error) {
        [Uikility alert:@"连接失败！"];
    }];



}
#pragma mark***************验证验证码是否正确
-(void)commitValidationSMS{
    NSString *comitURL=[BassAPI requestUrlWithPorType:PortTypeCommitToSMS];
    NSMutableDictionary *comitDic=[Uikility creatSinGoMutableDictionary];
    [comitDic setObject:_iphnefield.text forKey:@"mobile"];
    [comitDic setObject:_codefileld.text forKey:@"smsCode"];
    NSString *jsonstr=[Uikility initWithdatajsonstring:comitDic];
    //    NSString *aesstr=[SecurityUtil encryptAESData:jsonstr passwordKey:AESKEY];
    //
    NSDictionary *postdic=@{@"param":jsonstr};
    
    [AFManger postWithURLString:comitURL parameters:postdic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        BOOL sucess=[[objec objectForKey:@"success"]boolValue];
        
        if (sucess) {
            //[self showHUB:@"验证成功"];
            [self ug_BindPhoneNumberWithphoneNumber:_iphnefield.text logPassWord:_passWordFileld.text];
          //[]
        }else{
            
            //[Uikility alert:[objec objectForKey:@"msg"]];
            [self showHUB:[objec objectForKey:@"msg"]];
        }
        
        
        
        
    } failure:^(NSError *error) {
        //[Uikility alert:@"当前网速不佳"];
        [self showHUB:@"当前网速不佳"];
    }];
    
    
}
#pragma mark*****绑定手机号
-(void)ug_BindPhoneNumberWithphoneNumber:(NSString *)phoneNumber logPassWord:(NSString *)logpassWord{
    NSString *utlstr=[BassAPI requestUrlWithPorType:PortTypeGetReg];
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    [dic setObject:phoneNumber forKey:@"mobile"];
    [dic setObject:logpassWord forKey:@"pass"];
    [dic setObject:_UserId forKey:@"newUserId"];
    NSDictionary *postdic=[Uikility initWithdatajson:dic];
    [AFManger postWithURLString: utlstr parameters:postdic success:^(id responseObject) {
        id  object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL sucessful=[[object objectForKey:@"success"] boolValue];
        //NSLog(@"===绑定%@",object);
        if (sucessful) {
            
            
            de=[NSUserDefaults standardUserDefaults];
            [de setObject:[object objectForKey:@"sessionid"] forKey:@"sessionid"];
            [de setObject:[object objectForKey:@"userId"]forKey:@"userId"];
            //同步存储到磁盘
            [de synchronize];// 要改
            
            
            NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
            //[self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self showHUB:[object objectForKey:@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        [self showHUB:@"网速不佳"];
    }];
    
}
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
        //[self.navigationController pushViewController:bmv animated:YES];
        //[Uikility alert:@"登陆成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Uikility alert:@"请求失败"];
    }];




}
#pragma mark**********获取验证码
-(void)getVerificationCode:(UIButton *)btn{
    if (btn.selected) {
        return ;
    }
    //btn.selected=YES;
    if ([self isMobileNumber:_iphnefield.text]) {
        
    
    [_codefileld resignFirstResponder];
    [_iphnefield resignFirstResponder];
        [_passWordFileld resignFirstResponder];
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeSendToSMS];
        NSMutableDictionary *smsDic=[Uikility creatSinGoMutableDictionary];
        [smsDic setObject:_iphnefield.text forKey:@"mobile"];
        NSString *jsonstr=[Uikility initWithdatajsonstring:smsDic];
        NSString *aesstr=[SecurityUtil encryptAESData:jsonstr passwordKey:AESKEY];
        
        NSDictionary *postdic=@{@"param":aesstr};
        [AFManger postWithURLString:url parameters:postdic success:^(id responseObject) {
            id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            BOOL sucess=[[objec objectForKey:@"success"]boolValue];
            
            if (sucess) {
            btn.selected=YES;
               timeCount=60;
                [self showHUB:@"获取验证码成功"];
                [self ug_creatTimer];
                
            }else{
                _obtainBut.selected=NO;
                [Uikility alert:[objec objectForKey:@"msg"]];
            }
        } failure:^(NSError *error) {
            _obtainBut.selected=NO;
        }];
        
        
        
          
    }else
    {
        [self showHUB:@"请填写正确的手机号"];
    }

}
-(void)ug_creatTimer{
    
    __weak typeof(self)weakself=self;
    dispatch_queue_t queuet=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //dispatch_queue_t queuet=dispatch_get_main_queue();
    /**
     第一个参数：   DISPATCH_SOURCE_TYPE_TIMER, 表示定时器
     */
    _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queuet);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself updateTime];
        });
        
        //[weakself updateTime];
    });
    dispatch_resume(_timer);
}
-(void)updateTime{
    timeCount--;
   
    if (timeCount<=0) {
        timeCount=0;
        //[time invalidate];
        //[self updateTime];
         [self showButton];
        [self ug_stopTimer];
        //[self showButton];
    }
    _obtainBut.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [_obtainBut setTitle:[NSString stringWithFormat:@"重新发送(%zd)",timeCount] forState:UIControlStateNormal];

}
-(void)ug_stopTimer{
    /**
     dispatch source 并没有提供用于检测 source 本身的挂起计数的 API，也就是说外部不能得知一个 source 当前是不是挂起状态，在设计代码逻辑时需要考虑到这一点。
     dispatch_source_cancel 则是真正意义上的取消 Timer。被取消之后如果想再次执行 Timer，只能重新创建新的 Timer。这个过程类似于对 NSTimer 执行 invalidate*/
    dispatch_source_cancel(_timer);
    _timer=nil;
}
//跳过按钮监听事件
-(void)skip{
    //MyViewController *my=[[MyViewController alloc] init];
    //[self.navigationController popToViewController:my animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //[self dis]

}
-(void)showButton{
   // self.timelabel.hidden = YES;
   // self.but.hidden = NO;
    //self.label.hidden=YES;
   
    //NSLog(@"执行获取===%@", [NSThread currentThread]);
    _obtainBut.selected=NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [_obtainBut setTitle:@"获取验证码" forState:UIControlStateNormal];
    });
    //return;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
