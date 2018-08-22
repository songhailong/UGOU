//
//  QdqViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/12/21.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import "QdqViewController.h"
#import "AFManger.h"
#import "LoginViewController.h"
#import "Uikility.h"
//#import "UIImageView+WebCache.h"
#import "BassAPI.h"
//#import <TencentOpenAPI/QQApiInterface.h>
@interface QdqViewController ()<UIActionSheetDelegate>{
    UILabel *label;
    UIImageView *imvs;
    NSArray *arrs;
    //NSString *present;
    NSMutableArray *muarr;
    NSUserDefaults *de ;
    UIView *view;
    NSArray *arrimg;
    NSArray *arrtext;
    NSNumber * _reTime;
}@end

@implementation QdqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    muarr=[[NSMutableArray alloc]init];
  
    de=[NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.translucent=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;

    imvs=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:imvs];
    imvs.userInteractionEnabled=YES;
    imvs.image=[UIImage imageNamed:@"签到23"];

    UIButton *b1=[[UIButton alloc]initWithFrame:CGRectMake(5*KIphoneWH, 22*KIphoneWH, 70*KIphoneWH, 30*KIphoneWH)];
    [b1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b1 setTitle:@"关闭" forState:UIControlStateNormal];
    [imvs addSubview:b1];
    b1.tag=1;
    [b1 addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40*KIphoneWH, 20*KIphoneWH, 120*KIphoneWH, 50*KIphoneWH)];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"签到有礼";
    titlelabel.font=[UIFont systemFontOfSize:20];
    [imvs addSubview:titlelabel];
    if (iPhoneX) {
        titlelabel.frame=CGRectMake(WIDTH/2-40*KIphoneWH, 20*KIphoneWH+24, 120*KIphoneWH, 30*KIphoneWH);
        b1.frame=CGRectMake(5*KIphoneWH, 20*KIphoneWH+24, 70*KIphoneWH, 30*KIphoneWH);
    }
    [self addqiandao];
     [self addfootview];
      [self json];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:YES];
   // label.text=@"0";
     //[self json];
}
#pragma mark 签到
-(void)addqiandao{
    label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-12*KIphoneWH, HEIGHT/2-48*KIphoneWH, 50*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
   // label.text=@"0";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:25*KIphoneWH];
    [imvs addSubview:label];
    UIButton *b2=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH, HEIGHT/2+30*KIphoneWH, WIDTH-20*KIphoneWH, 60*KIphoneWH)];
    [b2 setBackgroundImage:[UIImage imageNamed:@"签到124"] forState:UIControlStateNormal];
    
    [imvs addSubview:b2];
    b2.tag=2;
    [b2 addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b3=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH, HEIGHT/2+102*KIphoneWH, WIDTH-20*KIphoneWH, 60*KIphoneWH)];
    [b3 setBackgroundImage:[UIImage imageNamed:@"分享123"] forState:UIControlStateNormal];
    [imvs addSubview:b3];
    b3.tag=3;
    [b3 addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    if (iPhoneX) {
        b2.frame=CGRectMake(10*KIphoneWH, HEIGHT/2+30*KIphoneWH+12, WIDTH-20*KIphoneWH, 70*KIphoneWH);
        b3.frame=CGRectMake(10*KIphoneWH, HEIGHT/2+102*KIphoneWH+30, WIDTH-20*KIphoneWH, 70*KIphoneWH);
    }
 

}
#pragma mark 点击 返回 签到 分享
-(void)pop:(UIButton *)b{
    if (b.tag==1) {
    [self.navigationController popViewControllerAnimated:YES];
    }else if (b.tag==2){
        
        long long s=_reTime.longLongValue;
        NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];
        
        long gg=sss.integerValue;
        
        NSString *timestr=[Uikility DatetoTime:gg];
     
        
        //}
        
        long nowtime=[Uikility readnowtime];
        NSString *nowsss=[NSString stringWithFormat:@"%ld",nowtime/1000];
        
        long nowgg=nowsss.integerValue;
            NSString *timenow=[Uikility DatetoTime:nowgg];
      
   NSString *qddate=     [timestr substringToIndex:10];
  NSString *nowdate=      [timenow substringToIndex:10];
        
        //////////NSLog(@"---%@---------%@",qddate,nowdate);
        
        if([qddate isEqualToString:nowdate]){
        
            [Uikility alert:@"你已签到"];
        
        
        }else
        {
        
     NSString *   url=[BassAPI requestUrlWithPorType: PortTypeSign];
        
        if ([de objectForKey:@"userId"]) {
            NSMutableDictionary *dicss=[[NSMutableDictionary alloc] init];
            [dicss setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            [dicss setObject:[de objectForKey:@"userId"] forKey:@"userId"];
            if ([de objectForKey:@"newUserId"]) {
                 [dicss setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
            }
            
            [dicss setObject:@1 forKey:@"model"];
            [dicss setObject:VERSION forKey:@"ios_version"];
     NSDictionary *json1=[Uikility initWithdatajson:dicss];

            
          [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
              
              id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
              //////////NSLog(@"%@",strs);
              Boolean success=[[strs objectForKey:@"success"] boolValue];
              
              if (success) {
                  
                  
                  if ([[[strs objectForKey:@"data"]objectForKey:@"flag"]intValue]) {
                      
                      
                      int flag=[[[strs objectForKey:@"data"]objectForKey:@"flag"]intValue];
                    
                      NSNumber *present=[[strs objectForKey:@"data"] objectForKey:@"present"];
                      
                      if (flag==1) {
                          //积分
                          
                          [Uikility alert:[NSString stringWithFormat:@"签到成功！获得%zd个积分",present.integerValue]];
                      }else if (flag==2){
                          //包邮券
                          [Uikility alert:@"签到成功！获得券！"];
                      }else if (flag==3){
                          //
                          [Uikility alert:[NSString stringWithFormat:@"签到成功！获得%zd个积分！",present.intValue]];
                      }else if (flag==4){
                          //
                          [Uikility alert:@"签到成功！获得券！"];
                      }
                      [self json];
                  }else{
                      //[self json];
                      [Uikility alert:@"已签到！"];
                  }
                  
                  
                  
              }else{
                  NSString *msg=[strs objectForKey:@"msg"];
                  ////////////////////////NSLog(@"%@",msg);
                  
                  [Uikility alert:msg];
              }

              
          } failure:^(NSError *error) {
               [Uikility alert:@"接受数据失败！"];
          }];
            
            
    }else{
          [Uikility alert:@"请先登录！"];
        }
        }

        
    }else if (b.tag==3){
        ///view.alpha=1;
       
        [UIView beginAnimations:@"animatePopView" context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView commitAnimations];
        
    }
}

-(void)addfootview{
    
    view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:view];
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT/8*5)];
    v1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [view addSubview:v1];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popss)];
    [v1 addGestureRecognizer:tap];
 UIView *   v2=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/8*5, WIDTH, HEIGHT/8*3)];
    v2.backgroundColor=[UIColor whiteColor];
    [view addSubview:v2];
//    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50*KIphoneWH, 5*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
//    [but setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    [but addTarget:self action:@selector(pops) forControlEvents:UIControlEventTouchUpInside];
//    [v2 addSubview:but];
    
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        
    
   
        
       // if ([QQApiInterface isQQInstalled]) {
           arrimg=@[@"common_icon_weibo@2x",@"common_icon_qq@2x",@"sns_icon_23@3x.png",@"common_icon_wechat@2x.png"];
       // }else{
        //arrimg=@[@"common_icon_weibo@2x",@"sns_icon_23@3x.png",@"common_icon_wechat@2x"];
        
        //}
    
        
    }else  {
        
        //if ([QQApiInterface isQQInstalled]) {
             arrimg=@[@"common_icon_weibo@2x",@"common_icon_qq@2x"];
        //}else{
        
        
           // arrimg=@[@"common_icon_weibo@2x"];
       // }
    }

    
    
    
    
    for (int i=0; i<arrimg.count; i++) {
        
    
        UIButton *b=[[UIButton alloc]initWithFrame:CGRectMake(20*KIphoneWH+i*((WIDTH-70*KIphoneWH)/4+10*KIphoneWH), 40*KIphoneWH, (WIDTH-70*KIphoneWH)/4, 70*KIphoneWH)];
        b.tag=i+1;
        [b setBackgroundImage:[UIImage imageNamed:[arrimg objectAtIndex:i]] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(pushfx:) forControlEvents:UIControlEventTouchUpInside];
        [v2 addSubview:b];

        
    }
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        
        
        
        
        //if ([QQApiInterface isQQInstalled]) {
            arrtext=@[@"新浪微博",@"QQ空间",@"微信朋友圈",@"微信好友"];
        //}else{
           // arrtext=@[@"新浪微博",@"微信朋友圈",@"微信好友"];
        
       // }
        
    }else{
        
        
        //if ([QQApiInterface isQQInstalled]) {
            arrtext=@[@"新浪微博",@"QQ空间"];
        //}else{
            //arrtext=@[@"新浪微博"];}
    }

    
    for (int i=0; i<arrtext.count; i++) {
        
        
        UIButton *b=[[UIButton alloc]initWithFrame:CGRectMake(20*KIphoneWH+i*((WIDTH-70*KIphoneWH)/4+10*KIphoneWH), 110*KIphoneWH, (WIDTH-70*KIphoneWH)/4, 40*KIphoneWH)];
        b.tag=i+1;
         [b setTitle:[arrtext objectAtIndex:i]forState:UIControlStateNormal];
        [b setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
        b.titleLabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
        [b addTarget:self action:@selector(pushfx:) forControlEvents:UIControlEventTouchUpInside];
        [v2 addSubview:b];
        
        
    }
    UIButton *buts=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH,HEIGHT/8*3-60*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH)];
    [buts setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buts setTitle:@"取消" forState:UIControlStateNormal];
    [buts setBackgroundImage:[UIImage imageNamed:@"搜索框@2x"] forState:UIControlStateNormal];
    buts.titleLabel.font=[UIFont systemFontOfSize:24*KIphoneWH];
    [buts addTarget:self action:@selector(popss) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:buts];
     view.alpha=0;
}

-(void)popss{
    view.alpha=0;
}

-(void)pushfx:(UIButton *)b{
     Uikility * utl=[[Uikility alloc] init];
    
    if (arrtext.count==2) {
        
    }
    
    
    
    
    
    
    
    switch (b.tag) {
    
        case 1:
            
             [utl shareWbsinaWithimage:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]] title:@"U购签到啦！！！" description:@"签到了！！！" url:nil];
            
            break;
        case 2:
            //2 和 4 qq 3 微信朋友圈
            
            if (arrtext.count==3) {
                [utl shareWithWexintext:nil Withurl:nil title:@"U购签到" imagedata:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]] uiiamge:nil ];
            }else{
                UIImage *image=[UIImage imageNamed:@"uuu"];
                [utl shareWithYmQQzone:@"U购签到啦！" Withurl:nil title:@"U购签" imagedata:image imageurl:nil viewcontrol:self];
            }
           
            break;

        case 3:
            if (arrtext.count==3) {
               [utl shareWithWXfrendtext:nil Withurl:nil title:@"u购签到" imagedata:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]]uiiamge:nil ];
            }else{
           
            //3 微信好友 4 微信朋友圈
            [utl shareWithWexintext:nil Withurl:nil title:@"u购签到" imagedata:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]]uiiamge:nil ];
            }
            break;
       case 4:
             [utl shareWithWXfrendtext:nil Withurl:nil title:@"u购签到" imagedata:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]]uiiamge:nil ];
            break;
            
        default:
            break;
    }

}

#pragma mark 数据
-(void)json{
    
    
         NSString *   url=[BassAPI requestUrlWithPorType:PortTypeQuerydays];
   
        if ([de objectForKey:@"userId"]) {
            NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
            [dics setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            [dics setObject:[de objectForKey:@"userId"] forKey:@"userId"];
            if ([de objectForKey:@"newUserId"]) {
                [dics setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
            }
           
            [dics setObject:@1 forKey:@"model"];
            [dics setObject:VERSION forKey:@"ios_version"];
            
            NSDictionary *json1=[Uikility initWithdatajson:dics];
//            
           [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
               id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
               //////////NSLog(@"---------------------------------%@",strs);
               Boolean success=[[strs objectForKey:@"success"] boolValue];
               
               if (success) {
                   NSString *tian=[NSString stringWithFormat:@"%@",[[strs objectForKey:@"data"]objectForKey:@"fate"]];
                   
                
                   label.text=tian;
                   _reTime=[[strs objectForKey:@"data"] objectForKey:@"reTime"];
                   
                   
                   
               }else{
               [Uikility alert:[strs objectForKey:@"msg"]];
               }

               
           } failure:^(NSError *error) {
               [Uikility alert:@"接收数据失败！"];
           }];
    }else{
        [Uikility alert:@"请先登录！"];
  }
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
