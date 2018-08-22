//
//  LogisticsViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/5/18.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "LogisticsViewController.h"
#import "Uikility.h"
#import "CustomWeb.h"
@interface LogisticsViewController ()<UIWebViewDelegate>

{

  CustomWeb *_webview;

}

@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    self.navigationController.navigationBar.translucent=NO;
    [self  creatUI];
    
    
    
}
-(void)creatUI{
    //UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 80*KIphoneWH)];
    
    //[self.view addSubview:view];
    
    
    _webview=[[CustomWeb alloc] initWithFrame:CGRectMake(0, 0,WIDTH , HEIGHT)];
    
    //NSString *
    
    
    
    _webview.scalesPageToFit=YES;
    _webview.delegate=self;
    NSString *urlstr=[NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@&postid=%@",_code,_expressNo];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr] ];
    [_webview  loadRequest:request];
//    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5*KIphoneWH, 10*KIphoneWH, 50*KIphoneWH, 30*KIphoneWH)];
//    [button setBackgroundImage:[UIImage imageNamed:@"webback_@2x.png"] forState:UIControlStateNormal];
//    //button.backgroundColor=[UIColor redColor];
//    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
//    
    
//    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(webpop)];
//   
//    [button addGestureRecognizer:imgtap];

    
    
    
   // [_webview.view addSubview:button];
    
//    void(^myblock)(NSInteger text)=^(NSInteger text){
//        
//        
//        ////////////////NSLog(@"bbbbbbbbb");
//       
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    
//    
//    _webview.WebBlock=myblock;
    
    [self.view addSubview:_webview];
    
     UIView  *  view1=[[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 50*KIphoneWH)];
   view1.backgroundColor=[UIColor colorWithRed:53.0/255.0 green:122.0/255.0 blue:196.0/255.0 alpha:1];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(100*KIphoneWH, 0, WIDTH-200*KIphoneWH, 55*KIphoneWH)];
    lable.text=@"查询结果";
    lable.font=[UIFont systemFontOfSize:22*KIphoneWH];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
            UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake(5*KIphoneWH, 10*KIphoneWH, 50*KIphoneWH, 30*KIphoneWH)];
    button1.backgroundColor=[UIColor redColor];
            [button1 setBackgroundImage:[UIImage imageNamed:@"webback1"] forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchDown];
    [view1 addSubview:lable];
     [view1 addSubview:button1];
    [self.view addSubview:view1];

    
    
    
    
}
-(void)buttonclick{
    
    [self.navigationController popViewControllerAnimated:YES];

}
//-(void)webpop{
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    


}

-(void)webViewDidStartLoad:(UIWebView *)webView{


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
