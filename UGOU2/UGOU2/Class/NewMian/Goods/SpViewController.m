//
//  SpViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/20.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.10.22.2.24 商品详情
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "SpViewController.h"
//#import "ViewController.h"
#import "AppDelegate.h"
#import "CartViewController.h"
#import "DingdanViewController.h"
#import "HYSegmentedControl.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "LPLabel.h"
#import "CartModel.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "EvaluateTableViewCell.h"
#import "PpViewController.h"
#import "BassAPI.h"
#import "UbViewController.h"
#import "MKjViewController.h"
#import "ProductTableViewCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "ShufflingTapGestureRecognizer.h"
#import "ImageTableViewCell.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "UGShareView.h"
#import "CountdownVidew.h"
@interface SpViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HYSegmentedControlDelegate,MBProgressHUDDelegate,UIWebViewDelegate,SDWebImageManagerDelegate,UGShareViewDelegate>{
    UIScrollView *scroll;
    UIScrollView *headscroll;
    UIPageControl *page;
    UITableView *table1;
    UITableView *_table2;
    UITableView *table3;
    UITableView *table4;
    UIView *view;
    UIView *views;
    UIView *headview;
    NSDictionary *dic;
    UIView *footview;
    NSURL *imstr;
    UIView *headv2;
    NSInteger gs;
    UILabel *sllabel;
    UIImageView *imvbut;
    UIImageView *imvb;
    UIImageView *imvbuts;
    NSDictionary *ys;
    NSArray *ysarr;
    NSArray *reslutFilteredArray;
    int yanse;
    int chima;
    NSUserDefaults *de;
    int cgs;
    HYSegmentedControl *_segment;
   // MBProgressHUD *hud;
    UIView *v2;
    LPLabel *lplabel;
    NSString *url;
    NSDictionary *dicstion;
    NSMutableArray *sparr;
    UIWebView *_webview;
    NSDictionary *dics;
    //评价数据
    NSMutableArray *_evdataarray;
    NSArray *toolbararr;
    UIImageView *titleimageview;
    UIButton *_butsc;
    NSMutableArray *arrays;
    UIView *toolbar;
    NSInteger _selectrow;
    BOOL _brands;
    NSArray  * _imarray;
    MJPhotoBrowser *_browser;
    NSMutableArray *_phtotsubviews;
    NSArray *_webimagearray;
    
    UGShareView *_shareView;
    
    NSData *_shareImageData;
}
//@property (strong, nonatomic)
@end


@implementation SpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    views=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    views.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:views];
    _evdataarray=[[NSMutableArray alloc] init];
    _brands=NO;
   
    _dictionary =[[NSDictionary alloc]init];
    dic=[[NSDictionary alloc]init];
    de=[NSUserDefaults standardUserDefaults];
    sparr=[NSMutableArray array];
    _phtotsubviews=[[NSMutableArray alloc] init];
    _webimagearray=[[NSArray alloc] init];
    [self addspxq];
    [self json];
//    CountdownVidew *countView=[[CountdownVidew alloc] initWithFrame:CGRectMake(0, 6, 300, 300)];
//    countView.time=1522918624000;
    
    //[self addtoolbar];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    //self.navigationController.navigationBar.translucent=NO;
    //de=[NSUserDefaults standardUserDefaults];
    view.alpha=0;
    //[self json];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
}
#pragma mark 2015.10.23.10.30 底部
-(void)addtoolbar{
   
    toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-60*KIphoneWH, WIDTH, 60*KIphoneWH)];
    
    if (_flag==1) {
        toolbararr=[[NSArray alloc]initWithObjects:@"客服",@"店铺",@"收藏",@"加入购物车",@"立即购买",nil];
    }else if(_flag==2){
        toolbararr=[[NSArray alloc]initWithObjects:@"客服",@"店铺",@"收藏",@"加入购物车",@"预定商品",nil];
    }else if (_flag==3){
        toolbararr=[[NSArray alloc]initWithObjects:@"客服",@"店铺",@"收藏",@"加入购物车",@"预定试衣",nil];
    }
    
   toolbar.backgroundColor=[UIColor whiteColor];
   
    
    for (int i=0; i<3; i++) {
        UIButton *but=[[UIButton alloc]init];
        //but.tag=10000+i;
        but.frame= CGRectMake(WIDTH/7*i+5*KIphoneWH, 10*KIphoneWH, WIDTH/7-30*KIphoneWH, 25*KIphoneWH);
       
        if (i==2) {
         
            if ([[[_dictionary objectForKey:@"goods"] objectForKey:@"flag"]integerValue]==1) {
                [but setBackgroundImage:[UIImage imageNamed:@"34-33(1)"] forState:UIControlStateNormal];
            }else{
             [but setBackgroundImage:[UIImage imageNamed:[toolbararr objectAtIndex:i]] forState:UIControlStateNormal];
                [but addTarget:self action:@selector(topush:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
        [but setBackgroundImage:[UIImage imageNamed:[toolbararr objectAtIndex:i]] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(topush:) forControlEvents:UIControlEventTouchUpInside];
        }
      
        but.tag=i+10000;
        
        [toolbar addSubview:but];
        
        UIButton *but1=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/7*i+2*KIphoneWH, 30*KIphoneWH, WIDTH/7-20*KIphoneWH, 30*KIphoneWH)];
        [but1 setTitle:[toolbararr objectAtIndex:i] forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //but1.titleLabel.textAlignment=NSTextAlignmentCenter;
        but1.titleLabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
        but1.tag=1+i;
        [but1 addTarget:self action:@selector(topush:) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:but1];
    }
    for (int i=3; i<5; i++) {
        
    
        UIButton *buthh=[[UIButton alloc]init];
        buthh.frame=CGRectMake(WIDTH/7*3+WIDTH/7*2*(i-3), 0, WIDTH/7*2, 60*KIphoneWH);
       
        if (_flag==1) {
            [buthh setBackgroundImage:[UIImage imageNamed:[toolbararr objectAtIndex:i]] forState:UIControlStateNormal];
        }else{
            if (i==4) {
                [buthh setTitle:[toolbararr objectAtIndex:i] forState:UIControlStateNormal];
                [buthh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [buthh setBackgroundColor:[UIColor colorWithRed:233/255.0 green:54/255.0  blue:36/255.0  alpha:1]];
                buthh.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
                
            }else{
                [buthh setBackgroundImage:[UIImage imageNamed:[toolbararr objectAtIndex:i]] forState:UIControlStateNormal];
            }
        }
        buthh.tag=i+1;
        if (i==2) {
        if ([[[_dictionary objectForKey:@"goods"] objectForKey:@"flag"]integerValue]==1) {
        }else{
        [buthh addTarget:self action:@selector(topush:) forControlEvents:UIControlEventTouchUpInside];
        }
        }else{
        [buthh addTarget:self action:@selector(topush:) forControlEvents:UIControlEventTouchUpInside];
        }
        [toolbar addSubview:buthh];
        
    }
    [views addSubview:toolbar];
    
    [self addfootview];
    
}
//点击进入
#pragma mark 点击 下方按钮
-(void)topush:(UIButton *)b{
   if (b.tag==1||b.tag==10000) {
      
    }else if (b.tag==2||b.tag==10001){
       
        PpViewController *pp=[[PpViewController alloc]init];
        pp.hidesBottomBarWhenPushed=YES;
        pp.flag=1;
        pp.dic=[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"];
        pp.appbrandId=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"id"];
        [self.navigationController pushViewController:pp animated:YES];
        

    }else if (b.tag==3||b.tag==10002){
        
        
        if ([[[_dictionary objectForKey:@"goods"] objectForKey:@"flag"]integerValue]==1) {
            [Uikility alert:@"你已收藏"];
        }else{
        if ([de objectForKey:@"userId"]) {
            
            if(b.selected==YES){
            [Uikility alert:@"你已收藏"];
            }else{
          
                //[self json1:nil save:NO];
                [self collectiongoods];
           }
        }else{
            //[Uikility alert:@"请先登录!"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
        }
        
        }
    }else if (b.tag==4){
        
        if ([de objectForKey:@"userId"]) {
            
            cgs=1;
            view.alpha=1;
            //[self addfootview];
            [UIView beginAnimations:@"animatePopView" context:nil];
            [UIView setAnimationDuration:0.4];
            [UIView commitAnimations];

        }else{
            //[Uikility alert:@"请先登录！"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
        }
    }else if (b.tag==5){

        if ([de objectForKey:@"userId"]) {
#pragma mark 立即购买 选择尺码 颜色 数量
            cgs=2;
            view.alpha=1;
           
            //[self addfootview];
            [UIView beginAnimations:@"animatePopView" context:nil];
            [UIView setAnimationDuration:0.4];
            [UIView commitAnimations];        }else{
            //[Uikility alert:@"请先登录！"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
        }
    }
}

#pragma mark 新界面 选择尺码 颜色 数量
-(void)addfootview{
  
    view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:view];
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT/3)];
    v1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [view addSubview:v1];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop)];
    [v1 addGestureRecognizer:tap];
    v2=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/3, WIDTH, HEIGHT/3*2)];
    v2.backgroundColor=[UIColor whiteColor];
    [view addSubview:v2];
    
    UILabel *yslabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH,90*KIphoneWH,WIDTH-20*KIphoneWH, 30*KIphoneWH)];
    [v2 addSubview:yslabel];
    yslabel.text=@"颜色分类";
    // ys
    ys=[_dictionary objectForKey:@"attribute"];
 
    NSMutableArray *muarr=[NSMutableArray array];
    //NSArray *ttarr=(NSMutableArray *)[ys allKeys];
   NSArray * arr = [ys allKeys];
        for (NSString* keys in arr) {
        NSString *S=(NSString *)[ys objectForKey:keys];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:S options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"[" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"]" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        if([json rangeOfString:@","].location!=NSNotFound){
            NSArray *array = [json componentsSeparatedByString:@","];
            [muarr addObjectsFromArray:array];
        }else{
            [muarr addObject:json];
        }
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSNumber *number in muarr) {
        [dict setObject:number forKey:number];
    }
    
    ysarr= [dict allValues];
    for (int i=0; i<ysarr.count; i++) {
        UIButton *b=[UIButton buttonWithType:UIButtonTypeSystem];
        [v2 addSubview:b];
        [b setTitle:[ysarr objectAtIndex:i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [b setBackgroundImage:[UIImage imageNamed:@"尺码分类底框"] forState:UIControlStateNormal];
        b.titleLabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
        b.frame=CGRectMake(5*KIphoneWH+i*60*KIphoneWH,120*KIphoneWH, 55*KIphoneWH,40*KIphoneWH);
        b.tag=i+101;
        [b addTarget:self action:@selector(changeys:) forControlEvents:UIControlEventTouchUpInside];
    }
 
  
    UILabel *cmlabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH,180*KIphoneWH,WIDTH-20*KIphoneWH, 30*KIphoneWH)];
    [v2 addSubview:cmlabel];
#pragma mark------- 尺码
    arrays=[NSMutableArray array];
    [arrays addObjectsFromArray:arr];
    for (int i=0;i<arrays.count;i++) {
        for (int j=i; j<arrays.count-1; j++) {
            NSString *temp;
            NSString *str1=arrays[j];
            NSString *str2=arrays[j+1];
            NSString *xstr1=[str1 substringToIndex:3];
            NSString *xstr2=[str2 substringToIndex:3];
           
            if (xstr1.intValue > xstr2.intValue) {
                temp=arrays[j];
                arrays[j]=arrays[j+1];
                arrays[j+1]=temp;
            }
            
        }

    }
   
    
    cmlabel.text=@"尺码";
       for (int i=0; i<arrays.count; i++) {
        UIButton *b=[UIButton buttonWithType:UIButtonTypeSystem];
        [v2 addSubview:b];
        [b setTitle:[arrays objectAtIndex:i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           [b setBackgroundImage:[UIImage imageNamed:@"尺码分类底框"] forState:UIControlStateNormal];
        b.frame=CGRectMake(5*KIphoneWH+i*60*KIphoneWH, 220*KIphoneWH, 55*KIphoneWH, 40*KIphoneWH);
           b.titleLabel.font=[UIFont systemFontOfSize:13*KIphoneWH];
        b.tag=i+1;
        [b addTarget:self action:@selector(changecm:) forControlEvents:UIControlEventTouchUpInside];
    }
#pragma mark----- 点击颜色 尺码后颜色改变
    //颜色
    imvbut=[[UIImageView alloc]init];
    imvbut.backgroundColor=[UIColor colorWithRed:149.0/255.0 green:190.0/255.0 blue:70/255.0 alpha:0.7];
    [v2 addSubview:imvbut];
    imvbuts=[[UIImageView alloc]init];
    imvbuts.backgroundColor=[UIColor grayColor];
    [v2 addSubview:imvbuts];
    
    //尺码
    imvb=[[UIImageView alloc]init];
    imvb.backgroundColor=[UIColor colorWithRed:149.0/255.0 green:190.0/255.0 blue:70/255.0 alpha:0.7];
    //imvb.image=[UIImage imageNamed:@"颜色分类底框"];
    [v2 addSubview:imvb];
    UIButton *buts=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH,HEIGHT/3*2-60*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH)];
    [buts setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[buts setTitle:@"确定" forState:UIControlStateNormal];
    [buts setBackgroundImage:[UIImage imageNamed:@"确定@2x"] forState:UIControlStateNormal];
  
    [buts addTarget:self action:@selector(pushcar) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:buts];
   // if (cgs==1||cgs==2) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50*KIphoneWH, 10*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
        [but setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [v2 addSubview:but];
       // NSURL *url=[NSURL URLWithString:imstr];
        NSString*str=[[_dictionary objectForKey:@"goods"]objectForKey:@"logopicUrl"];
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview sd_setImageWithURL:[Uikility URLWithString:str] placeholderImage:[UIImage imageNamed:@"uuu"]];
        imageview.frame=CGRectMake(10*KIphoneWH, HEIGHT/3-10*KIphoneWH, 80*KIphoneWH, 80*KIphoneWH);
        [view addSubview:imageview];
        UILabel *jglabel=[[UILabel alloc]initWithFrame:CGRectMake(100*KIphoneWH, 20*KIphoneWH,WIDTH-90*KIphoneWH, 30*KIphoneWH)];
        [v2 addSubview:jglabel];
       // NSString *s2=[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"];
    
    
    CGFloat ss2=[Uikility priceToCompareVipprice:[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"] vipnumber:[[_dictionary objectForKey:@"goods"]objectForKey:@"vipPrice"]];
        jglabel.text=[NSString stringWithFormat:@"￥%.1f",ss2];
        jglabel.textColor=[UIColor colorWithRed:233/255.0 green:94/255.0 blue:75/255.0 alpha:1];
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(100*KIphoneWH, 50*KIphoneWH,WIDTH-90*KIphoneWH, 30*KIphoneWH)];
        [v2 addSubview:titlelabel];
        titlelabel.text=@"请选择 尺码";
        UILabel *sllabels=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH,270*KIphoneWH,WIDTH-20*KIphoneWH, 30*KIphoneWH)];
        [v2 addSubview:sllabels];
        sllabels.text=@"购买数量";
        
        NSArray *array=@[@"加号@2x",@"减号@2x"];
        for (int i=0; i<2; i++) {
            UIButton *b=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH-60*KIphoneWH*i,270*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
            [b setBackgroundImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
            b.tag=i;
            [b addTarget:self action:@selector(zengjian:) forControlEvents:UIControlEventTouchUpInside];
            [v2 addSubview:b];
        }
        gs=1;
        sllabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-70*KIphoneWH,270*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
        sllabel.textAlignment=NSTextAlignmentCenter;
        sllabel.text=[NSString stringWithFormat:@"%zd",gs];
        [v2 addSubview:sllabel];
   // }
    view.alpha=0;
    
    [self creatShareView];
    
    
}
#pragma mark 尺码 颜色
-(void)changecm:(UIButton *)b{
  
    imvb.frame=b.frame;
     NSArray *s=[ys objectForKey:[arrays objectAtIndex:b.tag-1]];

    NSArray *arr=[NSArray array];
    arr=ysarr;
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",s];
//    //过滤数组
    reslutFilteredArray = [arr filteredArrayUsingPredicate:filterPredicate];

//    
    for (int i=0; i<ysarr.count; i++) {
        for (int j=0; j<reslutFilteredArray.count; j++){
            if ([ysarr objectAtIndex:i]==[reslutFilteredArray objectAtIndex:j]){
                imvbuts.frame=CGRectMake(5*KIphoneWH+i*55*KIphoneWH,120*KIphoneWH, 50*KIphoneWH,40*KIphoneWH);
            }
        }
    }
    chima=(int)b.tag;
}

-(void)changeys:(UIButton *)b{
        imvbut.frame=b.frame;
        for (int i=0; i<arrays.count; i++) {
            if ([[ys objectForKey:[arrays objectAtIndex:i]]containsObject:[ysarr objectAtIndex:b.tag-101]]) {
            }else{
                imvbuts.frame=CGRectMake(5*KIphoneWH+i*55*KIphoneWH, 220*KIphoneWH, 50*KIphoneWH, 40*KIphoneWH);
            }
        }
    yanse=(int)b.tag;
}
#pragma mark 数量
-(void)zengjian:(UIButton *)b{
    if (b.tag==0) {
        if (gs==100) {
            return;
        }
        gs++;
        sllabel.text=[NSString stringWithFormat:@"%zd",gs];
    }
    else if (b.tag==1) {
        //-
        if (gs==1) {
            return;
        }
        gs--;
        sllabel.text=[NSString stringWithFormat:@"%zd",gs];
    }
}

#pragma mark 点击后 进入商品 加入购物车 订单界面
-(void)pushcar{
    
    if (cgs==0) {
        [self pop];
        
    }else{
    if (yanse==0) {
        [Uikility alert:@"请选择颜色！"];
        return;
    }
    if (chima==0) {
        [Uikility alert:@"请选择尺码！"];
        return;
    }
    if([[ys objectForKey:[arrays objectAtIndex:chima-1]]containsObject:[ysarr objectAtIndex:yanse-101]]) {
      MBProgressHUD * huds=[MBProgressHUD showHUDAddedTo:view animated:YES];
        huds.dimBackground = YES;
        huds.delegate = self;
        NSString *ysfl=[ysarr objectAtIndex:yanse-101];
        NSString *cmfl=[arrays objectAtIndex:chima-1];
        NSString *yscm=[NSString stringWithFormat:@"颜色分类:%@;尺寸:%@",ysfl,cmfl];
        if (cgs==1) {
            [self json1:yscm save:YES];
            [huds removeFromSuperview];
            huds=nil;
        }else if(cgs==2){
            sparr=[[NSMutableArray  alloc] init];
            CartModel *d=[[CartModel alloc]init];
           // NSString *s=[NSString stringWithFormat:@"%d",gs];
            
            //NSNumber * nums = @([s integerValue]);
            d.quantity=gs;
            d.logopicUrl=[[_dictionary objectForKey:@"goods"]objectForKey:@"logopicUrl"];
            d.id=[[_dictionary objectForKey:@"goods"]objectForKey:@"id"];
            d.goodsName=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsName"];
            d.attribute=yscm;
            d.promotionPrice=[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"];
            d.vipPrice=[[_dictionary objectForKey:@"goods"] objectForKey:@"vipPrice"];
            d.logopic=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"logopic"];
            d.brandName=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"brandName"];
            
             d.brandid=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"id"];
            
            d.appStoresId=_storeId;
            [sparr addObject:d];
            DingdanViewController *f=[[DingdanViewController alloc]init];
            f.flag=_flag;
            
        
            NSMutableArray *_groupArr = [NSMutableArray array];
            NSMutableArray *currentArr = [NSMutableArray array];
            
            // 因为肯定有一个字典返回,先添加一个
            [currentArr addObject:sparr[0]];
            [_groupArr addObject:currentArr];
            // 如果不止一个,才要动画添加
            if(sparr.count > 1){
                for (int i = 1; i < sparr.count; i++) {
                    // 先取出组数组中  上一个模型数组的第一个字典模型的groupID
                    NSMutableArray *preModelArr = [_groupArr objectAtIndex:_groupArr.count-1];
                    CartModel *model=[preModelArr objectAtIndex:0];
                    NSString *preGroupID = model.brandName ;
                    // 取出当前字典,根据groupID比较,如果相同则添加到同一个模型数组;如果不相同,说明不是同一个组的
                    CartModel *currentDict = sparr[i];
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

            
            f.array=_groupArr;
            CGFloat danjia=[Uikility priceToCompareVipprice:[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"] vipnumber:[[_dictionary objectForKey:@"goods"]objectForKey:@"vipPrice"]];
            NSString *djsprice=[NSString stringWithFormat:@"%.1f",danjia];
            f.allprice=djsprice.floatValue*gs;
            f.gs=gs;
            f.StoresId=_storeId;
        [self.navigationController pushViewController:f animated:YES];
            [huds removeFromSuperview];
            huds=nil;
        }
 }
    }
}
#pragma mark 点击 返回商品界面
-(void)pop{
    view.alpha=0;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark 头视图
-(void)addheadview{
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,WIDTH+ 150*KIphoneWH)];
    headview.backgroundColor=[UIColor whiteColor];
  
    NSString *str=[[_dictionary objectForKey:@"goods"]objectForKey:@"images"];
        headscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
        headscroll.pagingEnabled = YES;//整页
        headscroll.scrollEnabled = YES;
        headscroll.delegate = self;
        [headview addSubview:headscroll];
     headscroll.showsHorizontalScrollIndicator=false;
    page=[[UIPageControl alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH,WIDTH -20*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    [page addTarget:self action:@selector(sender:) forControlEvents:UIControlEventEditingChanged];
    // [self performSelector:@selector(video) withObject:nil afterDelay:1.5];
    [headview addSubview:page];
        _imarray= [str componentsSeparatedByString:@";"];
  
    if (_imarray.count>0) {
        
    
        for (int i=0; i<_imarray.count-1; i++) {
            
            page.numberOfPages=_imarray.count-1;
            headscroll.contentSize = CGSizeMake(WIDTH*(_imarray.count-1), 0);
            NSString *ims=[_imarray objectAtIndex:i];
           
            UIImageView *imageview = [[UIImageView alloc] init];
            imageview.contentMode=UIViewContentModeScaleAspectFit;
            [imageview sd_setImageWithURL:[Uikility URLWithString:ims] placeholderImage:[UIImage imageNamed:@"uuu"]];
            
            imageview.userInteractionEnabled=YES;
            
           ShufflingTapGestureRecognizer *tap1=[[ShufflingTapGestureRecognizer  alloc]
                                          initWithTarget:self action:@selector(pictures:)];
            tap1.tag=i;
            [imageview  addGestureRecognizer:tap1];
           
            imageview.frame=CGRectMake(WIDTH*i, 0, WIDTH, WIDTH);
            [_phtotsubviews addObject:imageview];
            [headscroll addSubview:imageview];
            if (i==0) {
                imstr=[_imarray objectAtIndex:0];
            }
        }
    
    }
    
  
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, WIDTH+ 5*KIphoneWH, WIDTH-30*KIphoneWH, 50*KIphoneWH)];
    label1.numberOfLines=2;
    label1.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [headview addSubview:label1];
    label1.textColor=[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    label1.text=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsName"];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, WIDTH+ 55*KIphoneWH, 200*KIphoneWH, 30*KIphoneWH)];
    label2.textColor=[UIColor colorWithRed:233/255.0 green:94/255.0 blue:75/255.0 alpha:1];
    [headview addSubview:label2];
    //打折后的价格
    label2.font=[UIFont systemFontOfSize:25*KIphoneWH];
    
   // NSString *s2=[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"];
    CGFloat s3=[Uikility priceToCompareVipprice:[[_dictionary objectForKey:@"goods"] objectForKey:@"promotionPrice"] vipnumber:[[_dictionary objectForKey:@"goods"] objectForKey:@"vipPrice"]];
    label2.text=[NSString stringWithFormat:@"￥%.1f",s3];
    
    //vip 价格lable
    
    if([[_dictionary objectForKey:@"goods"] objectForKey:@"vipPrice"]!=nil){
        
        NSNumber *price=[[_dictionary objectForKey:@"goods"] objectForKey:@"promotionPrice"];
        NSNumber *vipprice=[[_dictionary objectForKey:@"goods"] objectForKey:@"vipPrice"];
        
        if(price.integerValue>vipprice.integerValue){
            NSNumber *vipp=[[_dictionary objectForKey:@"goods"] objectForKey:@"vipPrice"];
            CGFloat sss=vipp.floatValue;
         label2.text=[NSString stringWithFormat:@"VIP:%.1f",sss];
        
        }else{
            NSNumber *pro=[[_dictionary objectForKey:@"goods"] objectForKey:@"promotionPrice"];
            CGFloat sss=pro.floatValue;
            label2.text=[NSString stringWithFormat:@"￥:%.1f",sss];
        
        
        }
        
    
    }
    
    //原价
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, WIDTH+ 90*KIphoneWH,60*KIphoneWH, 20*KIphoneWH)];
    label3.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [headview addSubview:label3];
    label3.font=[UIFont systemFontOfSize:15*KIphoneWH];
    label3.text=@"价格 ";
    
    NSString *s=(NSString *)[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsPrice"];
    CGFloat ss=s.floatValue;
    if (ss) {
        lplabel=[[LPLabel alloc]initWithFrame:CGRectMake(60*KIphoneWH,WIDTH+ 90*KIphoneWH,100*KIphoneWH, 20*KIphoneWH)];
        lplabel.text=[NSString stringWithFormat:@"￥%.1f",ss];
        lplabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
        
        lplabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
        
        [headview addSubview:lplabel];
      
    }
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH,WIDTH +120*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    label4.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [headview addSubview:label4];
    label4.font=[UIFont systemFontOfSize:15*KIphoneWH];
    label4.text=@"快递： 0.0";
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-20*KIphoneWH, WIDTH +120*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    label5.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [headview addSubview:label5];
    label5.font=[UIFont systemFontOfSize:15*KIphoneWH];
       NSString * salezcount=[[_dictionary objectForKey:@"goods"] objectForKey:@"saleCount"];
    
    
    if(salezcount==nil){
        label5.text=@"销量0笔";
     
    }else{
   label5.text=[NSString stringWithFormat:@"销量%@笔",salezcount];
    
    
    }
    [views addSubview:headview];
}

#pragma mark-------------图片轮播图

-(void)pictures:(ShufflingTapGestureRecognizer *)Recognize{
    
    NSMutableArray *selsctarray=[[NSMutableArray alloc] init];
    for (int i=0; i<_imarray.count-1; i++) {
        MJPhoto *photo=[[MJPhoto alloc] init];
        
        NSURL *imageurl=[Uikility URLWithString:_imarray[i]];
        photo.url=imageurl;
        photo.srcImageView=_phtotsubviews[i];
        [selsctarray addObject:photo];
    }
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    browser.photos=selsctarray;
    browser.currentPhotoIndex=Recognize.tag;
    //browser.delegate=self;
    
    //[self.view addSubview:browser.view];
    [browser show];
    
    //UIViewController *cvv=[[UIViewController alloc] init];
    //cvv.view.backgroundColor=[UIColor redColor];
    //[self.view addSubview:cvv.view];
    
}


#pragma mark 尾视图
-(void)addfootviews{
    footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 160*KIphoneWH)];
    footview.backgroundColor=[UIColor whiteColor];
   
    UIView *v12=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150*KIphoneWH)];
    v12.backgroundColor=[UIColor clearColor];
    [footview addSubview:v12];

    NSString *im=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"logopic"];
    UIImageView *imagv = [[UIImageView alloc] init];
    [imagv sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];

    imagv.frame=CGRectMake(5*KIphoneWH, 5*KIphoneWH,100*KIphoneWH,100*KIphoneWH);
    [v12 addSubview:imagv];
    UILabel *labelname=[[UILabel alloc]initWithFrame:CGRectMake(110*KIphoneWH, 10*KIphoneWH,WIDTH-150*KIphoneWH, 30*KIphoneWH)];
    labelname.text=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"brandName"];
    labelname.numberOfLines=0;
    [v12 addSubview:labelname];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(110*KIphoneWH, 40*KIphoneWH,WIDTH-150*KIphoneWH, 55*KIphoneWH)];
    label2.text=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"detail"];
    label2.numberOfLines=3;
    [v12 addSubview:label2];
    label2.font=[UIFont systemFontOfSize:15*KIphoneWH];
    label2.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];

    titleimageview=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-60*KIphoneWH,120*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    
    if ([[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"flag"] integerValue]==0) {
        titleimageview.userInteractionEnabled=YES;
        
            
        
        UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(impush)];
        [titleimageview addGestureRecognizer:imgtap];
    titleimageview.image=[UIImage imageNamed:@"收藏"];
    }else{
     titleimageview.image=[UIImage imageNamed:@"34-33(1)"];
    }
   
    [v12 addSubview:titleimageview];
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH, 110*KIphoneWH, 100*KIphoneWH, 40*KIphoneWH)];
    [but setBackgroundImage:[UIImage imageNamed:@"进入店铺"] forState:UIControlStateNormal];
    
    [but addTarget:self action:@selector(butpush) forControlEvents:UIControlEventTouchUpInside];
    [v12 addSubview:but];
   

}
#pragma mark 收藏
-(void)impush{
    if (_brands==YES) {
        [Uikility alert:@"你已经收藏该品牌"];
    }else{
     if ([de objectForKey:@"userId"]) {
         NSDictionary *ds=nil;
         if ([de objectForKey:@"newUserId"]) {
             ds=@{
                                @"userId":[de objectForKey:@"userId"]
                                };
         }else{
         
          ds=@{@"userId":[de objectForKey:@"userId"]
                                };
         }
         
         
         
         NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:ds options:NSJSONWritingPrettyPrinted error:nil];
         NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
         //去掉空白格和换行符
         jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
         jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
         jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
         
         NSDictionary *d1=@{
                            @"id":[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"id"]
                            
                            };
         NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
         NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
         //去掉空白格和换行符
         jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
         jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
         jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
         NSMutableDictionary *dics3=[[NSMutableDictionary alloc] init];
         [dics3 setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
          [dics3 setObject:jsond1 forKey:@"appbrandId"];
          [dics3 setObject:jsond forKey:@"appuserId"];
          [dics3 setObject:[de objectForKey:@"userId"] forKey:@"userId"];
         if ([de objectForKey:@"newUserId"]) {
             [dics3 setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
         }
         [dics3 setObject:@1 forKey:@"model"];
         
          [dics3 setObject:VERSION forKey:@"ios_version"];
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dics3 options:NSJSONWritingPrettyPrinted error:nil];
         NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
         //去掉空白格和换行符
         json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
         json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
         json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
         json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
         json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
         json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
         json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
         NSDictionary *json123=@{@"param":json};
        
        NSString *url3=[BassAPI requestUrlWithPorType:PortTypeSaveBrand];
        
       [AFManger postWithURLString:url3 parameters:json123 success:^(id responseObject) {
           id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[strs objectForKey:@"success"] boolValue];
           // NSString *msg=[strs objectForKey:@"msg"];
           if (success) {
               [Uikility alert:@"收藏成功！"];
               titleimageview.image=[UIImage imageNamed:@"34-33(1)"];
               _brands=YES;
           }else{
               [Uikility alert:[strs objectForKey:@"msg"]];
           }
 
       } failure:^(NSError *error) {
          [Uikility alert:@"数据接受失败！"];
       }];
            }else{
        //[Uikility alert:@"请先登录！"];
        LoginViewController *log=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:log animated:YES];
    }
    }
}
#pragma mark 店铺
-(void)butpush{
    PpViewController *pp=[[PpViewController alloc]init];
    pp.hidesBottomBarWhenPushed=YES;
    pp.flag=1;
    pp.dic=[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"];
    pp.appbrandId=[[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId"]objectForKey:@"id"];
    [self.navigationController pushViewController:pp animated:YES];
    
}
#pragma mark 商品详情底层scollview

-(void)addspxq{

    UIButton *leftbut=[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 40*KIphoneWH, 70*KIphoneWH)];
    
    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
    UIImage *img=[UIImage imageNamed:@"返回p"];
    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
    [leftbut addSubview:imgv];
    imgv.frame=CGRectMake(15*KIphoneWH, 40*KIphoneWH, 10*KIphoneWH, 15*KIphoneWH);
    [leftbut addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    leftbut.tag=1;
    [views addSubview:leftbut];
    
    
    
    UIButton *rightbut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50*KIphoneWH, 0*KIphoneWH, 50*KIphoneWH, 60*KIphoneWH)];
    UIImageView *rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 35*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    rightImageView.image=[UIImage imageNamed:@"分享"];
    [views addSubview:rightImageView];
    
    [rightbut addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    rightbut.tag=2;
    [views addSubview:rightbut];
    _segment = [[HYSegmentedControl alloc] initWithOriginY:3 width:WIDTH-80*KIphoneWH color:[UIColor colorWithRed:246/255.0 green:186/255.0 blue:90/255.0 alpha:1]Titles:@[@"商品",@"详情",@"评价"] delegate:self] ;
    
   
    _segment.delegate=self;
    [views addSubview:_segment];
    if (iPhoneX) {
       scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70*KIphoneWH+20, WIDTH, HEIGHT-124*KIphoneWH-20)];
        _segment.frame=CGRectMake(40*KIphoneWH, 30*KIphoneWH+20, WIDTH-80*KIphoneWH-20, 40*KIphoneWH);
        leftbut.frame=CGRectMake(0, 20, 40*KIphoneWH, 70*KIphoneWH);
        rightbut.frame=CGRectMake(WIDTH-50*KIphoneWH, 20, 50*KIphoneWH, 60*KIphoneWH);
        rightImageView.frame=CGRectMake(WIDTH-40*KIphoneWH, 35*KIphoneWH+20, 20*KIphoneWH, 20*KIphoneWH);
    }else{
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
        _segment.frame=CGRectMake(40*KIphoneWH, 30*KIphoneWH, WIDTH-80*KIphoneWH, 40*KIphoneWH);
    }
    
    scroll.contentSize=CGSizeMake(WIDTH*3, 0);
    scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    scroll.delegate=self;
    [views addSubview:scroll];
    
  

}
-(void)addtableview{

    
    table1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-124*KIphoneWH)style:UITableViewStyleGrouped];
    table1.delegate=self;
    table1.dataSource=self;
    table1.tag=1;
    [scroll addSubview:table1];
    [self addheadview];
    table1.tableHeaderView=headview;
    [self addfootviews];
    table1.tableFooterView=footview;
    //*详情页------------
    UIView *detailsview=[[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-164*KIphoneWH)];
    
    //detailsview.backgroundColor=[UIColor grayColor];
    _webview=[[UIWebView alloc] initWithFrame:CGRectMake(12*KIphoneWH, 40*KIphoneWH, WIDTH-24*KIphoneWH,HEIGHT-164*KIphoneWH )];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(12*KIphoneWH, 0, WIDTH-24*KIphoneWH, 40*KIphoneWH)];
    lable.text=@"--------------  商品详情  --------------";
    lable.textColor=[UIColor colorWithRed:233.0/255.0 green:94.0/255.0 blue:75.0/255.0 alpha:1];
    lable.textAlignment=NSTextAlignmentCenter;
    [detailsview addSubview:lable];
    
   if ([[_dictionary objectForKey:@"goods"]objectForKey:@"goodsNewDetail"]) {
      
        
        _table2=[[UITableView alloc] initWithFrame:CGRectMake( 10*KIphoneWH, 40*KIphoneWH, WIDTH-20*KIphoneWH,HEIGHT-164*KIphoneWH )style:UITableViewStylePlain];
        _table2.delegate=self;
        _table2.dataSource=self;
        
        
        [detailsview addSubview:_table2];
        
        }else if ([[_dictionary objectForKey:@"goods"]objectForKey:@"goodsDetail"]){
        _webview=[[UIWebView alloc] initWithFrame:CGRectMake(12*KIphoneWH, 40*KIphoneWH, WIDTH-24*KIphoneWH,HEIGHT-164*KIphoneWH )];
        [detailsview addSubview:_webview];
        NSString *str=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsDetail"];
        NSRange rang=[str rangeOfString:@"src='"];
        NSRange rang1=[str rangeOfString:@"' width"];
        NSUInteger urllocation=rang.location+rang.length;
        NSUInteger urllength=rang1.location-urllocation;
        NSString *urlstr=[str substringWithRange:NSMakeRange(urllocation, urllength)];
        _webview.scalesPageToFit=YES;
        _webview.delegate=self;
        NSURLRequest *requust=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        [_webview loadRequest:requust];
    
    }
    
    
    
    
    //详情页 ----轮播图
    
    
    [scroll addSubview:detailsview];
    
    table3=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT-124*KIphoneWH)style:UITableViewStyleGrouped];
    table3.delegate=self;
    table3.dataSource=self;
    table3.tag=3;
    //table3.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 5*KIphoneWH)];
    view3.backgroundColor=[UIColor whiteColor];
    table3.tableHeaderView=view3;
    [scroll addSubview:table3];
    [self addtoolbar];
}
#pragma mark 导航栏 按钮 分享界面
-(void)change:(UIButton *)b{
    
    if (b.tag==1) {
       
        //[self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(b.tag==2){
        
      _shareView=[[UGShareView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        //_shareView.backgroundColor=[UIColor blueColor];
        _shareView.delegate=self;
        [self.view addSubview:_shareView];
        _shareView.alpha=1;
    }
}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{ if (index==2) {
    //[self evaluationreadtata];
}
    [scroll setContentOffset:CGPointMake(WIDTH*(int)index, 0) animated:YES];
}

-(void)sender:(UIPageControl *)p{
    int index = (int)p.currentPage;
    [headscroll setContentOffset:CGPointMake(WIDTH*index, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = headscroll.contentOffset.x/WIDTH;
    page.currentPage = index;
    int index1 = scroll.contentOffset.x/WIDTH;
    if (index==2) {
        //[self evaluationreadtata];
    }
 [_segment changeSegmentedControlWithIndex:index1];
}
#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==table3) {
        if (_evdataarray.count) {
            return _evdataarray.count;
        }else{
            return 0;
        }
    }else if (tableView==_table2){
        
        NSString *str=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsNewDetail"];
        
       _webimagearray= [str componentsSeparatedByString:@";"];
        
        if(_webimagearray.count){
        
            return _webimagearray.count-1;}else{
            
                return 0;
            }
    
    }else if (tableView==table1){
    
        return 4;
    
    
    }
    
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (table3==tableView) {
        if (_evdataarray.count) {
            
        
        CartModel *model=_evdataarray[indexPath.row];
        CGSize size=[model.content boundingRectWithSize:CGSizeMake(WIDTH-30*KIphoneWH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*KIphoneWH]forKey:NSFontAttributeName] context:nil].size;
            return 50*KIphoneWH+size.height*KIphoneWH;
        }
    }else if(table1==tableView){
        if (indexPath.row==2) {
            
        
        if(_selectrow==2){
        
            return 220*KIphoneWH;
        
        }
    }
    
        return 44*KIphoneWH;
    
    }else if (tableView==_table2){
    
    
        return WIDTH;
    
    }


    return 44*KIphoneWH;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    if (table1==tableView) {
        
        if (indexPath.row==2) {
            static NSString *idenxtifier=@"row2";
            
            ProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenxtifier];
            if (!cell) {
                cell=[[ProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenxtifier];
                
        }
           cell.textlable.text=@"产品参数";
            NSString *canshu=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsIntro"];
               cell.titlable.text=canshu;
            if (_selectrow==2) {
                cell.titlable.alpha=1;
            }else{
                cell.titlable.alpha=0;
            }
            UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 15*KIphoneWH, 10*KIphoneWH, 10*KIphoneWH)];
            imv.image=[UIImage imageNamed:@"向前"];
            [cell addSubview:imv];

             return cell;

        }else{
    static NSString *idenxtifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenxtifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenxtifier];
    }
    if (tableView.tag==1) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                cell.textLabel.text=@"我的U币";
                cell.imageView.frame=CGRectMake(0, 0, 40*KIphoneWH, 40*KIphoneWH);
                cell.imageView.image=[UIImage imageNamed:@"u币1@2x"];
            }
            if (indexPath.row==1) {
                cell.textLabel.text=@"我的卡券";
                cell.imageView.frame=CGRectMake(0, 0, 40*KIphoneWH, 40*KIphoneWH);
                cell.imageView.image=[UIImage imageNamed:@"卡券@2x"];
                
            }

            if (indexPath.row==3) {
                cell.textLabel.text=@"请选择 尺码";
                
            }
            UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 15*KIphoneWH, 10*KIphoneWH, 10*KIphoneWH)];
            imv.image=[UIImage imageNamed:@"向前"];
            [cell addSubview:imv];
            
        
        }
    }
            return cell;
        }
    }
    if (table3==tableView) {
        EvaluateTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qqq"];
        if (!cell) {
            cell=[[EvaluateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
        }
        if (_evdataarray.count) {
            
        
        CartModel *model=_evdataarray[indexPath.row];
        cell.namelable.text=model.userName;
           
        cell.titlelable.text=model.content;
        cell.attributelable.text=model.attribute;
          long long s=  model.reTime.longLongValue;
            NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];
            
           long gg=sss.integerValue;
            
            NSString *timestr=[Uikility DatetoTime:gg];
            
            cell.timelable.text=timestr;
        CGSize size=[model.content boundingRectWithSize:CGSizeMake(WIDTH-30*KIphoneWH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:cell.titlelable.font forKey:NSFontAttributeName] context:nil].size;
        CGRect frame=cell.titlelable.frame;
        frame.size.width=WIDTH-30*KIphoneWH;
        frame.size.height=size.height;
            
        cell.titlelable.frame=frame;
        CGRect attframe=cell.attributelable.frame;
        attframe.origin.y=size.height+30*KIphoneWH;
        cell.attributelable.frame=attframe;
        CGRect timeframe=cell.timelable.frame;
        timeframe.origin.y=size.height+30*KIphoneWH;
        cell.timelable.frame=timeframe;
        //return cell;
        }
        return cell;
    }else if (tableView==_table2){
        
        
        ImageTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ugou2"];
        
        if (!cell) {
            cell=[[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ugou2"];
        }
        
    
        NSString *str=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsNewDetail"];
        
        _webimagearray= [str componentsSeparatedByString:@";"];
        
       
           
            
            NSString *ims=[_webimagearray objectAtIndex:indexPath.row];
            
        
            [ cell.imageview1   sd_setImageWithURL:[Uikility URLWithString:ims] placeholderImage:[UIImage imageNamed:@"uuu"]];
        
        return cell;
    }
    
        return cell;
}



#pragma mark 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==table1) {
        if (indexPath.row==2) {
            
            if (_selectrow==2) {
                _selectrow=1;
            }else{
               _selectrow=2;
            }
            
            [tableView reloadData];
            
        }else if (indexPath.row==0){
            if ([de objectForKey:@"userId"]) {
                
            
            UbViewController *u=[[UbViewController alloc]init];
            [self.navigationController pushViewController:u animated:YES];
            }else{
                //[Uikility alert:@"请先登录！"];
                LoginViewController *log=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:log animated:YES];
            }
            
        }else if (indexPath.row==1){
            if ([de objectForKey:@"userId"]) {
                
                
               MKjViewController *u=[[MKjViewController alloc]init];
                [self.navigationController pushViewController:u animated:YES];
            }else{
                //[Uikility alert:@"请先登录！"];
                LoginViewController *log=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:log animated:YES];
            }
           
        
        }else if (indexPath.row==3){
        
        
            cgs=0;
            view.alpha=1;
        
        }
    }else if (tableView==_table2){
        NSString *str=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsNewDetail"];
        
      _imarray= [str componentsSeparatedByString:@";"];
        
        
        NSMutableArray *selsctarray=[[NSMutableArray alloc] init];
        for (int i=0; i<_imarray.count-1; i++) {
            MJPhoto *photo=[[MJPhoto alloc] init];
            
            NSURL *imageurl=[NSURL URLWithString:_imarray[i]];
            photo.url=imageurl;
            UIImage *image1=[UIImage imageNamed:@"uuu"];
            photo.image=image1;
            [selsctarray addObject:photo];
        }
        MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
        browser.photos=selsctarray;
        browser.currentPhotoIndex=indexPath.row;
        //browser.delegate=self;
        
        //[self.view addSubview:browser.view];
        [browser show];
        

    
    
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 数据
-(void)json{
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
     NSNumber * nums = @([_goodsId integerValue]);
   
    [mudic setObject:nums forKey:@"goodsId"];
    
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    if ([de objectForKey:@"userId"]) {
        [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
    
    }
    NSDictionary *json1=[Uikility initWithdatajson:mudic];

    
    NSString *urls=[BassAPI requestUrlWithPorType:PortTypeGetGoodsId];
    [AFManger postWithURLString:urls parameters:json1 success:^(id responseObject) {
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
     
        Boolean success=[[strs objectForKey:@"success"] boolValue];
        if (success) {
            _dictionary=[strs objectForKey:@"data"];
            
           
            [[_dictionary objectForKey:@"goods"]objectForKey:@"flag"];
            [[[_dictionary objectForKey:@"goods"]objectForKey:@"appbrandId" ] objectForKey:@"flag"];
            
            
            [self addtableview];
            
            [self evaluationreadtata];
            
            
        }else{
            [Uikility alert:[strs objectForKey:@"msg"]];
        }

    } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
    }];
}
#pragma mark----评价页面数据请求
-(void)evaluationreadtata{
    NSNumber * nums = @([_goodsId integerValue]);
   
    if ([de objectForKey:@"userId"]) {
        if ([de objectForKey:@"newUserId"]) {
             dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"goodsId":nums,@"model":@1,@"ios_version":VERSION};
        }else{
        
        dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"goodsId":nums,@"model":@1,@"ios_version":VERSION};
        }
        
    }else{
        dic=@{@"goodsId":nums,@"model":@1,@"ios_version":VERSION};
    }
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeSelectEvaluate];
    NSDictionary *dicurl=[Uikility initWithdatajson:dic];
    [AFManger postWithURLString:urlstr parameters:dicurl success:^(id responseObject) {
        id json2=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        Boolean success=[[json2 objectForKey:@"success"] boolValue];
        
        if (success) {
            
            NSArray *array=[json2 objectForKey:@"data"];
            
            for (NSDictionary *dicda in array ) {
                CartModel *model=[CartModel initwithdic:dicda];
                model.userName=[[dicda objectForKey:@"appuserId"]objectForKey:@"userName"];
                [_evdataarray addObject:model];
            }
            [table3 reloadData];
        }else{
            [Uikility alert:[json2 objectForKey:@"msg"]];
        }

    } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
    }];
  }
#pragma mark    添加到购物车
-(void)json1:(NSString *)yc save:(BOOL)YN{
    // NSDictionary  *d=[[NSDictionary alloc]init];
    
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
  
    if ([de objectForKey:@"userId"]) {
        
        
    NSDictionary *d=@{
                      @"userId":[de objectForKey:@"userId"]
                      };
    
    NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
    //去掉空白格和换行符
    jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
    
    NSDictionary *d1=@{
                       @"id": [[_dictionary objectForKey:@"goods"]objectForKey:@"id"]

                       };
    NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
    //去掉空白格和换行符
    jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if (YN==YES) {
        
        NSString *sl=[NSString stringWithFormat:@"%zd",gs];
        NSDictionary *dicc=nil;
        NSString *jsonstr=nil;
        if (_flag==1) {
            
        }else{
        dicc=@{@"id":_storeId};
            jsonstr=[Uikility initWithdatajsonstring:dicc];
        }
        
        if (_flag==1) {
            if ([de objectForKey:@"newUserId"]) {
                [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
            }
            
            [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            [mudic setObject:jsond1 forKey:@"appgoodsId"];
            [mudic setObject:jsond forKey:@"appuserId"];
            [mudic setObject:yc forKey:@"attribute"];
            [mudic setObject:@true forKey:@"model"];
            [mudic setObject:[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"] forKey:@"price"];
            [mudic setObject:sl forKey:@"quantity"];
            [mudic setObject:VERSION forKey:@"ios_version"];
            [mudic setObject:[de objectForKey:@"placename"] forKey:@"chinaCode"];
            NSNumber *vipflag=[Uikility ifVIPmemberPprice:[[_dictionary objectForKey:@"goods"] objectForKey:@"promotionPrice"]  VIPnumber:[[_dictionary objectForKey:@"goods"] objectForKey:@"vipPrice"]];
            [mudic setObject:vipflag forKey:@"vipFlag"];
            
        }else{
            
            [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            
            if ([de objectForKey:@"newUserId"]) {
                [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
            }
            [mudic setObject:jsond1 forKey:@"appgoodsId"];
            [mudic setObject:jsond forKey:@"appuserId"];
            [mudic setObject:yc forKey:@"attribute"];
            [mudic setObject:@true forKey:@"model"];
            [mudic setObject:[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"] forKey:@"price"];
            [mudic setObject:sl forKey:@"quantity"];
            [mudic setObject:@1 forKey:@"model"];
            [mudic setObject:VERSION forKey:@"ios_version"];
            [mudic setObject:jsonstr forKey:@"appStoresId"];
            [mudic setObject:[de objectForKey:@"placename"] forKey:@"chinaCode"];
            NSNumber *vipflag=[Uikility ifVIPmemberPprice:[[_dictionary objectForKey:@"goods"] objectForKey:@"promotionPrice"] VIPnumber:[[_dictionary objectForKey:@"goods"]objectForKey:@"vipPrice" ]];
            [mudic setObject:vipflag forKey:@"vipFlag"];
            
        }
        
    }
        
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mudic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //去掉空白格和换行符
    json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
    json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
    json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
    json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSDictionary *json1=nil;
    
    if (YN==YES){
       NSString *aesstr=[SecurityUtil encryptAESData:json passwordKey:[de objectForKey:COOKIE]];
            json1=@{@"param":aesstr};
        
   }
   if (YN==YES){
    if (_flag==1) {
      
        url=[BassAPI requestUrlWithPorType:PortTypeSaveCart];
    }else if(_flag==2){
   
      url=  [BassAPI requestUrlWithPorType:PortTypeShoppingcart];
    }else if (_flag==3){

        url=[BassAPI requestUrlWithPorType:PortTypeComecart];
    }
    
     }
    NSString * userid=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        
        NSString *bassuser=[GTMBase64 encodeBase64String:userid];
    [AFManger headerFilePostWithURLString:url parameters:json1 Hearfile:bassuser success:^(id responseObject) {
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[strs objectForKey:@"success"] boolValue];
    
        if (success) {
            if (YN==YES) {
                [self pop];
                [Uikility alert:@"成功加入购物车！"];
            }
        }else{
                [Uikility alert:[strs objectForKey:@"msg"]];
            }
   } failure:^(NSError *error) {
       
         [Uikility alert:@"数据接受失败！"];
    }];
    }else{
    //[Uikility alert:@"请先登录！"];
    LoginViewController *log=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
    }
}
#pragma mark----收藏商品
-(void)collectiongoods{
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    
    if ([de objectForKey:@"userId"]) {
        
        
        NSDictionary *d=@{
                          @"userId":[de objectForKey:@"userId"]
                          };
        
        NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        
        NSDictionary *d1=@{
                           @"id": [[_dictionary objectForKey:@"goods"]objectForKey:@"id"]
                           
                           };
        NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        [mudic setObject:jsond1 forKey:@"appgoodsId"];
        [mudic setObject:jsond forKey:@"appuserId"];
        [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [mudic setObject:@1 forKey:@"model"];
        [mudic setObject:VERSION forKey:@"ios_version"];
        [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
       
      NSDictionary * json1= [Uikility initWithdatajson:mudic];
        
        
        url=[BassAPI requestUrlWithPorType:PortTypeSaveGoods];
        [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            
            if (success) {
                UIButton *butt=(id)[toolbar viewWithTag:10002];
                [butt setBackgroundImage:[UIImage imageNamed:@"34-33(1)"] forState:UIControlStateNormal];
                UIButton *butt1=(id)[toolbar viewWithTag:3];
                butt.selected=YES;
                butt1.selected=YES;
                [Uikility alert:@"收藏成功！"];
            }else{
             [Uikility alert:[strs objectForKey:@"msg"]];
            
            }
            
        } failure:^(NSError *error) {
            [Uikility alert:@"数据接受失败"];
        }];

    }else{
    
        LoginViewController *log=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:log animated:YES];
    }


}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str=  [[_dictionary objectForKey:@"goods"]objectForKey:@"goodsDetail"];
    
    [webView stringByEvaluatingJavaScriptFromString:str];

}
//创建分享页面
-(void)creatShareView{

   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
       
        
        NSString *imagesStr=[[_dictionary objectForKey:@"goods"]objectForKey:@"logopicUrl"];
        NSData *imagedata;
        
             imagedata=[NSData dataWithContentsOfURL:[Uikility URLWithString:imagesStr]];
        _shareImageData=imagedata;
    
    });
    
}

- (NSString *)typeForImageData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"image/jpeg";
            
        case 0x89:
            
            return @"image/png";
            
        case 0x47:
            
            return @"image/gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"image/tiff";
            
    }
    
    return nil;
    
}

-(void)UGShareViewHide{
    
    _shareView.alpha=0;
}
-(void)UGShareViewDidSelect:(shareType)shareType{
    //_shareView.alpha=0;
    NSString *goodsname=[[_dictionary objectForKey:@"goods"] objectForKey:@"goodsName"];
   
    NSString *shareURL=[NSString stringWithFormat:@"%@%@&ios_version=%@&area=%@&timestamp=%ld",ShareURL,_goodsId,VERSION,[de objectForKey:@"placename"],[Uikility readnowtime]];
    Uikility *kility=[[Uikility alloc] init];
    if (_shareImageData==nil) {
        
        return;
    }
    
    NSData *data=_shareImageData;
    
    UIImage *shareImage=[UIImage imageWithData:data];

    
    NSString   *shareText=@"U购--不一样的购物体验";
    //微信 微博小于32k
    switch (shareType) {
            
        case UGShareTypeSina:
        {
            
            _shareView.alpha=0;
            [kility shareYMWbsinaWithimage:_shareImageData title:goodsname description:shareText url:shareURL viewcontrol:self  ];
        }
            break;
        case UGShareTypeQQZone:
        {
            
            
            _shareView.alpha=0;
            [kility shareWithYmQQzone:goodsname Withurl:shareURL title:goodsname imagedata:shareImage imageurl:nil viewcontrol:self];
        }
            break;

        case UGShareTypeWX:
            
        {
            
           
            _shareView.alpha=0;
            
            
            [kility shareWithYMWXfrendtext:shareText Withurl:shareURL title:goodsname imagedata:data uiiamge:shareImage viewcontrol:self];
            
            
        }
            break;

        case UGShareTypeWeChat:
        {   _shareView.alpha=0;
            
            [kility shareWithYMWexintext:shareText Withurl:shareURL title:goodsname imagedata:data uiiamge:shareImage viewcontrol:self];
            
            
            
        }
            break;

            
        default:
            break;
    }


}





-(UIImage *)imageCompression:(UIImage *)imagedata{
    NSData * imageData = UIImageJPEGRepresentation(imagedata, 0.1);
    UIImage * newImage = [UIImage imageWithData:imageData];
    return newImage;
}

- (NSData *)zipImageWithUrl:(id)imageUrl
{
    NSData * imageData = [[NSData alloc]initWithContentsOfURL:[Uikility URLWithString:imageUrl]];
    //imageData = UIImagePNGRepresentation(imageUrl);
    CGFloat maxFileSize = 32*1024;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    UIImage *image = [UIImage imageWithData:imageData];
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        compressedData = UIImageJPEGRepresentation(image, compression);
    }
    //UIImage *compressedImage = [UIImage imageWithData:imageData];
    return imageData;
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
