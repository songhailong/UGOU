//
//  ThemeViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/21.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ThemeViewController.h"
#import "Uikility.h"
//#import <TencentOpenAPI/QQApiInterface.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebViewController.h"
@interface ThemeViewController ()<UIWebViewDelegate>
{

    UIWebView *_webview;
    UIView *view;
     NSArray *arrimg;
    NSArray *arrtext;
    WKWebViewController *web;
}

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webview=[[UIWebView alloc] initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT-NavHeight)];
    _webview.delegate=self;
    _webview.scalesPageToFit=YES;
    NSURLRequest *requst=[NSURLRequest requestWithURL:[Uikility  URLWithString:_imgurl]];

    [_webview loadRequest:requst];
    [self.view addSubview:_webview];
    //核心方法如下
//    JSContext *content = [_webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    content[@"getUrl"] = ^() {
//        NSLog(@"js调用oc---------begin--------");
//        NSArray *thisArr = [JSContext currentArguments];
//        for (JSValue *jsValue in thisArr) {
//            NSLog(@"=======%@",jsValue);
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",jsValue]]];
//        }
//
//        NSLog(@"js调用oc---------The End-------");
        //[self.webView stringByEvaluatingJavaScriptFromString:@"show();"];
    //};
//     web = [[WKWebViewController alloc] init];
//    [web loadWebURLSring:@"https://www.ugouchina.com/ugouApp/yhq.html"];
//    web.isNavHidden=NO;
//    [self.view addSubview:web.view];
    
    
    
    [self addshareview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=@"主题详情";
    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
    self.navigationItem.titleView=label;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(pushsear)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftButton;
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStyleDone target:self action:@selector(pushshare)];
    self.navigationItem.rightBarButtonItem=rightbutton;

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"失败---=-=-=-=151151");
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * requestString = request.URL.absoluteString;
    NSLog(@"请求的地址：%@",requestString);
    return YES;
}
-(void)pushshare{
    
    view.alpha=1;
}
-(void)addshareview{
    view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:view];
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT/2)];
    v1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [view addSubview:v1];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popss)];
    [v1 addGestureRecognizer:tap];
    UIView *   v2=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/2)];
    v2.backgroundColor=[UIColor whiteColor];
    [view addSubview:v2];
    
    
    
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
       // if ([QQApiInterface isQQInstalled]) {
      arrimg=@[@"umsocial_sina.png",@"umsocial_qzone",@"umsocial_wechat_timeline",@"umsocial_wechat.png"];
//        }else{
//            arrimg=@[@"umsocial_sina.png",@"umsocial_wechat_timeline  ",@"umsocial_wechat_timeline"];
//
//        }
        
        
    }else  {
        
        //if ([QQApiInterface isQQInstalled]) {
            arrimg=@[@"umsocial_qzone",@"umsocial_sina.png"];
//        }else{
//            
//            //NSLog(@"vffffffffffffffff%@",WMVideoSrcName(@"umsocial_sina"));
//            arrimg=@[@"umsocial_sina.png"];
//        }
    }
    
    
    
    
    
    for (int i=0; i<arrimg.count; i++) {
        UIButton *b=[[UIButton alloc]initWithFrame:CGRectMake(20*KIphoneWH+i*((WIDTH-70*KIphoneWH)/4+10*KIphoneWH), 40*KIphoneWH, (WIDTH-70*KIphoneWH)/4, 70*KIphoneWH)];
        b.tag=i+1;
        //[b setBackgroundImage:[UIImage imageNamed:[arrimg objectAtIndex:i]] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:THEMEShareSrcName([arrimg objectAtIndex:i])] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(pushfx:) forControlEvents:UIControlEventTouchUpInside];
        [v2 addSubview:b];
    }
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        //if ([QQApiInterface isQQInstalled]) {
            arrtext=@[@"新浪微博",@"QQ空间",@"微信朋友圈",@"微信好友"];
        //}else{
          //  arrtext=@[@"新浪微博",@"微信朋友圈",@"微信好友"];
            
       // }
        
    }else{
       // if ([QQApiInterface isQQInstalled]) {
            arrtext=@[@"新浪微博",@"QQ空间"];
        //}else{
           // arrtext=@[@"新浪微博"];}
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
    UIButton *buts=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH,HEIGHT/2-140*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH)];
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
-(void)pushfx:(UIButton *)bt{
    Uikility *kilt=[[Uikility alloc] init];
    switch (bt.tag) {
        case 1:
        {
            //UIImage *image=[UIImage imageNamed:@"uuu"];
            NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
            NSString *titlestr=[NSString stringWithFormat:@"%@%@",_imgurl,@"u购主题"];
            [kilt shareWbsinaWithimage:data title:titlestr description:@"不一样的购物体验" url:_imgurl];
        }
            break;
        case 2:
        {
            if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                //if ([QQApiInterface isQQSupportApi]) {
                    UIImage *image=[UIImage imageNamed:@"uuu"];
                    
                    [kilt shareWithYmQQzone:@"不一样的购物体验" Withurl:_imgurl title:@"u购" imagedata:image imageurl:nil viewcontrol:nil];
                //}else{
                  //  UIImage *image=[UIImage imageNamed:@"uuu"];
                    
                   // [kilt shareWithWexintext:@"不一样的购物体验" Withurl:_imgurl title:@"u购" imagedata:nil uiiamge:image];
               // }
            }else{
                UIImage *image=[UIImage imageNamed:@"uuu"];
                //if ([QQApiInterface isQQSupportApi]) {
                    [kilt shareWithYmQQzone:@"不一样的购物体验" Withurl:_imgurl title:@"u购" imagedata:image imageurl:nil viewcontrol:nil];

               // }
            
            }
            
        }
            break;
        case 3:
        {
           // if ([QQApiInterface isQQSupportApi]) {
                if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                    UIImage *image=[UIImage imageNamed:@"uuu"];
                    
                    [kilt shareWithWexintext:@"不一样的购物体验" Withurl:_imgurl title:@"U购" imagedata:nil uiiamge:image];
                }
           // }else{
                //if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                    //UIImage *image=[UIImage imageNamed:@"uuu"];
                    
                    // [kilt shareWithWXfrendtext:@"不一样的购物体验" Withurl:_imgurl title:@"u购" imagedata:nil uiiamge:image];
                //}

            //}
            
        }
            break;
        case 4:
        {
            if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                UIImage *image=[UIImage imageNamed:@"uuu"];
                [kilt shareWithWXfrendtext:@"不一样的购物体验" Withurl:_imgurl title:@"u购" imagedata:nil uiiamge:image];
            }

        }
            break;
            
        default:
            break;
    }
    


}

-(void)pushsear
{
    [self.navigationController popToRootViewControllerAnimated:YES];

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
