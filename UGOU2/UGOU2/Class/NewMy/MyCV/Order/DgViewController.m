//
//  DgViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/16.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.16.1.24 订单管理
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "DgViewController.h"
#import "HYSegmentedControl.h"
#import "DgTableViewCell.h"
#import "DingdanViewController.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"
#import "CartModel.h"
#import "SFViewController.h"
#import "MyViewController.h"
#import "BassAPI.h"
#import "DgHearderview.h"
#import "DgFootview.h"
#import "LogisticsViewController.h"
#import "ReturngoodsViewController.h"
#import "MainViewController.h"
#import "SpViewController.h"
#import "UGHeader.h"
@interface DgViewController ()<HYSegmentedControlDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SFViewControllerDeleget,UGCustomnNavViewDelegate>{
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
}
@end

@implementation DgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden=YES;
   
    muarr=[NSMutableArray array];
    paramarr=[NSMutableArray array];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    [self adddaohanglan];
    [self addview];
    [self addtable];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
  //self.navigationController.navigationBar.hidden=NO;
  self.tabBarController.tabBar.hidden=NO;
}
#pragma mark  ****导航栏
-(void)adddaohanglan{
    
//    titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(60*KIphoneWH, 20*KIphoneWH,WIDTH-120*KIphoneWH, 44*KIphoneWH)];
//    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64*KIphoneWH)];
//    
//    _imageview.userInteractionEnabled=YES;
//    titlelabel.textColor=[UIColor whiteColor];
//    titlelabel.textAlignment=NSTextAlignmentCenter;
//    titlelabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
//    [_imageview addSubview:titlelabel];
//    if (_flag==2) {
//        titlelabel.text=@"到店预订订单";
//        UIImage *image=[UIImage imageNamed:@"到店预订横条"];
//        _imageview.image=image;
//    }else if (_flag==3){
//        titlelabel.text=@"上门试衣订单";
//        UIImage *image=[UIImage imageNamed:@"上门试衣横条"];
//        _imageview.image=image;
//    }else{
//        titlelabel.text=@"普通订单";
//        UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
//        _imageview.image=image;
//    }
//    
//    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 60*KIphoneWH, 64*KIphoneWH )];
//   
//    UIImage *img=[UIImage imageNamed:@"返回o"];
//    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
//    [leftButton addSubview:imgv];
//    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
//    [leftButton addTarget:self action:@selector(pushpop) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:_imageview];
//    [self.view  addSubview:leftButton];
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custemNav.Delegate=self;
    if (_flag==2) {
        custemNav.title=@"到店预订订单";
        [custemNav.backgroundView setImage:[UIImage imageNamed:@"到店预订横条"]];
    }else if (_flag==3){
        custemNav.title=@"上门试衣订单";
        [custemNav.backgroundView setImage:[UIImage imageNamed:@"上门试衣横条"]];
    }else{
        custemNav.title=@"普通订单";
       [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    }
    [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:custemNav];
    
    
}
-(void)LeftItemAction{
    [self pushpop];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _imageview.hidden=YES;
}

#pragma mark *****导航栏点击返回
-(void)pushpop{
    if (_indexflag==1) {
            self.navigationController.navigationBar.hidden=NO;
         [self.navigationController popViewControllerAnimated:YES];
    }else{
    
        if (self.navigationController.viewControllers.count) {
                UIViewController *controller=self.navigationController.viewControllers[0];
                //self.navigationController.navigationBar.hidden=NO;
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
}

#pragma mark  *****头部
-(void)addview{
    if (_flag==1) {
        _segment = [[HYSegmentedControl alloc] initWithOriginY:4 width:WIDTH color:[UIColor redColor] Titles:@[@"全部",@"已付款",@"已发货",@"评论"] delegate:self] ;
    }else if (_flag==2){
        _segment = [[HYSegmentedControl alloc] initWithOriginY:3 width:WIDTH color:[UIColor redColor] Titles:@[@"全部",@"待试衣",@"已完成"] delegate:self] ;
    }else if (_flag==3){
        _segment = [[HYSegmentedControl alloc] initWithOriginY:3 width:WIDTH color:[UIColor redColor] Titles:@[@"全部",@"待付款",@"待试衣"] delegate:self] ;
    }
    
    _segment.frame=CGRectMake(0, NavHeight+6*KIphoneWH, WIDTH, 40*KIphoneWH);
    
    _segment.delegate=self;
    
    [self.view addSubview:_segment];
    [_segment changeSegmentedControlWithIndex:_flags];
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NavHeight+50*KIphoneWH, WIDTH, HEIGHT-NavHeight-50*KIphoneWH)];
    if (_flag==1) {
        scroll.contentSize=CGSizeMake(WIDTH*4, 0);
    }else{
        scroll.contentSize=CGSizeMake(WIDTH*3, 0);
    }
    
    scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    scroll.delegate=self;
    [self.view addSubview:scroll];
    [scroll setContentOffset:CGPointMake(WIDTH*_flags, 0) animated:YES];
}
#pragma mark  ******tableview
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
    if (_flag==1) {
        table4=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*3, 0, WIDTH, HEIGHT-64*KIphoneWH-50*KIphoneWH)style:UITableViewStyleGrouped];
        table4.delegate=self;
        table4.dataSource=self;
        table4.tag=4;
        table4.rowHeight=100*KIphoneWH;
        [scroll addSubview:table4];
    }
    
    
    
}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    _flags=(int)index;
   
    [self json:1 ];
    
    [scroll setContentOffset:CGPointMake(WIDTH*(int)index, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index1 = scroll.contentOffset.x/WIDTH;
    [_segment changeSegmentedControlWithIndex:index1];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (muarr.count) {
        return [muarr count];
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (muarr.count) {
        return [[muarr objectAtIndex:section]count];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==table4) {
        return 130*KIphoneWH;
    }else if (tableView==table1){
        CartModel *mo=[muarr[indexPath.section]objectAtIndex:0];
        if (mo.flag.integerValue==3) {
            return 130*KIphoneWH;
        }else{
            return 100*KIphoneWH;
        
        }
    
    }if(table3==tableView){
        if (_flag==2) {
            return 130*KIphoneWH;
        }else{
            return 100*KIphoneWH;
        
        }
    
    }
    else{

        return 100;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 100*KIphoneWH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*KIphoneWH;
}
#pragma mark ******头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DgHearderview *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (!view) {
        view=[[DgHearderview alloc] initWithReuseIdentifier:@"header"];
    }
    
    view.frame=CGRectMake(0, 0, WIDTH, 50*KIphoneWH);
    if(muarr.count){
        CartModel *m=[muarr[section]objectAtIndex:0];
        
        view.brandname.text=[NSString stringWithFormat:@"%@ >",m.orderNo];
        
        if ( tableView==table2) {
            if (_flag==1) {
                view.zlabel.text=@"已付款";
            }else{
                
                if (m.flag.integerValue==0) {
                    view.zlabel.text=@"未付款";
                }else if (m.flag.integerValue==1){
                
                view.zlabel.text=@"已付款";
                }
                
                
            }
        }else if (tableView==table3){
            if (_flag==2) {
                view.zlabel.text=@"已完成";
            }else if(_flag==1){
                view.zlabel.text=@"待收货";
            }else if (_flag==3){
                view.zlabel.text=@"待试衣";
            }
        }else if (tableView==table4){
            view.zlabel.text=@"评价";
        }else if (tableView==table1){
            if (m.flag.intValue ==0) {
                view.zlabel.text=@"待付款";
            }else if (m.flag.intValue==1 ){
                if (_flag==2) {
                    view.zlabel.text=@"待试衣";
                }else if(_flag==1){
                    view.zlabel.text=@"已付款";
                }else if (_flag==3){
                    view.zlabel.text=@"待试衣";
                }
            }else if (m.flag.intValue==2 ){
                
                if(_flag==1){
                
                view.zlabel.text=@"待收货";
                
                }else if (_flag==2){
                 view.zlabel.text=@"已完成";
                }
                
                view.zlabel.text=@"待收货";
            }else if (m.flag.intValue==3){
                
                
                view.zlabel.text=@"评价";
            }
            
        }}
    return view;
}
#pragma mark ******尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view=[[UIView alloc]init];
    
    view.backgroundColor=[UIColor whiteColor];
    UILabel *brandname=[[UILabel alloc]initWithFrame:CGRectMake(140*KIphoneWH, 5*KIphoneWH, WIDTH-140*KIphoneWH, 30*KIphoneWH)];
    [[muarr objectAtIndex:section]count];
    NSInteger gs=0;
    pic=0.0;
    NSArray *arr=muarr[section];
    //CartModel *m=arr ;
    
    for (int i=0; i<arr.count; i++) {
        CartModel *models=arr[i];
      NSInteger  s=models.quantity;
        gs=gs+s;
        CGFloat p=models.money.floatValue;
        
        pic=pic+p*s;
    }
    //显示优惠价格
    UILabel *salelable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, 130*KIphoneWH, 30*KIphoneWH)];
    salelable.textColor=[UIColor redColor];
    salelable.font=[UIFont systemFontOfSize: 16*KIphoneWH];
     salelable.textAlignment=NSTextAlignmentRight;
    [view addSubview:salelable];
    
    CartModel *cartmodel=arr[0];
    if (cartmodel.salePrice!=nil) {
        
        pic=pic-cartmodel.salePrice.floatValue;
        CGFloat salep=cartmodel.salePrice.floatValue;
        NSString *saletext=[NSString stringWithFormat:@"共优惠:%.1f元",salep];
        salelable.text=saletext;
        
    }else{
       salelable.text=nil;
    }
        if (_flag==1) {
        brandname.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f ",gs,pic];
    }else if (_flag==2){
        brandname.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f ",gs,pic];
    }
    
    brandname.textAlignment=NSTextAlignmentLeft;
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
    if ( tableView==table2) {
      CartModel *m=[muarr[section]objectAtIndex:0];
        
        if (m.flag.intValue==0) {
            
            if (_flag==1) {
                
            }else{

                
            }
        }
    }else if (tableView==table3){
        
        
        if (_flag==1) {
            
            [_but3 setBackgroundImage:[UIImage imageNamed:@"确认收货"]forState:UIControlStateNormal];
            [_but3 addTarget:self action:@selector(queren:) forControlEvents:UIControlEventTouchUpInside];
            [_but2.layer setBorderWidth:1];
            _but2.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
            [_but2 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1] forState:UIControlStateNormal];
            [_but2 setTitle:@"查看物流" forState:UIControlStateNormal];
            _but2.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
            [_but2 addTarget:self action:@selector(Checklogistics:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }else if (tableView==table4){
        if(_flag==1){
        
        
        
        
        }
        
        
    }else if (tableView==table1){
        
        CartModel *m=[muarr[section]objectAtIndex:0];
        
        if (m.flag.intValue==0) {
            
            if (_flag==1) {

            }else{


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

                [_but2 addTarget:self action:@selector(Checklogistics:) forControlEvents:UIControlEventTouchUpInside];
                }
            
        }else if (m.flag.intValue==3){
            
        }else if (m.flag.integerValue==1){
            
        }
    }
    return view;
}

#pragma mark*********普通订单查看物流
-(void)Checklogistics:(UIButton *)b{
    LogisticsViewController *sv=[[LogisticsViewController alloc] init];
    if (muarr.count) {
        NSArray *arr=[muarr objectAtIndex:b.tag];
        CartModel *codemodel=arr[0];
        sv.code=codemodel.code;
        sv.expressNo=codemodel.expressNo;
    }
    
    [self.navigationController pushViewController:sv animated:YES];

}



#pragma mark************申请退款
-(void)applyrefund:(UIButton *)b{
//    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
//    NSString *strurl=[BassAPI requestUrlWithPorType:PortTypeSaveCustomer];
//    
//    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
//    manger.responseSerializer=[AFHTTPResponseSerializer serializer];
//    
//    NSDictionary *dicurl=@{@"userId":[defa objectForKey:@"userId"],@"sessionid":[defa objectForKey:@"sessionid"],@"appuserId":@"",@"content":@"",@"apporderId":@"",@"model":@1,@"ios_version":VERSION};
    
}
#pragma mark 线上支付
-(void)xszf:(UIButton *)b{
    DingdanViewController *ding=[[DingdanViewController alloc] init];
    NSArray *arr;
    
   
      arr=muarr[b.tag];
    //}
    NSMutableArray *_groupArr = [NSMutableArray array];
    NSMutableArray *currentArr = [NSMutableArray array];
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
    NSInteger pics=0;
    NSInteger gss=0;
    for (int i=0; i<arr.count; i++) {
        CartModel *models=arr[i];
        NSInteger  s=models.quantity;
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
#pragma mark ***返回 确认订单界面
-(void)popv1{
    
    v12.alpha=0;
    
}
#pragma mark ***线下支付
-(void)xzhifu:(UIButton *)b{
    
    CartModel *m=[muarr[b.tag]objectAtIndex:0];
    
   ordernoss=[NSString stringWithFormat:@"%@",m.orderNo];
    [ self zfsuccess];
}
-(void)zfsuccess{

    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        NSMutableDictionary *dicsf=[Uikility creatSinGoMutableDictionary];
        [dicsf setObject:ordernoss forKey:@"orderNo"];
        [dicsf setObject:@1 forKey:@"flag"];
        [dicsf setObject:@0 forKey:@"paymentMode"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicsf options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json
                              };
        
        if (_flag==2) {
            
            
            url=[BassAPI requestUrlWithPorType:PortTypetSorePaySucess];
        }else if (_flag==3){
            url=[BassAPI requestUrlWithPorType:PortTypeComePaySucess];
            
            
        }else{
            //订单不对
        }
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


#pragma mark *****取消订单
-(void)quxiao:(UIButton *)b{
    
    _all=YES;
    CartModel *m=[muarr[b.tag]objectAtIndex:0];
    ordernoss=[NSString stringWithFormat:@"%@",m.orderNo];
    [self json:0 ];
    
}
#pragma mark *****退货
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
#pragma mark *******确认收货
-(void)queren:(UIButton *)b{
    CartModel *m=[muarr[b.tag]objectAtIndex:0];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        NSMutableDictionary*dicsf=[[NSMutableDictionary alloc] init];
        [dicsf setObject:m.orderNo forKey:@"orderNo"];
        [dicsf setObject:@3 forKey:@"flag"];
        
        

        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicsf options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json};
        
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
           [Uikility alert:@"数据接受失败！"];
       }];
    }else{
        [Uikility alert:@"请先登录！"];
    }
    
    
}
#pragma mark *****CELL内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenxtifier=@"cell";
    DgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenxtifier];
    if (!cell) {
        cell=[[DgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenxtifier];
    }
    
    
    if (muarr.count) {
        NSArray *arr=muarr[indexPath.section];
        CartModel *ms=[arr objectAtIndex:indexPath.row];
        [cell.goodsimv  sd_setImageWithURL:[Uikility URLWithString:ms.logopicUrl] placeholderImage:[UIImage imageNamed:@"uuu"]];
        
        cell.goodsname.text=ms.goodsName;
        cell.attlabel.text=ms.attribute;
        if (_flag==1) {
            NSString *s=[NSString stringWithFormat:@"￥%.1f",ms.money.floatValue];
            cell.pircelabel.text=s;
        }else if (_flag==2){
        NSString *s=[NSString stringWithFormat:@"￥%.1f",ms.money.floatValue];
            cell.pircelabel.text=s;}
        cell.qulable.text=[NSString stringWithFormat:@"x%ld",(long)ms.quantity];
        
        if (ms.flag.intValue==0) {
            if ([arr count]>1) {
                cell.deletebut.frame=CGRectMake(WIDTH-90*KIphoneWH, 65*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH);
                [cell.deletebut setTitle:@"删除" forState:UIControlStateNormal];
                [cell.deletebut .layer setBorderWidth:1];
                void(^deleteblock)(NSInteger)=^(NSInteger text){
                    
                    _all=NO;
                    ids=[NSString stringWithFormat:@"%zd",ms.goodsid.intValue];
                    ordernoss=[NSString stringWithFormat:@"%@", ms.orderNo];
                    [self json:0 ];
                    
                };
                cell.block=deleteblock;
                
            }
        }
        if (ms.flag.intValue==3) {
        
            cell.thbut.alpha=1;
            [cell.thbut .layer setBorderWidth:1];
           
            [cell.thbut setTitle:@"退货" forState:UIControlStateNormal];
            cell.pjbut.alpha=1;
           //[cell.pjbut setBackgroundImage:[UIImage imageNamed:@"评--价" ] forState:UIControlStateNormal];
            [cell.pjbut.layer setBorderWidth:1];
            [cell.pjbut setTitle:@"评价" forState:UIControlStateNormal];
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
                
                    ReturngoodsViewController *retu=[[ReturngoodsViewController alloc] init];
                    retu.flag=_flag;
                    retu.customerflag=ms.customerFlag;
                    retu.model=ms;
                    retu.apporderid=ms.id;
                    [self.navigationController pushViewController:retu animated:YES];
                
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
            
            
        }
        
        
        
        
    }
    return cell;
}

#pragma mark ******数据
-(void)json:(int)i{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
// 判断登录 否
    if ([de objectForKey:@"userId"]) {
// 判断删除 查询
        NSMutableDictionary *orderdic=[ Uikility creatSinGoMutableDictionary];
        
        
        if (i==0) {
//判断删除 商品 订单
            if (_all==NO) {
                NSDictionary *d1=@{
                                   @"id":ids
                                   };
                NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                [orderdic setObject:ordernoss forKey:@"orderNo"];
                [orderdic setObject:d1 forKey:@"appgoodsId"];
                [orderdic setObject:@"-1" forKey:@"flag"];

// 判断删除 订单 商品
            }else if(_all==YES){
                [orderdic setObject:ordernoss forKey:@"orderNo"];
                [orderdic setObject:@"-1" forKey:@"flag"];
//                dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"orderNo":ordernoss,@"flag":@"-1",@"model":@1,@"ios_version":VERSION
//                             };
                
            }
            
// 判断 查询 删除
        }else if (i==1){
// 判断 待付款 收货/付款/试衣 评论 全部
            if (_flags==1) {
                if (_flag==1) {
                    [orderdic setObject:@1 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"flag":@1,@"model":@1,@"ios_version":VERSION
//                                 };
                }else{
                    [orderdic setObject:@1 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@1,@"model":@1,@"ios_version":VERSION
//                                 };
                }
            }else if (_flags==2){
                if (_flag==1) {
                    [orderdic setObject:@2 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@2,@"model":@1,@"ios_version":VERSION
//                                 };
                }else{
                    [orderdic setObject:@3 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@3,@"model":@1,@"ios_version":VERSION
//                                 };
                }
                
            }else if (_flags==3){
                if (_flag==1) {
                    [orderdic setObject:@3 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"flag":@3,@"model":@1,@"ios_version":VERSION
//                                 };
                }else if(_flag==2){
                    [orderdic setObject:@3 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@3,@"model":@1,@"ios_version":VERSION
                                 //};
                }else if(_flag==3){
                    [orderdic setObject:@2 forKey:@"flag"];
//                    dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"flag":@2,@"model":@1,@"ios_version":VERSION
//                                 };
                }
            //dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"flag":@2
                //    };
            }else if(_flags==0){
//                dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"model":@1,@"ios_version":VERSION
//                             };
                
            }else{
//                dictionary=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"model":@1,@"ios_version":VERSION
//                             };
                
            }
        }
        
        NSData *jsonDatas = [NSJSONSerialization dataWithJSONObject:orderdic options:NSJSONWritingPrettyPrinted error:nil];
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
#pragma mark 判断 到店 上门 普通
            if (_flag==2){
                url=[BassAPI requestUrlWithPorType:PortTypeDeletestoreorde];
            }else if (_flag==3){
                url=[BassAPI requestUrlWithPorType:PortTypeDeleteComeorde];
            }else if(_flag==1){
                url=[BassAPI requestUrlWithPorType:PortTypeDelectPuOrderList];
                
            }
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
                   [muarr removeAllObjects];
                   for (NSArray * arry in arr) {
                    NSMutableArray *farr=[[NSMutableArray alloc] init];
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
                           models.customerProblem=[dic objectForKey:@"customerProblem"];
                           models.customerStartTime=[dic objectForKey:@"customerStartTime"];
                           models.customerFlag =[[dic objectForKey:@"customerFlag"]integerValue];
                           if ([[dic objectForKey:@"appgoodsId"]objectForKey:@"appexpressId"]) {
                               models.code=[[[dic objectForKey:@"appgoodsId"]objectForKey:@"appexpressId" ]objectForKey:@"code"];
                               models.expressNo=[[[dic objectForKey:@"appgoodsId"]objectForKey:@"appexpressId"]objectForKey:@"expressNo"];
                           }
                        models.saleCount=[dic objectForKey:@"salePrice"];
                           [farr addObject:models];
                       }
                       
                       [muarr addObject:farr];
                   }
                   if (_flags==0) {
                       [table1 reloadData];
                   }else if (_flags==1){
                       [table2 reloadData];
                   }else if (_flags==2){
                       [table3 reloadData];
                   }else if (_flags==3){
                       [table4 reloadData];
                   }
                   
               }else if(i==0){
                   
                   [self json:1 ];
                   [Uikility alert:@"删除成功！"];
                   
                   
               }
           }else{
               //if ([[strs objectForKey:@"msg"]isEqualToString:@"您还没有订单！"]) {
               [muarr removeAllObjects];
               if (_flags==0) {
                   [table1 reloadData];
               }else if (_flags==1){
                   [table2 reloadData];
               }else if (_flags==2){
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //LogisticsViewController *sv=[[LogisticsViewController alloc] init];
    //[self.navigationController pushViewController:sv animated:YES];


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
