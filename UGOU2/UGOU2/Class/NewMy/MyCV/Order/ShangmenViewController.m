//
//  ShangmenViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/24.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ShangmenViewController.h"
#import "HYSegmentedControl.h"
#import "DgTableViewCell.h"
#import "DingdanViewController.h"
#import "UIImageView+WebCache.h"
#import "UGPayManger.h"
#import "CartModel.h"
#import "SFViewController.h"
#import "MyViewController.h"
#import "BassAPI.h"
#import "DgHearderview.h"
#import "DgFootview.h"
#import "SMorderstatusViewController.h"
#import "ReturngoodsViewController.h"
#import "MainViewController.h"
#import "UGHeader.h"
@interface ShangmenViewController ()<HYSegmentedControlDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SFViewControllerDeleget,UGCustomnNavViewDelegate>{
    HYSegmentedControl *_segment;
    UIScrollView *scroll;
    UITableView *table1;
    UITableView *table2;
    UITableView *table3;
    UITableView *table4;
    NSDictionary *dictionary;
    NSMutableArray *muarr;
    NSString *url;
    UILabel *titlelabel;
    NSString *flagbd;
    UIImageView *_imageview;
    UILabel *_zlabel;
    UIButton *_but1;
    UIButton *_but2;
    UIButton *_but3;
    UIButton *_but4;
    BOOL _all;
    int rows;
    int sections;
    
    // UIView *v2;
    UIImageView *imvbut;
    int zf;
    NSArray *model;
    CGFloat pic;
    NSDictionary *dics;
    NSString *orderNos;
    NSString *ordernoss;
    NSString *ids;
    NSMutableArray *paramarr;
    NSString *urlS;
    UIView *v12;
    //UIView *view1;
    UIView *view2;
    NSArray *zfarr;
    CartModel *modelss;
    UIView *viewx;
    UIScrollView * _selcetscrollview;
    NSMutableArray *_secondarray;
    NSMutableArray *_threearray;
    NSInteger _arrpage;
    //支付界面
    UIView *v2;
    UIView *views2;
    NSUserDefaults *de;
}
@property(nonatomic,assign)UGPayObjctType payType;
@end
@implementation ShangmenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self adddaohanglan];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    muarr=[NSMutableArray array];
    paramarr=[NSMutableArray array];
    _secondarray=[[NSMutableArray alloc] init];
    _threearray=[[NSMutableArray alloc] init];
     de=[NSUserDefaults standardUserDefaults];
    [self adddaohanglan];
    [self addview];
    [self addtable];
    //[self creatviewtwo];
    //_flags=0;
    [self json:1 ];
    //_flags=0;
    //[self json:1 ];
    //[self secondread ];
    //[self threedread];
    //[self addtable];
    //[self pushview2];
    //[self json:1 and :-1];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    //[self adddaohanglan];
    //[self adddaohanglan];
    //[self addview];
    //[self addtable];
   // _flags=0;
    //[self json:1 ];
    //[self secondread ];
    //[self threedread];
//    [self json:1 ];
//    [self secondread ];
//    [self threedread];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden=NO;
}

-(void)secondread{
    _flags=1;
    
    [self json:1];
    
}
-(void)threedread{
    //全部
    _flags=2;
    [self json:1];
    
}
#pragma mark  导航栏
-(void)adddaohanglan{
    
//    titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(60*KIphoneWH, 20*KIphoneWH,WIDTH-120*KIphoneWH, 44*KIphoneWH)];
//    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64*KIphoneWH)];
//
//    _imageview.userInteractionEnabled=YES;
//    titlelabel.textColor=[UIColor whiteColor];
//    titlelabel.textAlignment=NSTextAlignmentCenter;
//    titlelabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
//    [_imageview addSubview:titlelabel];
//            titlelabel.text=@"上门试衣订单";
//        UIImage *image=[UIImage imageNamed:@"上门试衣横条"];
//        _imageview.image=image;
//        UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 60*KIphoneWH, 64*KIphoneWH )];
//    UIImage *img=[UIImage imageNamed:@"返回o"];
//    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
//    [leftButton addSubview:imgv];
//    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
//    [leftButton addTarget:self action:@selector(pushpop) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:_imageview];
//    [self.view  addSubview:leftButton];
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custemNav.Delegate=self;
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"上门试衣横条"]];
    custemNav.title=@"上门试衣订单";
    [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:custemNav];
}
-(void)LeftItemAction{
    
    [self pushpop];
}
-(void)creatviewtwo{
    
    v2=[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT)];
    [self.view addSubview:v2];
    UIView *views1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT/3)];
    views1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [v2 addSubview:views1];
    //返回
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popv1)];
    [views1 addGestureRecognizer:tap];
    views2=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/3, WIDTH, HEIGHT/3*2)];
    views2.backgroundColor=[UIColor whiteColor];
    [v2 addSubview:views2];
    UIImageView *fhimv=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 15*KIphoneWH, 15*KIphoneWH, 15*KIphoneWH)];
    fhimv.image=[UIImage imageNamed:@"返回p@2x"];
    [views2 addSubview:fhimv];
    fhimv.userInteractionEnabled=YES;
    //返回
    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popv1)];
    [fhimv addGestureRecognizer:imgtap];
    UILabel *titlelabel2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-80*KIphoneWH, 5*KIphoneWH,200*KIphoneWH, 40*KIphoneWH)];
    titlelabel2.text=@"选择付款方式";
    titlelabel2.font=[UIFont systemFontOfSize:24*KIphoneWH];
    [views2 addSubview:titlelabel];
   
        //if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        zfarr=@[@"支付宝支付",@"银联",@"微信支付"];
        // }else{
        //zfarr=@[@"支付宝支付",@"银联"];
        // }
        for (int i=0; i<zfarr.count; i++) {
        UILabel *zflabel=[[UILabel alloc]initWithFrame:CGRectMake(15*KIphoneWH, 50*KIphoneWH*i+50*KIphoneWH, WIDTH-40*KIphoneWH, 40*KIphoneWH)];
        zflabel.text=[zfarr objectAtIndex:i];
        zflabel.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0  blue:67/255.0  alpha:1];
        [views2 addSubview:zflabel];
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-35*KIphoneWH, 55*KIphoneWH+50*KIphoneWH*i, 30*KIphoneWH, 30*KIphoneWH)];
        but.tag=i+1;
        [but setBackgroundImage:[UIImage imageNamed:@"尺码分类底框"] forState:UIControlStateNormal];
        
        [but addTarget:self action:@selector(pushzf:) forControlEvents:UIControlEventTouchUpInside];
        [views2 addSubview:but];
    }
    imvbut=[[UIImageView alloc]init];
    imvbut.image=[UIImage imageNamed:@"蓝色小对勾"];
    [views2 addSubview:imvbut];
    
    
    UIButton *buts=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH,330*KIphoneWH, WIDTH-20*KIphoneWH, 40*KIphoneWH)];
    [buts setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[buts setTitle:@"确定" forState:UIControlStateNormal];
    [buts setBackgroundImage:[UIImage imageNamed:@"确定@2x"] forState:UIControlStateNormal];
    [buts addTarget:self action:@selector(pushxia) forControlEvents:UIControlEventTouchUpInside];[views2 addSubview:buts];
    v2.alpha=0;




}
#pragma mark 点击后 选择付款方式后
-(void)pushzf:(UIButton *)b{
    
    //继续
    
    imvbut.frame=b.frame;
    zf=(int)b.tag;
    
    //if (zf==3) {
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        // }else{
        //zf=4;
        //}
    }
    
}
-(void)pushxia{
    
    if (zf) {
    if ([de objectForKey:@"userId"]) {
        
        NSString *allprice=[NSString stringWithFormat:@"%.1d",100];
        NSNumber * min = @([allprice integerValue]);
        NSMutableDictionary *dicss=[Uikility creatSinGoMutableDictionary];
        if (zf==1) {
            self.payType=UGPayObjctTypeALPay;
            [dicss setObject:@"alipay" forKey:@"channelVal"];
            [dicss setObject:min forKey:@"amountVal"];
            [dicss setObject:@"苹果" forKey:@"subjectVal"];
            [dicss setObject:@"u购" forKey:@"bodyVal"];
            
        }else if (zf==2){
            self.payType=UGPayObjctTypeUPAPay;
            [dicss setObject:@"upacp" forKey:@"channelVal"];
            [dicss setObject:min forKey:@"amountVal"];
            [dicss setObject:@"苹果" forKey:@"subjectVal"];
            [dicss setObject:@"u购" forKey:@"bodyVal"];

        }else if (zf==3){
            self.payType=UGPayObjctTypeWX;
            [dicss setObject:@"wx" forKey:@"channelVal"];
            [dicss setObject:min forKey:@"amountVal"];
            [dicss setObject:@"苹果" forKey:@"subjectVal"];
            [dicss setObject:@"u购" forKey:@"bodyVal"];
        }
        
        NSDictionary *json1=[Uikility initWithdatajson:dicss];
        
        NSString *urls=[BassAPI requestUrlWithPorType:PortTypeReturnClient];
       [AFManger postWithURLString:urls parameters:json1 success:^(id responseObject) {
           id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           Boolean success=[[obj objectForKey:@"success"] boolValue];
          
           if (success) {
               
                //[self dingdan:1 paymessay:obj];
               
               
               
               
               NSData *jsonDatas = [NSJSONSerialization dataWithJSONObject:[obj objectForKey:@"data"]options:NSJSONWritingPrettyPrinted error:nil];
               NSString *jsons=[[NSString alloc] initWithData:jsonDatas encoding:NSUTF8StringEncoding];
               jsons=[jsons stringByReplacingOccurrencesOfString:@"orderNo" withString:@"order_no"];
               jsons=[jsons stringByReplacingOccurrencesOfString:@"clientIp" withString:@"client_ip"];
               jsons=[jsons stringByReplacingOccurrencesOfString:@"amountSettle" withString:@"amount_settle"];
               jsons=[jsons stringByReplacingOccurrencesOfString:@"timeExpire" withString:@"time_expire"];
               jsons=[jsons stringByReplacingOccurrencesOfString:@"hasMore" withString:@"has_more"];
               jsons=[jsons stringByReplacingOccurrencesOfString:@"amountRefunded" withString:@"amount_refunded"];
               
//               [Pingpp createPayment:jsons
//                      viewController:self
//                        appURLScheme:@"wx632d6c8a00776b9d"
//                      withCompletion:^(NSString *result, PingppError *error) {
//                          //_jumpbool=YES;
//                          if ([result isEqualToString:@"success"]) {
//                              //                                   //if (_pagenumer==1) {
//                              //                                       [self zfsuccess];
//                              //                                       ////////NSLog(@"线下支付");
//                              //                                   }else {
//                              //                                       //[self smdingdan:1 ];
//                              //
//                              //                                   }
//                              //
//                              //
//                              //                               } else {
//
//
//                          }
//                      }];
               
               
               [UGPayManger creatPayMent:obj viewController:self payType:self.payType payCompletion:^(NSString *result) {
                   
               }];
               
               
               
               
               
           }else{
               
               [Uikility alert:[obj objectForKey:@"msg"]];
           }

           
       } failure:^(NSError *error) {
             [Uikility alert:@"数据接受失败！"];
       }];
        
    }else{
        //登录
        [Uikility alert:@"请先登录！"];
        return;
        
    }

}else{
    [Uikility alert:@"请选择付款方式！"];
    return;
}

}

-(void)Showflag:(NSInteger)flag{
    
    _flag=flag;
    
   
        titlelabel.text=@"上门试衣订单";
        UIImage *image=[UIImage imageNamed:@"上门试衣横条"];
        _imageview.image=image;
   
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //_imageview.hidden=YES;
}

#pragma mark 导航栏点击返回
-(void)pushpop{
    self.navigationController.navigationBar.hidden=NO;
   // MyViewController *my=[[MyViewController alloc]init];
   // [self.navigationController pushViewController:my animated:YES];
    if(_indexflag==1){
    
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_indexflag==2){
       if (self.navigationController.viewControllers.count) {
                UIViewController *controller=self.navigationController.viewControllers[0];
                self.navigationController.navigationBar.hidden=NO;
                [self.navigationController popToViewController:controller animated:YES];
            }

        
            
    
    }
    
}

#pragma mark  头部
-(void)addview{
        //_segment = [[HYSegmentedControl alloc] initWithOriginY:4 width:WIDTH-20 color:[UIColor redColor] Titles:@[@"全部",@"待付款",@"待收货",@"待评论"] delegate:self] ;
    
    UIView *v3=[[UIView alloc]initWithFrame:CGRectMake(0, NavHeight+6*KIphoneWH, WIDTH, 40*KIphoneWH)];
    
    [self.view addSubview:v3];
    _selcetscrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40*KIphoneWH)];
    //_selcetscrollview.delegate=self;
    [v3 addSubview:_selcetscrollview];
    viewx=[[UIView alloc]init];
    viewx.frame=CGRectMake(15*KIphoneWH, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);

    
  
    viewx.backgroundColor=[UIColor redColor];
    
    [v3 addSubview:viewx];
    NSArray *titlearr=@[@"全部",@"待试衣",@"已完成",];
    for (int i=0; i<3; i++) {
        if (i==0) {
            
        }
        
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(i*WIDTH/3, 0, WIDTH/3, 40*KIphoneWH)];
        [button setTitle:titlearr[i] forState:UIControlStateNormal];
        button.tag=i+100;
        [button setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18*KIphoneWH];
        [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateSelected];
        // [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [ _selcetscrollview addSubview:button];
    }


    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NavHeight+50*KIphoneWH, WIDTH, HEIGHT-NavHeight-50*KIphoneWH)];
 
        scroll.contentSize=CGSizeMake(WIDTH*3, 0);
    
    scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    scroll.delegate=self;
    [self.view addSubview:scroll];
    [scroll setContentOffset:CGPointMake(WIDTH*_flags, 0) animated:YES];
}
-(void)segmentedChange:(UIButton *)b{
    
    
    viewx.frame=CGRectMake(15*KIphoneWH+(b.tag-100)*WIDTH/3, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);
    for (int i=0;i<3;i++) {
        UIButton *but=  (id) [self.view viewWithTag:100+i ];
        if (b!=but) {
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            b.selected =NO;
        }
    }
    
    _flags=(int)b.tag-100;
 
    //[self json:1 ];
    if (_flags==0) {
        [table1 reloadData];
    }else if (_flags==1){
        
        [table2 reloadData];
    
    }else if (_flags==2){
        
        [table3 reloadData];
    
    }
    
    
    
   
    [scroll setContentOffset:CGPointMake(WIDTH*((int)b.tag-100), 0) animated:YES];
    

    
    
}
#pragma mark  tableview
-(void)addtable{
    table1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-70*KIphoneWH-50*KIphoneWH)style:UITableViewStyleGrouped];
    table1.delegate=self;
    table1.dataSource=self;
    table1.tag=1;
    table1.rowHeight=100*KIphoneWH;
    [scroll addSubview:table1];
    table2=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-64*KIphoneWH-50*KIphoneWH) style:UITableViewStyleGrouped];
    table2.delegate=self;
    table2.dataSource=self;
    table2.tag=2;
    table2.rowHeight=100*KIphoneWH;
    [scroll addSubview:table2];
    table3=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT-64*KIphoneWH-50*KIphoneWH)style:UITableViewStyleGrouped ];
    table3.delegate=self;
    table3.dataSource=self;
    table3.tag=3;
    table3.rowHeight=100*KIphoneWH;
    [scroll addSubview:table3];
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
       int index1 = scroll.contentOffset.x/WIDTH;
    
    
    
    viewx.frame=CGRectMake(15*KIphoneWH+index1*WIDTH/3, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);
    for (int i=0;i<3;i++) {
        // UIButton *but=  (id) [ viewWithTag:index1 ];
        UIButton *but=[_selcetscrollview viewWithTag:i+100];
        if (index1!=(but.tag-100)) {
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _flags=(int)index1;

            but.selected =NO;
        }
    }
    if ((int)index1==0) {
        [table1 reloadData];
    }else if((int)index1==1){
       
        [table2 reloadData];
    }else if((int)index1==2){
        [table3 reloadData];
    
    }
  

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{

    
    
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_flags==0) {
        if (muarr.count) {
           
            return [muarr count];
        }
    }else if(_flags==1){
        
        if (_secondarray.count) {
            
                        return [_secondarray count];
            
          
           
        }
    }else if(_flags==2){
        
        if (_threearray.count) {
            return [_threearray count];
            
        }
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_flags==0) {
        if (muarr.count) {
            return [[muarr objectAtIndex:section]count];
       }
        return 0;
    }else if(_flags==1){
        if (_secondarray.count) {
            return [[_secondarray objectAtIndex:section]count];
            
        }
        return 0;
    }else if(_flags==2){
        if (_threearray.count) {
           
            return [[_threearray objectAtIndex:section]count];

        }
        
        return 0;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 100*KIphoneWH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*KIphoneWH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==table3) {
        return 130*KIphoneWH;
    }else if (tableView==table1){
        CartModel *mo=[muarr[indexPath.section]objectAtIndex:0];
        if (mo.flag.integerValue==4) {
            return 130*KIphoneWH;
        }else{
            return 100*KIphoneWH;
            
        }
        
    }
    else{
        
        return 100;
    }




}
#pragma mark 头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DgHearderview *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (!view) {
        view=[[DgHearderview alloc] initWithReuseIdentifier:@"header"];
    }
    
    view.frame=CGRectMake(0, 0, WIDTH, 50*KIphoneWH);
    if(muarr.count){
       
        
        if ( tableView==table2) {
            if(_secondarray.count){
            CartModel *m=[_secondarray[section]objectAtIndex:0];
            
            view.brandname.text=[NSString stringWithFormat:@"%@ >",m.orderNo];
            
            if (m.flag.integerValue==1) {
                view.zlabel.text=@"已付款";
            }else{
                view.zlabel.text=@"待付款";
               
            }
            }
        }else if (tableView==table3){
            if (_threearray.count) {
                
            
            
            CartModel *m=[_threearray[section]objectAtIndex:0];
            
            view.brandname.text=[NSString stringWithFormat:@"%@ >",m.orderNo];
            view.zlabel.text=@"已完成";
            }
        }else if (tableView==table4){
            view.zlabel.text=@"待评价";
        }else if (tableView==table1){
            
            CartModel *m=[muarr[section]objectAtIndex:0];
            
            view.brandname.text=[NSString stringWithFormat:@"%@ >",m.orderNo];
            
            if (m.flag.intValue ==0) {
                view.zlabel.text=@"待付款";
            }else if (m.flag.intValue==1 ){
                
                view.zlabel.text=@"已付款";
                
            }else if (m.flag.intValue==2 ){
                view.zlabel.text=@"已完成";
            }else if (m.flag.intValue==3){
                view.zlabel.text=@"待评价";
            }
            
        }}
    return view;
}
#pragma mark 尾 视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view=[[UIView alloc]init];
    
    view.backgroundColor=[UIColor whiteColor];
    UILabel *brandname=[[UILabel alloc]initWithFrame:CGRectMake(20*KIphoneWH, 5*KIphoneWH, WIDTH-40*KIphoneWH, 30*KIphoneWH)];
    [[muarr objectAtIndex:section]count];
 NSInteger gs=0;
    pic=0.0;
    NSArray *arr=nil;
    //CartModel *m=arr ;
    if (_flags==0) {
       arr=muarr[section];
        
    }else if(_flags==1){
    arr=_secondarray[section];
    
    }else if (_flags==2){
    
    arr=_threearray[section];
    }
    
    
    for (int i=0; i<arr.count; i++) {
        CartModel *models=arr[i];
        NSInteger  s=models.quantity;
        gs=gs+s;
        CGFloat p=models.money.floatValue;
        
        pic=pic+p*s;
    }
    
    
     UILabel *salelable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, 130*KIphoneWH, 30*KIphoneWH)];
    salelable.textColor=[UIColor redColor];
    salelable.font=[UIFont systemFontOfSize: 16*KIphoneWH];
    salelable.textAlignment=NSTextAlignmentRight;
    [view addSubview:salelable];

    CartModel *scalemodel=arr[0];
   
    if (scalemodel.salePrice!=nil) {
        pic=pic-scalemodel.salePrice.floatValue;
        
        CGFloat salep=scalemodel.salePrice.floatValue;
        NSString *saletext=[NSString stringWithFormat:@"共优惠:%.1f元",salep];
        salelable.text=saletext;
       
    }else{
    
        salelable.text=nil;
    
    }
    brandname.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f ",gs,pic];
    brandname.textAlignment=NSTextAlignmentRight;
    [view addSubview:brandname];
    UIImageView  *imvs=[[UIImageView alloc]initWithFrame:CGRectMake(0, 42*KIphoneWH, WIDTH, 1*KIphoneWH)];
    imvs.image=[UIImage imageNamed:@"我的资料-分割线"];
    [view addSubview:imvs];
    
    _but2=[UIButton buttonWithType:UIButtonTypeCustom];
    _but2=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-320*KIphoneWH+110*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH)];
    
    _but2.tag=section;
    [view addSubview:_but2];
    _but3=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    _but3.frame=CGRectMake(WIDTH-320*KIphoneWH+220*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH);
    
    _but3.tag=section;
    [view addSubview:_but3];
    _but4=[UIButton buttonWithType:UIButtonTypeCustom];
    _but4.frame=CGRectMake(WIDTH-320*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH);
    _but4.tag=section;
    [view addSubview:_but4];
    if ( tableView==table2) {
        CartModel *m=[_secondarray[section]objectAtIndex:0];
        
        if (m.flag.integerValue==1) {
            
            [_but3 setTitle:@"查看物流" forState:UIControlStateNormal];
            [_but3 addTarget:self action:@selector(Checklogistics:) forControlEvents:UIControlEventTouchUpInside];
            
            [_but3.layer setBorderWidth:1];
            _but3.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
            [_but3 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
            
            _but3.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
            
            
        }else if (m.flag.integerValue==0){
//            [_but4 setBackgroundImage:[UIImage imageNamed:@"删除订单"] forState:UIControlStateNormal];
//            [_but4 setTitle:@"删除订单" forState:UIControlStateNormal];
//            [_but4 addTarget:self action:@selector(deleteorder:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [_but4.layer setBorderWidth:1];
//            _but4.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
//            [_but4 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
//            
//            _but4.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
        
            [_but3 setBackgroundImage:[UIImage imageNamed:@"删除订单"] forState:UIControlStateNormal];
            [_but3 setTitle:@"删除订单" forState:UIControlStateNormal];
            [_but3 addTarget:self action:@selector(deleteorder:) forControlEvents:UIControlEventTouchUpInside];
            
            [_but3.layer setBorderWidth:1];
            _but3.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
            [_but3 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
            
            _but3.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
//            [_but2.layer setBorderWidth:1];
//            _but2.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
//            [_but2 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
//            [_but2 setTitle:@"线上支付" forState:UIControlStateNormal];
//            _but2.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
//            _but2.tag=section;
//            
//            [_but2 addTarget:self action:@selector(xszf:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }else if (tableView==table3){
        
        
        if (_flag==1) {
            
            [_but3 setBackgroundImage:[UIImage imageNamed:@"确认收货"]forState:UIControlStateNormal];
            [_but3 addTarget:self action:@selector(queren:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }else if (tableView==table4){
        
        
    }else if (tableView==table1){
        
        CartModel *m=[muarr[section]objectAtIndex:0];
        
        if (m.flag.intValue==0) {
            
            if (_flag==1) {
                
            }else{
//                [_but4 setBackgroundImage:[UIImage imageNamed:@"删除订单"] forState:UIControlStateNormal];
//                [_but4 setTitle:@"删除订单" forState:UIControlStateNormal];
//                [_but4 addTarget:self action:@selector(deleteorder:) forControlEvents:UIControlEventTouchUpInside];
//                
//                [_but4.layer setBorderWidth:1];
//                _but4.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
//                [_but4 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
//                
//                _but4.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
                [_but3 setBackgroundImage:[UIImage imageNamed:@"删除订单"] forState:UIControlStateNormal];
                [_but3 setTitle:@"删除订单" forState:UIControlStateNormal];
                [_but3 addTarget:self action:@selector(deleteorder:) forControlEvents:UIControlEventTouchUpInside];
                [_but3.layer setBorderWidth:1];
                _but3.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
                [_but3 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
                
                _but3.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
//                [_but2.layer setBorderWidth:1];
//                _but2.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
//                [_but2 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
//                [_but2 setTitle:@"线上支付" forState:UIControlStateNormal];
//                _but2.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
//                
//                _but2.tag=section;
//                [_but2 addTarget:self action:@selector(deleteorder:) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }else if (m.flag.intValue==2 ){
            
            if (_flag==1) {
                
                [_but3 setBackgroundImage:[UIImage imageNamed:@"确认收货"]forState:UIControlStateNormal];
                [_but3 addTarget:self action:@selector(queren:) forControlEvents:UIControlEventTouchUpInside];
                [_but2.layer setBorderWidth:1];
                _but2.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
                [_but2 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
                [_but2 setTitle:@"查看物流" forState:UIControlStateNormal];
                _but2.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
                _but2.tag=section;
                
                [_but2 addTarget:self action:@selector(Checklogistics:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
        }else if (m.flag.intValue==3){
            
        }else if (m.flag.integerValue==1){
            [_but3 setTitle:@"查看物流" forState:UIControlStateNormal];
            [_but3 addTarget:self action:@selector(Checklogistics:) forControlEvents:UIControlEventTouchUpInside];
            
            [_but3.layer setBorderWidth:1];
            _but3.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
            [_but3 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
            
            _but3.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
            
        }
    }
    return view;
}

#pragma mark 线上支付
-(void)xszf:(UIButton *)b{
    DingdanViewController *ding=[[DingdanViewController alloc] init];
    NSArray *arr=nil;
    if (_flags==0) {
        
      arr=muarr[b.tag];
        
    }else if(_flags==1){
    
   arr=_secondarray[b.tag];
    
    }
    
    NSMutableArray *_groupArr = [NSMutableArray array];
    NSMutableArray *currentArr = [NSMutableArray array];
    
    // 因为肯定有一个字典返回,先添加一个
    [currentArr addObject:arr[0]];
    [_groupArr addObject:currentArr];
    // 如果不止一个,才要动画添加
    if(arr.count > 1){
        for (int i = 1; i < arr.count; i++) {
            // 先取出组数组中  上一个模型数组的第一个字典模型的groupID
            NSMutableArray *preModelArr = [_groupArr objectAtIndex:_groupArr.count-1];
            CartModel *mode=[preModelArr objectAtIndex:0];
            NSString *preGroupID = mode.brandName ;
            // 取出当前字典,根据groupID比较,如果相同则添加到同一个模型数组;如果不相同,说明不是同一个组的
            CartModel *currentDict = arr[i];
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
    CGFloat pics=0;
    NSInteger gss=0;
    for (int i=0; i<arr.count; i++) {
        CartModel *models=arr[i];
        NSInteger s=models.quantity;
        gss=gss+s;
        CGFloat p=models.money.floatValue;
        
        pics=pics+p*s;
    }
    
    CartModel *m=arr[0] ;
    NSString * order=[NSString stringWithFormat:@"%@",m.orderNo];
    ding.order=order;
    ding.array=_groupArr;
    ding.allprice=pics;
    ding.gs=gss;
    ding.flag=_flag;
    ding.pagenumer=1;
    ding.Time=1;
    
    [self.navigationController pushViewController:ding animated:YES];
    
    
    
}

#pragma mark---------------上门 物流状态 
-(void)Checklogistics:(UIButton *)b{
    
    SMorderstatusViewController *smorder=[[SMorderstatusViewController alloc] init];
    //smorder.orderno=
    if (muarr.count) {
        NSArray *arr=nil;
        if (_flags==0) {
            arr=muarr[b.tag];
        }else if (_flags==1){
            arr=_secondarray[b.tag];
            
        }else if (_flags==2){
            
            arr=_threearray[b.tag];
        }
        
        CartModel *model2=arr[0];
       // NSInteger sss=model.orderNo.intValue;
        NSString *orderstr=[NSString stringWithFormat:@"%@",model2.orderNo];
        smorder.orderno=orderstr;
        [self.navigationController pushViewController:smorder animated:YES];
    }

}



#pragma mark 返回 确认订单界面
-(void)popv1{
    
    v12.alpha=0;
    
}
#pragma mark 线下支付
-(void)xzhifu:(UIButton *)b{
    
    CartModel *m=nil;
    if (_flags==0) {
       m=[muarr  [b.tag]objectAtIndex:0];
    }else if(_flags==1){
    
      m=[_secondarray[b.tag]objectAtIndex:0];
    }
//CartModel *m=[muarr[b.tag]objectAtIndex:0];
    ordernoss=[NSString stringWithFormat:@"%@",m.orderNo];
    [ self zfsuccess:b.tag];

    }
-(void)zfsuccess:(NSInteger)bb{
    if ([de objectForKey:@"userId"]) {
        NSMutableDictionary *dicsf=[Uikility creatSinGoMutableDictionary];
        [dicsf setObject:ordernoss forKey:@"orderNo"];
        [dicsf setObject:@1 forKey:@"flag"];
        [dicsf setObject:@0 forKey:@"paymentMode"];
//        NSDictionary *dicsf=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"orderNo": ordernoss,@"flag":@1,@"model":@1,@"ios_version":VERSION,@"paymentMode":@0};
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicsf options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
#pragma mark 去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json
                              };
    url=[BassAPI requestUrlWithPorType:PortTypeComePaySucess];
            //订单不对
       
        [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            
            if (success) {
                [Uikility alert:@"支付成功！"];
                [self json:1];
                
            }else{
                [Uikility alert:[strs objectForKey:@"msg"]];
            }

        } failure:^(NSError *error) {
          [Uikility alert:@"接受数据失败！"];
        }];
    }else{
        [Uikility alert:@"请先登录！"];
    }
    
}


#pragma mark 取消订单
-(void)quxiao:(UIButton *)b{
  
    _all=YES;
    CartModel *m=[muarr[b.tag]objectAtIndex:0];
    ordernoss=[NSString stringWithFormat:@"%@",m.orderNo];
    [self json:0 ];
    
}
#pragma mark 退货
-(void)tuixuo:(UIButton *)b{
    
    SFViewController *s=[[SFViewController alloc]init];
    CartModel *ms=[muarr[b.tag]objectAtIndex:0];
    ids=[NSString stringWithFormat:@"%zd",ms.id.intValue];
    s.flag=5;
    s.ids=ids;
    s.flagdg=_flag;
    s.flagsdg=_flags;
    [self.navigationController pushViewController:s animated:YES];
}
#pragma mark 确认收货
-(void)queren:(UIButton *)b{

    CartModel *m=[muarr[b.tag]objectAtIndex:0];
    //NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        NSMutableDictionary *dicsf=[Uikility creatSinGoMutableDictionary];
        [dicsf setObject:m.orderNo forKey:@"orderNo"];
        [dicsf setObject:@3 forKey:@"flag"];
        
//        NSDictionary *dicsf=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"orderNo":m.orderNo,@"flag":@3,@"model":@1,@"ios_version":VERSION
//                              };
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicsf options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
#pragma mark 去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json
                              };
   
        if (_flag==1) {
            
            
            url=[BassAPI requestUrlWithPorType:PortTypeConGoodOrder];
        }
        [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            
            if (success) {
                [self json:1];
            }else{
                [Uikility alert:[strs objectForKey:@"msg"]];            }
        } failure:^(NSError *error) {
           [ Uikility alert:@"数据接受失败！"];
        }];
        
    }else{
        [Uikility alert:@"请先登录！"];
    }
    
    
}
#pragma mark *****内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        
        DgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"table1"];
        if (!cell) {
            cell=[[DgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"table1"];
        }

        if (muarr.count) {
            NSArray *arr=nil;
            if (_flags==0) {
                 arr=muarr[indexPath.section];
            }else if (_flags==1){
                 arr=_secondarray[indexPath.section];
            
            }else if (_flags==2){
            
             arr=_threearray[indexPath.section];
                
            }
            
            
        CartModel *ms=[arr objectAtIndex:indexPath.row];
        
        [cell.goodsimv  sd_setImageWithURL:[Uikility URLWithString:ms.logopicUrl] placeholderImage:[UIImage imageNamed:@"uuu"]];
        
        cell.goodsname.text=ms.goodsName;
        cell.attlabel.text=ms.attribute;
        NSString *s=[NSString stringWithFormat:@"￥%.1f",ms.money.floatValue];
        cell.pircelabel.text=s;
        cell.qulable.text=[NSString stringWithFormat:@"x%ld",(long)ms.quantity];
           
        if (ms.flag.intValue==0) {
           
            if ([arr count]>0) {
                [cell.deletebut setTitle:@"删除" forState:UIControlStateNormal];
                [cell.deletebut .layer setBorderWidth:1];
                cell.deletebut.alpha=1;
                
                void(^deleteblock)(NSInteger)=^(NSInteger text){
                    
                    _all=NO;
                    ids=[NSString stringWithFormat:@"%zd",ms.id.integerValue];
                    ordernoss=[NSString stringWithFormat:@"%@", ms.orderNo];
                    [self deletegoods:ids goodoroder:1];
                };
                cell.block=deleteblock;
                
            }
        }
        if (ms.flag.intValue==4) {
           
            
            //cell.deletebut.frame=CGRectMake(WIDTH-90*KIphoneWH, 65*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH);
            cell.deletebut.alpha=0;
            [cell.pjbut .layer setBorderWidth:1];
            cell.pjbut.alpha=1;
            
            [cell.pjbut setTitle:@"评论" forState:UIControlStateNormal];
            
            [cell.thbut.layer setBorderWidth:1];
            cell.thbut.alpha=1;
            [cell.thbut setTitle:@"退货" forState:UIControlStateNormal];
            void(^deleteblock)(NSInteger)=^(NSInteger text){
                
                if (text==2) {
                    
                
                
                SFViewController *s=[[SFViewController alloc]init];
                ids=[NSString stringWithFormat:@"%zd",ms.goodsid.intValue];
                s.flag=4;
                s.attribute=ms.attribute;
                s.ids=ids;
                // s.deleget=self;
                s.flagdg=_flag;
                s.flagsdg=_flags;
                [self.navigationController pushViewController:s animated:YES];
                }else if (text==3){
                
                    ReturngoodsViewController *rtvc=[[ReturngoodsViewController alloc] init];
                    rtvc.flag=3;
                    rtvc.model=ms;
                    rtvc.customerflag=ms.customerFlag;
                    rtvc.apporderid=ms.id;
                
                    [self.navigationController pushViewController:rtvc animated:YES];
                }
                
                };
            
            cell.block=deleteblock;
            
            
        }
        
        if (ms.flag.intValue==2) {
            
            cell.deletebut.frame=CGRectMake(WIDTH-90*KIphoneWH, 65*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH);
            if (ms.customerFlag) {
                
                
                if (ms.customerFlag==3) {
                    [cell.deletebut setTitle:  @"处理完成" forState:UIControlStateNormal];
                }else if (ms.customerFlag==2){
                    [cell.deletebut setTitle:  @"正在处理" forState:UIControlStateNormal];
                }else if (ms.customerFlag==1){
                    [cell.deletebut setTitle:  @"申请中" forState:UIControlStateNormal];
                    
                }
            }else{
                [cell.deletebut setTitle:  @"申请退货" forState:UIControlStateNormal];
            }
            
            cell.deletebut.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
            
            [cell.deletebut.layer setBorderWidth:1];
            cell.deletebut.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
            [cell.deletebut setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
            
            void(^deleteblock)(NSInteger)=^(NSInteger text){
                
                if (ms.customerFlag) {
                    
                }else{
                    SFViewController *s=[[SFViewController alloc]init];
                    //CartModel *ms=[muarr[b.tag]objectAtIndex:0];
                    ids=[NSString stringWithFormat:@"%zd",ms.id.intValue];
                    s.flag=5;
                    s.ids=ids;
                    s.flagdg=_flag;
                    s.flagsdg=_flags;
                    [self.navigationController pushViewController:s animated:YES];
                }
            };
            cell.block=deleteblock;
            
            
        }else if (ms.flag.integerValue==1){
        
            cell.deletebut.alpha=0;
        
        
        }
            
            return cell;

    }
    return cell;
}
-(void)deleteorder:(UIButton *)b{
    if (muarr.count) {
        NSArray *arr=nil;
        if (_flags==0) {
            arr=muarr[b.tag];
        }else if (_flags==1){
            arr=_secondarray[b.tag];
            
        }else if (_flags==2){
            
            arr=_threearray[b.tag];
            
        }
        
        
        if (arr.count>0) {
            CartModel *ms=[arr objectAtIndex:0];
            ordernoss=[NSString stringWithFormat:@"%@", ms.orderNo];
            [self deletegoods:ordernoss goodoroder:2];
            
        }
    }
    
       

}
#pragma mark-------删除商品 1为删除商品  2 为删除订单
-(void)deletegoods:(NSString *)orderid goodoroder:(NSInteger)goro{
    NSMutableDictionary *dic1=[Uikility creatSinGoMutableDictionary];
    if (goro==1) {
        
        [dic1 setObject:orderid forKey:@"id"];
        
//         dic1=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"id":orderid,@"model":@1,@"ios_version":VERSION};
    }else{
        [dic1 setObject:ordernoss forKey:@"order_no"];
//        dic1=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId" ],@"order_no":ordernoss,@"model":@1,@"ios_version":VERSION};
    }
        NSString *url1=[BassAPI requestUrlWithPorType:PortTypeSmOrderDelete ];
    NSDictionary *dicurl=[Uikility initWithdatajson:dic1];
   
    [AFManger postWithURLString:url1 parameters:dicurl success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Boolean sucess=[[object objectForKey:@"success"] boolValue];
        if (sucess) {
            [self json:1];
            [Uikility alert:@"删除成功"];
        }

    } failure:^(NSError *error) {
         [Uikility alert:@"当前网络有问题"];
    }];
    
}
#pragma mark  数据
-(void)json:(int)i{
   
#pragma mark 判断登录 否
    if ([de objectForKey:@"userId"]) {
#pragma mark 判断删除 查询
        if (i==0) {
            

        }else if (i==1){
            dictionary=[Uikility creatSinGoMutableDictionary];
//                 dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"model":@1,@"ios_version":VERSION
//                             };
            
           // }
        }
        NSData *jsonDatas = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonDatas encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json
                              };
       
#pragma mark 判断 删除 查询
        if (i==0) {
       }else if(i==1){
            
            if (_flag==2){
                
                url=[BassAPI requestUrlWithPorType:PortTypeOrderlist];
            }else if (_flag==3){
                url=[BassAPI requestUrlWithPorType:PortTypeDoororderlist];
            }else if(_flag==1){
                url=[BassAPI requestUrlWithPorType:PortTypeSelectPuOrderList];
                
            }
        }
      
       [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
           id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[strs objectForKey:@"success"] boolValue];
           if (success) {
               if (i==1) {
                   
                   NSArray *arr =[strs objectForKey:@"data"];
                   [_secondarray removeAllObjects];
                   [_threearray removeAllObjects];
                   [muarr removeAllObjects];
                   for (NSArray * arry in arr) {
                       
                       NSMutableArray *farr=[[NSMutableArray alloc] init];
                       NSMutableArray *second=[[NSMutableArray alloc] init];
                       NSMutableArray *thredd=[[NSMutableArray alloc] init];
                       for (NSDictionary *dic in arry) {
                           CartModel *models=[CartModel initwithdic:dic];
                           NSDictionary *dicc=[dic objectForKey:@"appgoodsId"];
                           
                           models.goodsName=[[dic objectForKey:@"appgoodsId" ] objectForKey:@"goodsName"];
                           models.logopicUrl=[dicc objectForKey:@"logopicUrl"];
                           models.goodsid=[dicc objectForKey:@"id"];
                           models.id=[dic objectForKey:@"id"];
                           models.attribute=[dic objectForKey:@"attribute"];
                           models.flag=[dic objectForKey:@"flag"];
                           models.money=[dic objectForKey:@"money"];
                           models.orderNo=[dic objectForKey:@"orderNo"];
                           models.quantity=[[dic objectForKey:@"quantity"]integerValue];
                           models.remark=[dic objectForKey:@"remark"];
                           models.reTime=[dic objectForKey:@"reTime"];
                           models.customerFlag =[[dic objectForKey:@"customerFlag"]integerValue];
                           models.customerProblem=[dic objectForKey:@"customerProblem"];
                           models.customerStartTime=[dic objectForKey:@"customerStartTime"];
                           
                           [farr addObject:models];
                           
                           if (models.flag.integerValue==0||models.flag.integerValue==1) {
                               _arrpage=1;
                               
                               [second addObject:models];
                               
                           }else if(models.flag.integerValue==4){
                               
                               _arrpage=2;
                               [thredd addObject:models];
                               
                           }
                           
                       }
                       
                       
                       [muarr addObject:farr];
                       if (_arrpage==1) {
                           
                           [_secondarray addObject:second];
                       }else if(_arrpage==2){
                           
                           [_threearray addObject:thredd];
                           
                           
                       }
                       
                       
                       if (_flags==0) {
                           [table1 reloadData];
                       }else if (_flags==1){
                           [table2 reloadData];
                           
                       }else if (_flags==2){
                           
                           [table3 reloadData];
                           
                       }
                       
                   }
                   /*
                    if (_flags==0) {
                    [table1 reloadData];
                    //[self  secondread];
                    }else if (_flags==1){
                    
                    [table2 reloadData];
                    //[self  threedread];
                    }else if (_flags==2){
                    [table3 reloadData];
                    }else if (_flags==3){
                    [table4 reloadData];
                    }
                    */
                   
               }else if(i==0){
                   
                   [self json:1 ];
                   [Uikility alert:@"删除成功！"];
                   
                   
               }
           }else{
               //if ([[strs objectForKey:@"msg"]isEqualToString:@"您还没有订单！"]) {
               [muarr removeAllObjects];
               if (_flags==0) {
                   //[muarr removeAllObjects];
                   [table1 reloadData];
               }else if (_flags==1){
                   //[_secondarray removeAllObjects];
                   [table2 reloadData];
               }else if (_flags==2){
                   //[_threearray removeAllObjects];
                   [table3 reloadData];
               }else if (_flags==3){
                   [table4 reloadData];
               }
               
               // }
               [Uikility alert: [strs objectForKey:@"msg"]];
               
           }

       } failure:^(NSError *error) {
           [Uikility alert:@"数据接受失败！"];
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
