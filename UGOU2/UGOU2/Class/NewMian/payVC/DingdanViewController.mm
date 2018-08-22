//
//  DingdanViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/29.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.10.29.9.24 订单
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "DingdanViewController.h"
#import "AdressViewController.h"
#import "PlaceViewController.h"
//#import "Pingpp.h"
#import "LoginViewController.h"
#import "TimeViewController.h"
#import "CartModel.h"
#import "OrderTableViewCell.h"
#import "BassAPI.h"
#import "UGVoucherPresentationController.h"
#import "DingdanfootCell.h"
#import "Footview.h"
#import "Foothearview.h"
#import "Singonarray.h"
#import "CouponsModel.h"
#import "DgViewController.h"
#import "ShangmenViewController.h"
#import "DiscountModel.h"
#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "OrderDiscountModel.h"
#import "CouponsModel.h"
#import "CouponsViewController.h"
#import "SecurityUtil.h"
#define CARTKEY @"cart"
#define ORDINARYKEY @"ordinary"
#import "UGHeader.h"
#import "UGPayManger.h"
@interface DingdanViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,OrderPriceDeleget,UIAlertViewDelegate,UGCustomnNavViewDelegate,UIViewControllerTransitioningDelegate>{
   
    UIView *v1;
    UIView *v2;
    UIView * _shareview;
    NSDictionary *appgoodsId;
    UIView *view1;
    UITextField *field;
    UIToolbar *toolbar;
    UIView *views2;
    UIView *views;
    UILabel *placelabel;
    UILabel *jiagelabels;
    
    UILabel *zong;
    NSMutableArray *paramarr;
    UIImageView *imvbut;
    int zf;
    UILabel *name;
    UILabel *phonelabel;
    Boolean Flag;
    UILabel *gslabel;
   
    NSUserDefaults *de;
    NSDictionary *dics;
    NSString *addressId;
    NSString *orderNo;
    NSString *bodyVal;
    NSMutableDictionary *dictionary;
    NSString *urlS;
    NSString *times;
    //UIImageView *_imageview;
    
    UITableView *_table;
    int shuling;
    UIButton * _uhbutton;
    UIView *_footview;
    NSString *_strs859;
    NSArray *zfarr;
    NSDictionary *param;
    //MKjViewController *_kj;
    NSArray *titler;
    NSArray *iamgearray;
    NSString *url;
    NSMutableArray *_mjarray;
    
    //订单
    NSString *_oredercheart;
    
    UILabel *_Activitylable;
    
    NSMutableArray *_vouchearr;
    //是否支付完成跳转到本程序
    BOOL  _jumpbool;
    //虚拟订单
    NSString *_orderNo;
    // 满减得字符串
    NSMutableString *_MJdiccount;
    
    NSMutableArray * _mjDataArr;
    
    NSString *shareURL;
    NSData *shareImageData;
    UGCustomNavView *_custemNav;
}
@property(nonatomic,assign)UGPayObjctType payType;
@end
static const NSMutableArray *_sectionarr;
@implementation DingdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString *stversion=VERSION;
   // [self addzhifubao];
    self.view.backgroundColor=[UIColor whiteColor];
   // self.navigationController.navigationBar.translucent=NO;
    _orderNo=nil;
    _mjarray=[[NSMutableArray alloc] init];
    _vouchearr=[[NSMutableArray alloc] init];
    _MJdiccount=[[NSMutableString alloc] init];
        v1=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:v1];
    de = [NSUserDefaults standardUserDefaults];
    
    if ([de  objectForKey:@"ids"]) {
        [de removeObjectForKey:@"ids"];
    }
    _sectionarr=[NSMutableArray array];
    //   三方支付
   // [Pingpp setDebugMode:YES];
   
    //[self postMethod:0];
    //[self addtijiao];
     [self adddizhi];
     [self addtable];
     //[self mainJian];
     [self pushview2];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden=YES;
    de=[NSUserDefaults standardUserDefaults];
   
    [self postMethod:0];
    [self addtijiao];
    //NSLog(@"即将出现");
    [_table reloadData];
    
//    if (_number==1) {
//        //[self queryorder];
//    }
//    
//    _number=1;
}

#pragma mark 确认订单 导航栏
-(void)addtijiao{
    //[self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationController.navigationBar.hidden=YES;
    
    _custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    
    [_custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [_custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    _custemNav.Delegate=self;
    _custemNav.title=@"确认订单";
    [v1 addSubview:_custemNav];
}
-(void)LeftItemAction{
    
    [self pushpop];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _custemNav.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden=NO;
    
}

#pragma mark 导航栏点击返回
-(void)pushpop{
    
    [_custemNav removeFromSuperview];
    self.navigationController.navigationBar.hidden=NO;
    [de removeObjectForKey:@"ids"];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)passtime:(NSString *)time{
    times =time;
    _Time=1;
   
}
#pragma mark 判断是否有默认地址
-(void)postMethod:(Boolean )bools{
   
    if ([de objectForKey:@"userId"]) {
        NSString *urls=[BassAPI requestUrlWithPorType:PortTypegetAddressList];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        [dic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [dic setObject:[de objectForKey:@"sessionid"]forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [dic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        [dic setObject:@1 forKey:@"model"];
        [dic setObject:VERSION forKey:@"ios_version"];
       
        NSDictionary *json2=[Uikility initWithdatajson:dic];
       [AFManger postWithURLString:urls parameters:json2 success:^(id responseObject) {
           id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[obj objectForKey:@"success"] boolValue];
           
           if (success) {
               NSArray *arrs=[obj objectForKey:@"data"];
               int i=0;
               do {
                   if ([[[arrs objectAtIndex:i]objectForKey:@"flag"]boolValue]) {
                       Flag=1;
                       break;
                   }
                   i++;
               } while (i<arrs.count);
               if (Flag) {
                   name.text=[[arrs objectAtIndex:i]objectForKey:@"consignee"];
                   phonelabel.text=[[arrs objectAtIndex:i]objectForKey:@"mobile"];
                   placelabel.text=[NSString stringWithFormat:@"%@%@",[[arrs objectAtIndex:i]objectForKey:@"area"],[[arrs objectAtIndex:i]objectForKey:@"deaddress"]];
                   addressId=[[arrs objectAtIndex:i]objectForKey:@"id"];
                   
                   
               }else{
                   name.text=@"";
                   phonelabel.text=@"手机号";
                   placelabel.text=@"";
                   
               }
               if (bools) {
                   PlaceViewController *place=[[PlaceViewController alloc]init];
                   [self.navigationController pushViewController:place animated:YES];
               }
               
           }else{
               if ([obj objectForKey:@"msg"]) {
                   [Uikility alert:[obj objectForKey:@"msg"]];
               }
               
               if(bools) {
                   AdressViewController *ad=[[AdressViewController alloc]init];
                   ad.flage=1;
                   [self.navigationController pushViewController:ad animated:YES];
               }
           }
 
       } failure:^(NSError *error) {
            [Uikility alert:@"数据接受失败！"];
       }];
    }else{
        [Uikility alert:@"请先登录！"];
    }
    
}


#pragma mark 收货信息 头部视图
-(void)adddizhi{
    
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, 90*KIphoneWH)];
    
    [v1 addSubview:view1];
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 90*KIphoneWH)];
    v.backgroundColor=[UIColor whiteColor];
    [ view1 addSubview:v ];
    UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(20*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 40*KIphoneWH)];
    [v addSubview:namelabel];
    namelabel.text=@"收货人：";
    namelabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    name=[[UILabel alloc]initWithFrame:CGRectMake(100*KIphoneWH, 5*KIphoneWH, WIDTH-240*KIphoneWH, 40*KIphoneWH)];
    name.text=@"";
    name.font=[UIFont systemFontOfSize:20*KIphoneWH];
    name.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1];
    [v addSubview:name];
    phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-130*KIphoneWH, 5*KIphoneWH, 125*KIphoneWH, 40*KIphoneWH)];
    phonelabel.text=@"手机号";
    phonelabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    phonelabel.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1];
    [v addSubview:phonelabel];
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(15*KIphoneWH, 50*KIphoneWH, 20*KIphoneWH, 30*KIphoneWH)];
    [v addSubview:imgv];
    imgv.image=[UIImage imageNamed:@"定位@2x"];
    placelabel=[[UILabel alloc]initWithFrame:CGRectMake(40*KIphoneWH, 50*KIphoneWH, WIDTH-50*KIphoneWH, 30*KIphoneWH)];
    placelabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    placelabel.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1];
    [v  addSubview:placelabel];
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20*KIphoneWH, 59*KIphoneWH, 15*KIphoneWH, 15*KIphoneWH)];
    [v addSubview:imv];
    imv.image=[UIImage imageNamed:@"下一页@2x"];
    v.userInteractionEnabled=YES;
    //修改地址跳转手势
    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushplace)];
    [v addGestureRecognizer:imgtap];
  

}
#pragma mark 点击图片 更换地址
-(void)pushplace{
   
    [self postMethod:1];
}
#pragma mark 品牌
-(void)pushbrand{
    
}
#pragma mark tableview

#pragma mark 添加控件 tableview 滑动
-(void)addtable{
    //第一个 view
    
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight+90*KIphoneWH, WIDTH, HEIGHT-NavHeight-140*KIphoneWH) style:UITableViewStyleGrouped];
    [v1 addSubview:_table];
    _table.delegate=self;
    _table.dataSource=self;
    
    [_table reloadData];
    [self addfootview];
    _table.tableFooterView=_footview;
    [self addtoolbarview];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   return 50*KIphoneWH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*KIphoneWH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr=_array[section];
    CartModel *sp=arr[0];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
   UIImageView * iconimagview=[[UIImageView alloc]initWithFrame:CGRectMake(15*KIphoneWH, 5*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
    [view addSubview:iconimagview];
    
  UIButton *iconbtn=[[UIButton alloc]initWithFrame:CGRectMake(40*KIphoneWH, 5*KIphoneWH, WIDTH-50*KIphoneWH, 30*KIphoneWH)];
    [view addSubview:iconbtn];
   
    iconbtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    iconbtn.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [iconbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [iconbtn addTarget:self action:@selector(pushbrand) forControlEvents:UIControlEventTouchUpInside];
    if (_pagenumer==1) {
            iconimagview .image=[UIImage imageNamed:@"shop@2x"];
           [NSString stringWithFormat:@"%@ >",sp.orderNo];
        [iconbtn setTitle:[NSString stringWithFormat:@"%@ >",_order] forState:UIControlStateNormal];
    }else{
         [iconimagview sd_setImageWithURL:[Uikility URLWithString:sp.logopic] placeholderImage:[UIImage imageNamed:@"uuu"]];
       [iconbtn setTitle:[NSString stringWithFormat:@"%@ >",sp.brandName] forState:UIControlStateNormal];
    }
    return view;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *lables=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH,5*KIphoneWH, 120*KIphoneWH , 40*KIphoneWH)];
    lables.text=@"使用优惠券";
    lables.textAlignment=NSTextAlignmentLeft;
    [view addSubview:lables];
    //if (_flag==1) {
    //NSLog(@"刷新");
    
    UIButton *uhbutton=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 5*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
    //优惠券
     [uhbutton setBackgroundImage:[UIImage imageNamed:@"使用优惠券-@2x"] forState:UIControlStateNormal];
    [uhbutton addTarget:self action:@selector(changeNumbertwo:) forControlEvents:UIControlEventTouchUpInside];
    uhbutton.tag=section;
    
    if ([de  objectForKey:@"ids"]) {
        NSArray *arr=[de objectForKey:@"ids"];
        NSMutableArray *arrays=[NSMutableArray array];
        [arrays addObjectsFromArray:arr];
        for (NSData *d in arr) {
           
            CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d];
            
            NSString *s=dmol.buttag;
            
            int a=s.intValue;
            
            
            if (section == a) {
                
        [ uhbutton setBackgroundImage:[UIImage imageNamed:@"使用优惠券-选中@2x"] forState:UIControlStateNormal];
                
                uhbutton.selected=YES;
                
            }
       }

    }

    [view addSubview:uhbutton];

    return view;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 140*KIphoneWH;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_array.count) {
        return _array.count;
    }
    return 0;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_array.count) {
        NSArray *arr=_array[section];
        return arr.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    NSArray *arr=_array[indexPath.section];
    CartModel *sp=arr[indexPath.row];
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.titleimgview sd_setImageWithURL:[Uikility URLWithString:sp.logopicUrl] placeholderImage:[UIImage imageNamed:@"uuu"]];
    cell.titlelabel.text=sp.goodsName;
    cell.attlabel.text=sp.attribute;
    if (_pagenumer==1) {
        CGFloat s=sp.money.floatValue;
        cell.priclelabel.text=[NSString stringWithFormat:@"￥%.1f",s];
        
        
    }else{
        
        if (_IsCart) {
            if (sp.vipFlag) {
                CGFloat vipc=sp.vipPrice.floatValue;
                cell.priclelabel.text=[NSString stringWithFormat:@"￥%.1f",vipc];
            }else{
            
                CGFloat pc=sp.promotionPrice.floatValue;
                cell.priclelabel.text=[NSString stringWithFormat:@"￥%.1f",pc];

            }
        }else{
    CGFloat s=[Uikility priceToCompareVipprice:sp.promotionPrice vipnumber:sp.vipPrice];
            cell.priclelabel.text=[NSString stringWithFormat:@"￥%.1f",s];}
    }
    cell.quartlabel.text=[NSString stringWithFormat:@"x%zd",sp.quantity];
    cell.slabel.text=[NSString stringWithFormat:@"%zd",sp.quantity];
  
    return cell;
}

-(void)addfootview{
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 160*KIphoneWH)];
    _footview.backgroundColor=[UIColor whiteColor];
        NSArray *array=@[@"配送方式",@"配送时间",@"备  注:",@"活 动"];
        for (int i=0; i<array.count; i++) {
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH,5*KIphoneWH+40*i*KIphoneWH, 120*KIphoneWH , 30*KIphoneWH)];
    lable.text=array[i];
    lable.textAlignment=NSTextAlignmentLeft;
    if(i==3){
                lable.textColor=[UIColor redColor];
            }
    [_footview addSubview:lable];
    
     }

    UIButton *yflabel=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-120*KIphoneWH, 5*KIphoneWH, 100*KIphoneWH, 40*KIphoneWH)];
        [yflabel addTarget:self action:@selector(pushyf) forControlEvents:UIControlEventTouchUpInside];
        [yflabel setTitle:@"运费 免邮>" forState:UIControlStateNormal];
    [yflabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    yflabel.titleLabel .font=[UIFont systemFontOfSize:18*KIphoneWH];
        [_footview addSubview:yflabel];

    UILabel *timelabel =[[UILabel alloc]initWithFrame:CGRectMake(120*KIphoneWH, 45*KIphoneWH,WIDTH-130*KIphoneWH, 30*KIphoneWH)];
    
    timelabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    timelabel.textAlignment=NSTextAlignmentRight;
            [_footview addSubview:timelabel];
    field=[[UITextField alloc]initWithFrame:CGRectMake(70*KIphoneWH, 80*KIphoneWH, WIDTH-80*KIphoneWH, 40*KIphoneWH)];
           field.placeholder=@"选填,可填写您和卖家达成一致的要求";
           field.delegate=self;
        field.font=[UIFont systemFontOfSize:16*KIphoneWH];
          field.keyboardType=UIKeyboardTypeDefault;
    
    _Activitylable=[[UILabel alloc] initWithFrame:CGRectMake(70*KIphoneWH, 120*KIphoneWH, WIDTH-80*KIphoneWH, 40*KIphoneWH)];
    
    _Activitylable.textColor=[UIColor redColor];
    _Activitylable.font=[UIFont systemFontOfSize:18*KIphoneWH];
   
    NSMutableString *mjactivity=[[NSMutableString alloc] initWithCapacity:0];
    if (_mjarray.count) {
        NSString *ssstr=@"本时间内没有活动";
        [mjactivity appendString:ssstr];
    }else{
        for(CouponsModel *model in _mjarray){
            NSInteger money1=model.money01.integerValue;
            NSInteger money2=model.money02.integerValue;
            NSString *ssstr=[NSString stringWithFormat:@"满%zd减%zd",money2,money1];
            [mjactivity appendString:ssstr];
        }
    }
    [_footview addSubview:_Activitylable];
    [_footview addSubview:field];

    
}
#pragma mark 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)pushyf{
#pragma mark 运费
}
#pragma mark********满减
-(void)mainJian{
    
    if ([de objectForKey:@"userId"]!=nil) {
       NSMutableDictionary *mj=[[NSMutableDictionary alloc] init];
        [mj setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [mj setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
//        if ([de objectForKey:@"newUserId"]) {
//            [mj setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
//        }
       
        [mj setObject:@1 forKey:@"model"];
        [mj setObject:VERSION forKey:@"ios_version"];
        if([de objectForKey:@"placename"]){
            [mj setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
        if(_flag==1){
            [mj setObject:@1 forKey:@"appOrderType"];
        }else if (_flag==2){
            [mj setObject:@2 forKey:@"appOrderType"];
        }else if (_flag==3){
            [mj setObject:@3 forKey:@"appOrderType"];
            
        }
        NSMutableArray * couparr=[[NSMutableArray alloc] init];
        //优惠券
        for (NSData *cpdata in [de objectForKey:@"ids"])
        {
            CouponsModel *model=[NSKeyedUnarchiver unarchiveObjectWithData:cpdata];
            [couparr addObject:model.id];
        }
        NSMutableArray *  cartDiscountIds=[[NSMutableArray alloc] init];
        for(DiscountModel *model in _discountIds){
            
            [cartDiscountIds addObject:model.id];
        
        }
        [mj setObject: cartDiscountIds forKey:@"shopcartDiscountIds"];
        
        NSMutableArray *zhekouids=[[NSMutableArray alloc] init];
        for (DiscountModel *zkmodel in _ZheKouIDs) {
            [zhekouids addObject:zkmodel.id];
        }
        //折扣类型
        [mj setObject: zhekouids forKey:@"shopcartZhekouIds"];
        
        [mj setObject:couparr forKey:@"userVoucherIds"];
        if (_orderNo==nil) {
            
        }else{
            [mj setObject:_orderNo forKey:@"orderNo"];
        }
    if(_IsCart){
        
            NSMutableArray *mtarr=[[NSMutableArray alloc] init];
        
            for (NSArray *arr in _array) {
                for (CartModel *model in arr) {
                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc] init];
                    //NSNumber *storeid=model.appStoresId;
                    
                    [dic1 setObject:model.id forKey:@"goodId"];
                    NSString *quantitystr=[NSString stringWithFormat:@"%zd",model.quantity];
                    [dic1 setObject:quantitystr forKey:@"quantity"];
                    if (model.vipFlag) {
                        [dic1 setObject:@1 forKey:@"vipFlag"];
                    }else{
                     [dic1 setObject:@0 forKey:@"vipFlag"];
                    }
                    
                    [mtarr addObject:dic1];
                }
            }
            //[dic setObject:mtarr forKey:@"cartId"];
        
            [mj setObject:mtarr forKey:CARTKEY];
        }else{
        
            
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc] init];
            
            for(NSArray *arr in _array){
                for (CartModel *model in arr) {
                   [dic1 setObject:model.id forKey:@"goodId"];
                    NSString *quantitystr=[NSString stringWithFormat:@"%zd",model.quantity];
                    [dic1 setObject:quantitystr forKey:@"quantity"];
                    NSNumber *ifvip=[Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                    if(ifvip.integerValue){
                        
                        [dic1 setObject:@1 forKey:@"vipFlag"];
                    }else{
                        [dic1 setObject:@0 forKey:@"vipFlag"];
                    }

                    
                }
            }

          
         [mj setObject:dic1 forKey:ORDINARYKEY];
        
        }
        
        NSString *userid=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        NSString *bassuserid=[GTMBase64 encodeBase64String:userid];
        NSString *params=[Uikility initWithdatajsonstring:mj];
       NSString *aesparams=[SecurityUtil encryptAESData:params passwordKey:[de objectForKey:COOKIE]];
        
        NSDictionary *json13=@{@"param":aesparams };
    NSString *mjurls=[BassAPI requestUrlWithPorType:PortTypeNewMJOrderType];
       
     [AFManger headerFilePostWithURLString:mjurls parameters:json13 Hearfile:bassuserid success:^(id responseObject) {
         id objects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         Boolean success=[[objects objectForKey:@"success"] boolValue];
         //NSLog(@"%@",objects);
         if(success){
             NSDictionary *dadadic=[objects objectForKey:@"data"];
             NSNumber *countprice=[dadadic objectForKey:@"countPrice"];
             NSNumber * quantity=[dadadic objectForKey:@"quantity"];
             _allprice=countprice.floatValue;
             _gs=quantity.integerValue;
            
             zong.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f",_gs,_allprice];
             _mjDataArr=[[NSMutableArray alloc] init];
             NSArray *ordelarr=[dadadic objectForKey:@"manJianVoucher"];
              NSMutableString *activityStr=[[NSMutableString alloc] init];
             _MJdiccount =[[NSMutableString alloc] init];
             for (NSDictionary *ordeldic in ordelarr) {
                  OrderDiscountModel *ordel=[OrderDiscountModel initWithKeysDic:ordeldic];
                 ordel.brandName=[[ordeldic objectForKey:@"appbrandId"] objectForKey:@"brandName"];
                 if (ordel.id!=nil) {
                     NSNumber *money1=ordel.money01;
                    NSNumber *money2=ordel.money02;
                     //NSString *brandname=ordel.brandName;
                     NSString *str=[NSString stringWithFormat:@" 满%@减%@",money2,money1];
                     [_mjDataArr addObject:ordel];
                     [_MJdiccount appendFormat:@"%@,",ordel.id];
                     [activityStr appendString:str];
                 }
             }
             _Activitylable.text=activityStr;
             //订单号
             _orderNo=[dadadic objectForKey:@"orderNo"];
             
             //优惠券
             [_vouchearr removeAllObjects];
             NSArray *voucher=[dadadic objectForKey:@"userVoucher"];
             for (NSDictionary *dic in voucher) {
                NSDictionary * voucherId=[dic objectForKey:@"appvoucherId"];
                CouponsModel *coumodel=[CouponsModel initWithModeldic:voucherId];
                 NSDictionary *branddic=[voucherId objectForKey:@"appbrandId"];
                 coumodel.brandids=[branddic objectForKey:@"id"];
                 coumodel.userVoucherId=[dic objectForKey:@"id"];
                             
                 [_vouchearr addObject:coumodel];
             }
             
             _ZheKouIDs=[[NSMutableArray alloc] init];
             NSArray *zhekouArr=[dadadic objectForKey:@"shopcartZhekou"];
             for (NSDictionary *zhekouDic in zhekouArr) {
                 DiscountModel *discountModel=[DiscountModel initWithdictomodel:zhekouDic];
                 discountModel.brandId=[[zhekouDic objectForKey:@"appbrandId"] objectForKey:@"id"];
                 [_ZheKouIDs addObject:discountModel];
             }
             
             
             if (_mysblock) {
                    _mysblock(1);
                }
             
         }else{
         
         
             [Uikility alert:[objects objectForKey:@"msg"]];
         }
     } failure:^(NSError *error) {
         
     
     }];
   }else{
    
    [Uikility alert:@"请先登录"];
    
    }

    
}

#pragma mark ********按钮优惠券
-(void)changeNumbertwo:(UIButton *)b{
if ([de  objectForKey:@"ids"]) {
        NSArray *arr=[de objectForKey:@"ids"];
        NSMutableArray *arrays=[NSMutableArray array];
        [arrays addObjectsFromArray:arr];
        for (NSData *d in arr) {
            
            CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d];
            NSString *s=dmol.buttag;
            int a=s.intValue;
        if (b.tag== a) {
            b.selected=NO;
        [b setBackgroundImage:[UIImage imageNamed:@"使用优惠券-@2x"] forState:UIControlStateNormal];
            if (_ordercblock) {
                    _ordercblock(2);
                    NSArray *arr=[de objectForKey:@"ids"];
                    NSMutableArray *arrays=[NSMutableArray array];
                    [arrays addObjectsFromArray:arr];
                    for (NSData *d in arr) {
                        CouponsModel *dmodel=[NSKeyedUnarchiver unarchiveObjectWithData:d];
                       NSString *s=dmodel.buttag;
                        int a=s.intValue;
                        if (b.tag == a) {
                            [arrays removeObject:d];
                            [de setObject:arrays forKey:@"ids"];
                            [self mainJian];
                            return;
                        }
                        
                    }
                }

            }
        }
    }
    if (b.selected==NO) {
       
        if ([de objectForKey:@"userId"]==nil) {
            [Uikility alert:@"请先登录！"];
        }else{
            //新界面
            
            NSArray *arr=_array[b.tag];
            CartModel *m=arr[0];
         CouponsViewController  * kj=[[CouponsViewController alloc]init];
            //kj.flagss=2;
            kj.money=_allprice;
            kj.brandid=m.brandid;
            kj.buttonpage=b.tag;
            
            kj.buttag=b.tag;
        CGFloat p=0;
            for (int i=0; i<arr.count; i++) {
                
                if (m.quantity) {
                    NSInteger i=m.quantity;
                    p=p+m.promotionPrice.floatValue*i;
                }else{
                    p=p+m.promotionPrice.floatValue;
                }
                
                //返回来的 id 数组 
                NSArray *arr=[NSArray array];
                kj.arrids=arr;
                kj.price=p;
                kj.couponsarr=_vouchearr;
                
            }
            
             kj.orderdeleget=self;
           
        //[self.navigationController pushViewController:kj animated:YES];
            
            kj.transitioningDelegate=self;
            kj.modalPresentationStyle=UIModalPresentationCustom;
            [self presentViewController:kj animated:YES completion:nil];
             //b.selected=YES;
        }

        
        
    }else{
        
        
        if (_ordercblock) {
            _ordercblock(2);
            NSArray *arr=[de objectForKey:@"ids"];
            NSMutableArray *arrays=[NSMutableArray array];
            [arrays addObjectsFromArray:arr];
            for (NSData *d in arr) {
                //NSArray *ks=[d allKeys];
                CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d];
                
                NSString *s=dmol.buttag;
                int a=s.intValue;
                if (b.tag == a) {
                    [arrays removeObject:d];
                   
                    [de setObject:arrays forKey:@"ids"];
                }
                
            }
        }
        b.selected=NO;
    }
}

-(UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[UGVoucherPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}
#pragma mark********选择优惠券后的代理方法
-(void)selectCouponsId:(NSNumber *)couponsId{
    [_table reloadData];
    [self mainJian];
    if (_mysblock) {
            _mysblock(1);
        }
    
        __block void (^ocblock)(NSInteger a)=^(NSInteger a){
            //[self mainJian];
        };
        _ordercblock=ocblock;
    

}
#pragma mark********选择优惠券后的代理方法
-(void)preferentialchangge:(NSInteger)text page:(NSInteger)page{
        _allprice=_allprice-text;
        zong.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f",_gs,_allprice];
    
    if (_mysblock) {
        _mysblock(1);
    }
    
    
    
    void (^ocblock)(NSInteger a)=^(NSInteger a){
        _allprice=_allprice+text;
        
        zong.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f",_gs,_allprice];
    };
          _ordercblock=ocblock;

}

#pragma mark ********下方 备注
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addtoolBars];
   // toolbar.frame=CGRectMake(0, 0, 0, 0);
}

#pragma mark ************下方  键盘消失
-(void)addtoolBars{
    CGRect rect=CGRectMake(0, -300*KIphoneWH, WIDTH, HEIGHT-80*KIphoneWH);
    v1.frame=rect;
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30*KIphoneWH)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [field setInputAccessoryView:topview];
}
#pragma mark
-(void)resignKeyboard{
    [field resignFirstResponder];
  //toolbar.frame=CGRectMake(0, HEIGHT-60, WIDTH, 50);
    CGRect rect=CGRectMake(0, 0, WIDTH, HEIGHT-80*KIphoneWH);
    
    v1.frame=rect;
    
}

#pragma mark *******创建底部
-(void)addtoolbarview{
  
    
    zong=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT-45*KIphoneWH, WIDTH/3*2-5*KIphoneWH, 40*KIphoneWH)];
      zong.text=[NSString stringWithFormat:@"共%zd件商品,合计:￥%.1f",_gs,_allprice];
    zong.font=[UIFont systemFontOfSize:20*KIphoneWH];
    zong.textAlignment=NSTextAlignmentRight;
 
    [self.view addSubview:zong];
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-WIDTH/3,  HEIGHT-50*KIphoneWH, WIDTH/3, 50*KIphoneWH)];
    [but addTarget:self action:@selector(pushfoots) forControlEvents:UIControlEventTouchUpInside];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"立即付款" ofType:@"jpg"];
    UIImage *fkimage=[UIImage imageWithContentsOfFile:path];
    [but setImage:fkimage forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"立即付款@2x.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:but];
    [self mainJian];
    [self pushview2];
}


#pragma mark *************是否分享弹出框

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        
    
    
    //根据被点击按钮的索引处理点击事件,buttonIndex表示被点击的按钮的下标，默认cancel是0
    if (buttonIndex==0) {
        return;
    }else if (buttonIndex==1){
       
       [self postMethod:1];
        
        
    }
        //是否弹出分享页面
    }else if (alertView.tag==2){
        
        if (buttonIndex==0) {
            if (_flag==1) {
                DgViewController *dg=[[DgViewController alloc] init];
                dg.flag=1;
                dg.flags=1;
                dg.indexflag=2;
                [self.navigationController pushViewController:dg animated:YES];
                
            }else if (_flag==2){
                DgViewController *dg=[[DgViewController alloc] init];
                dg.flag=2;
                dg.flags=1;
                dg.indexflag=2;
                [self.navigationController pushViewController:dg animated:YES];
            }else if (_flag==3){
                ShangmenViewController *sm=[[ShangmenViewController alloc] init];
                sm.flag=3;
                sm.flags=1;
                sm.indexflag=2;
                [self.navigationController pushViewController:sm animated:YES];
                
            }
           
        
            
        }else if (buttonIndex==1){
        
            //[self  creatshareview];
            [self getShareImage];
        }
    }else if (alertView.tag==10){
        if (buttonIndex==0) {
             [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else if (buttonIndex==1){
            v2.alpha=0;
        
        }
    
    
    }
}

#pragma mark*********立即付款的事件 动画 出现下方视图
-(void)pushfoots{
    
    if (addressId==0) {
      
        
        UIAlertView *shview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择收货地址！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        shview.tag=1;
        [shview show];


    }else{
      
    if (_flag==1) {
//        UIAlertView *altview=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已生成订单是否分享优惠券" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享", nil];
//        altview.tag=2;
//        [altview show];
        v2.alpha=1;
        [UIView beginAnimations:@"animatePopView" context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView commitAnimations];

    }else{
        
        if (_Time==1) {
           
            v2.alpha=1;
//            if (_pagenumer==1) {
//
//            }else{
//
//            //保存订单
//            //[self smdingdan:1];
//               
//            }
            
            //[self smdingdan:1];
            [UIView beginAnimations:@"animatePopView" context:nil];
            [UIView setAnimationDuration:0.4];
            [UIView commitAnimations];

        }else{
            TimeViewController *t=[[TimeViewController alloc]init];
            t.flag=_flag;
            t.delegate=self;
            [self.navigationController pushViewController:t animated:YES];
            
        }
    }
    }
   
}
#pragma mark *****************第选择支付视图 点击后下方视图
-(void)pushview2{
    
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
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-80*KIphoneWH, 5*KIphoneWH,200*KIphoneWH, 40*KIphoneWH)];
    titlelabel.text=@"选择付款方式";
    titlelabel.font=[UIFont systemFontOfSize:24*KIphoneWH];
    [views2 addSubview:titlelabel];
    //if (_flag==1) {
        //if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
               zfarr=@[@"支付宝支付",@"微信支付"];
        //}else{
        //zfarr=@[@"支付宝支付",@"银联"];
        //}
//    }else {
//        //if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
//           zfarr=@[@"支付宝支付",@"银联",@"微信支付",@"线下支付"];
//        //}else{
//        //zfarr=@[@"支付宝支付",@"银联",@"线下支付"];
//       // }
//    }
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
#pragma mark****** 提交订单
-(void)pushxia{
    if (zf) {
        if (zf==4) {

        }else{
            if (_flag==1) {
                [self regularPay];
            }else{
                [self smdingdan:1 payData:nil];
            
            }
            
        }
    }else{
     [Uikility alert:@"请选择付款方式！"];
        return;
    }
    
    
    //[self queryorder];
    
}
#pragma mark**********普通订单支付 请求chare对象
-(void)regularPay{
   
    if ([de objectForKey:@"userId"]) {
        //NSString *allprice=[NSString stringWithFormat:@"%.1f",_allprice];
        NSNumber *numbprice=[[NSNumber alloc] initWithFloat:_allprice];
        // NSNumber * min = @([allprice integerValue]);
        NSMutableDictionary *pingDic=[[NSMutableDictionary alloc] init];
        [pingDic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [pingDic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        [pingDic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [pingDic setObject:@"U购" forKey:@"subjectVal"];
        [pingDic setObject:@"u购" forKey:@"bodyVal"];
        [pingDic setObject:@true forKey:@"model"];
        [pingDic setObject:VERSION forKey:@"ios_version"];
        //[pingDic setObject:_allprice forKey:@"summary"];
        [pingDic setObject:numbprice forKey:@"summary"];
        if(_orderNo==nil){
            [Uikility alert:@"当前网速较慢请重试"];
        }else{
            [pingDic setObject:_orderNo forKey:@"orderNo"];
            
        }
        NSString *urls=nil;
        if (zf==1) {
            [pingDic setObject:@"alipay" forKey:@"channelVal"];
            self.payType=UGPayObjctTypeALPay;
            urls=[BassAPI requestUrlWithPorType:portTypeGetUGPayALiPay];
            if (_flag==1) {
                [pingDic setObject:@1 forKey:@"appOrderType"];
            }else if(_flag==2){
                
                [pingDic setObject:@2 forKey:@"appOrderType"];
            }else if (_flag==3){
                
                
                [pingDic setObject:@3 forKey:@"appOrderType"];
            }
        }else if (zf==2){
//            self.payType=UGPayObjctTypeUPAPay;
//            urls=[BassAPI requestUrlWithPorType:portTypeGetTransReqUGPayYinL];
//            [pingDic setObject:@"upacp" forKey:@"channelVal"];
//            if(_flag==1){
//                [pingDic setObject:@1 forKey:@"appOrderType"];
//
//            }else if (_flag==2){
//                [pingDic setObject:@2 forKey:@"appOrderType"];
//            }
//            else if (_flag==3){
//              [pingDic setObject:@3 forKey:@"appOrderType"];
//            }
            
            
            self.payType=UGPayObjctTypeWX;
            urls=[BassAPI requestUrlWithPorType:portTypeGetUGPayWChatPay];
            [pingDic setObject:@"wx" forKey:@"channelVal"];
            if (_flag==1) {
                
                [pingDic setObject:@1 forKey:@"appOrderType"];
            }else if (_flag==2){
                
                [pingDic setObject:@2 forKey:@"appOrderType"];
            }else if (_flag==3){
                
                [pingDic setObject:@3 forKey:@"appOrderType"];
            }
        }else if (zf==3){
            self.payType=UGPayObjctTypeWX;
            urls=[BassAPI requestUrlWithPorType:portTypeGetUGPayWChatPay];
            [pingDic setObject:@"wx" forKey:@"channelVal"];
            if (_flag==1) {
                
                [pingDic setObject:@1 forKey:@"appOrderType"];
            }else if (_flag==2){
                
                [pingDic setObject:@2 forKey:@"appOrderType"];
            }else if (_flag==3){
                
                [pingDic setObject:@3 forKey:@"appOrderType"];
            }
            
            
        }
        
        NSString *jsonstr=[Uikility initWithdatajsonstring:pingDic];
        NSString *asestr=[SecurityUtil encryptAESData:jsonstr passwordKey:[de objectForKey:COOKIE]];
        
        NSDictionary*  json1=@{@"param":asestr};
        NSString * userid=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        
        NSString *bassuser=[GTMBase64 encodeBase64String:userid];
        [SVProgressHUD showWithStatus:@"正在发起支付"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [AFManger headerFilePostWithURLString:urls parameters:json1 Hearfile:bassuser success:^(id responseObject) {
            
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            Boolean success=[[obj objectForKey:@"success"] boolValue];
        
            //NSLog(@"签名对象%@", obj);
        
            if (success) {
                if (self.payType==UGPayObjctTypeUPAPay) {
                    orderNo=[[obj objectForKey:@"data"]objectForKey:@"orderId"];
                }else if (self.payType==UGPayObjctTypeWX){
                    orderNo=[[obj objectForKey:@"data"]objectForKey:@"orderNo"];
                }else if (self.payType==UGPayObjctTypeALPay){
                    orderNo=[[obj objectForKey:@"data"]objectForKey:@"orderNo"];
                }
                if (_flag==1) {
                     [self dingdan:1 paymessay:obj];
                }else if (_flag==3){
                    [self smdingdan:1 payData:obj];
                    
                }else if (_flag==2){
                    [self smdingdan:1 payData:obj];
                }
            }else{
                
                [SVProgressHUD showErrorWithStatus:[obj objectForKey:@"msg"]];
                [SVProgressHUD dismissWithDelay:1];
                
            }
            
            
        } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:@"当前网速不佳"];
          [SVProgressHUD dismissWithDelay:1];
        }];
        
    }else{
        //登录
        [Uikility alert:@"请先登录！"];
        return;
        
    }

}

#pragma mark*******线下支付 保存订单
-(void)xxPayOrder:(int)dd{
    dictionary=[[NSMutableDictionary alloc] initWithCapacity:0];
    if ([de objectForKey:@"userId"]) {
        NSDictionary *d=nil;
        if ([de objectForKey:@"newUserId"]) {
            d =@{
                 @"userId":[de objectForKey:@"userId"]
                 };
        }else{
        d =@{
                 @"userId":[de objectForKey:@"userId"]
                };
        }
      
       NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //NSNumber * minsg = @([addressId integerValue]);
        
        NSDictionary *d1=@{
                           @"id": addressId
                           
                           };
        NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        
        paramarr=[NSMutableArray array];
        for(int j=0;j<_array.count;j++){
            NSArray *aarr=_array[j];
            for ( int z=0;z<aarr.count;z++) {
                CartModel *model=aarr[z];
                //NSString *brandid=[NSString stringWithFormat:@"%@",model.brandid];
                NSDictionary *appbrand=@{@"id":model.brandid};
                
                NSString *strbrand=[Uikility initWithdatajsonstring:appbrand];
                
                appgoodsId=@{
                             @"id": model.id,
                             @"appbrandId":strbrand
                             };
                NSData *Datad = [NSJSONSerialization dataWithJSONObject:appgoodsId options:NSJSONWritingPrettyPrinted error:nil];
                NSString *appgoods=[[NSString alloc] initWithData:Datad encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@" " withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
                NSDictionary *storedic=@{@"id":model.appStoresId};
                NSData *storeDatad1 = [NSJSONSerialization dataWithJSONObject:storedic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsondstore1=[[NSString alloc] initWithData:storeDatad1 encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                jsondstore1=[jsondstore1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                jsondstore1=[jsondstore1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                jsondstore1=[jsondstore1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSString *sa=nil;
                NSMutableArray *muarr=[NSMutableArray array];
                NSArray *array= [de   objectForKey:@"ids"];
                for(NSData *dic in array){
                    CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:dic];
                    [muarr addObject:dmol];
                }
                
                NSMutableArray *couponids=[NSMutableArray array];
                NSArray *array1= [de   objectForKey:@"ids"];
                for(NSData *dic in array1){
                    CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:dic];
                    NSString *ssid=[NSString stringWithFormat:@"%@",dmol.userVoucherId];
                    [couponids addObject:ssid];
                }
                
                CGFloat shopprice;
                
                if (_IsCart) {
                    if (model.vipFlag) {
                        shopprice=model.vipPrice.floatValue;
                    }else{
                        shopprice=model.promotionPrice.floatValue;
                        }
                }else{
                    
                    shopprice=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
                    
                }
                sa=[NSString stringWithFormat:@"%.1f",shopprice];
                
                NSString *sas=[NSString stringWithFormat:@"%.1ld", (long)model.quantity];
                NSNumber * minas = @([sas integerValue]);
                
                //地址code
                NSNumber *codeid=  [de objectForKey:@"placename"];
                NSDictionary *codedic=@{@"id":codeid};
                NSString *codestr=[Uikility initWithdatajsonstring:codedic];
                
                if (dd==1) {
                    //判断第一个商品 是否满减
                    if(j==0){
                        if (z==0) {
                            if (_MJdiccount) {
                                [dictionary setObject:_MJdiccount forKey:@"manjianVoucherId"];
                            }
                    NSMutableString *mustr=[[NSMutableString alloc] init];
                    if (couponids.count) {
                                
                                for(NSString * coupid in couponids){
                                    [mustr appendString:[NSString stringWithFormat:@"%@,",coupid]];
                                    }
                                
                       [dictionary setObject:mustr forKey:@"userVoucherId"];
                            }
                            
                            if (_discountIds.count) {
                                NSString *disstr=[[NSMutableString alloc] init];
                                for (DiscountModel *dismodel in _discountIds) {
                                    
                                    [disstr stringByAppendingString:[NSString stringWithFormat:@"%@,",dismodel.id]];
                                    
                                }
                  [dictionary setObject:disstr forKey:@"shopcartDiscountId"];
                            }
                        }else{
                
                            [dictionary removeObjectForKey:@"shopcartDiscountId"];
                            [dictionary removeObjectForKey:@"userVoucherId"];
                            [dictionary removeObjectForKey:@"manjianVoucherId"];
                        }
                    }else{
                        [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                    }
                //  是否是VIP
                    if (_IsCart) {
                        NSNumber *vipflag=[NSNumber numberWithBool:model.vipFlag];
                        [dictionary setObject:vipflag forKey:@"vipFlag"];
                    }else{
                        NSNumber * isVip= [Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                        [dictionary setObject:isVip forKey:@"vipFlag"];
                    }
                    
                    [dictionary setObject:sa forKey:@"money"];
                    [dictionary setObject:@0 forKey:@"client"];
                   [dictionary setObject:jsond forKey:@"appuserId"];
                    [dictionary setObject:jsond1 forKey:@"appaddressId"];
                    [dictionary setObject:appgoods forKey:@"appgoodsId"];
                    [dictionary setObject:model.attribute  forKey:@"attribute"];
                    [dictionary setObject:codestr forKey:@"appchinaId"];
                    [dictionary setObject:minas forKey:@"quantity"];
                    [dictionary setObject:@0 forKey:@"flag"];
                    [dictionary setObject:jsondstore1 forKey:@"appStoresId"];
                    if (field.text) {
                        [dictionary setObject:field.text forKey:@"remark"];
                        
                    }else{
                        [dictionary setObject:@"1312" forKey:@"remark"];
                    }
                    
                    if (_flag==1) {
                        
                    }else{
                        [dictionary setObject:times forKey:@"timeShop"];
                        
                    }
                }else if (dd==2){
                    
                    // 判断第一个商品 满减和优惠券
                    if(j==0){
                        if (z==0) {
                            
                            if(_MJdiccount){
                                
                                [dictionary setObject:_MJdiccount forKey:@"manjianVoucherId"];
                            }
                            
                if(couponids.count){
                                
                                NSMutableString *mustr=[[NSMutableString alloc] init];
                                for(NSString * coupid in couponids){
                                    
                                    [mustr appendString:[NSString stringWithFormat:@"%@,",coupid]];
                                }
                                
                [dictionary setObject:mustr forKey:@"userVoucherId"];
                            }
                            if(_discountIds.count){
                                NSMutableString *disstr=[[NSMutableString alloc] init];
                                for (DiscountModel *dismodel in _discountIds) {
                                    [disstr appendFormat:@"%@",dismodel.id];
                                }
                                [dictionary setObject:disstr forKey:@"shopcartDiscountId"];
                                
                            }
                      }else{
                            [dictionary removeObjectForKey:@"manjianVoucherId"];
                            [dictionary removeObjectForKey:@"userVoucherId"];
                            [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        }
                        
                        
                    }else{
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        
                    }
                    [dictionary setObject:sa forKey:@"money"];
                    [dictionary setObject:@0 forKey:@"client"];
                    [dictionary setObject:jsond forKey:@"appuserId"];
                    [dictionary setObject:jsond1 forKey:@"appaddressId"];
                    [dictionary setObject:appgoods forKey:@"appgoodsId"];
                    [dictionary setObject:model.attribute forKey:@"attribute"];
                    [dictionary setObject:minas forKey:@"quantity"];
                    [dictionary setObject:codestr forKey:@"appchinaId"];
                    
                    [dictionary setObject:@0 forKey:@"flag"];
                    [dictionary setObject:@"123" forKey:@"remark"];
                    [dictionary setObject:times forKey:@"timeShop"];
                    [dictionary setObject:jsondstore1 forKey:@"appStoresId"];
                    if (_IsCart) {
                        NSNumber *vipflag=[NSNumber numberWithBool:model.vipFlag];
                        [dictionary setObject:vipflag forKey:@"vipFlag"];
                    }else{
                        NSNumber * isVip= [Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                        [dictionary setObject:isVip forKey:@"vipFlag"];
                    }
                }else{
                    
                    
                }
                
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
                NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
                json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
                json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
                json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
                json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                [paramarr addObject:json];
            }
        }
        
        NSMutableDictionary *paramdic=[[NSMutableDictionary alloc] init];
        [paramdic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [paramdic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [paramdic setObject:@1 forKey:@"model"];
        [paramdic setObject:VERSION forKey:@"ios_version"];
        if (_flag==2){
           [paramdic setObject:paramarr forKey:@"yyorder"];
            
        }else if (_flag==3){
            [paramdic setObject:paramarr forKey:@"smorder"];
        }
        
        
        NSData *Datadp = [NSJSONSerialization dataWithJSONObject:paramdic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *params=[[NSString alloc] initWithData:Datadp encoding:NSUTF8StringEncoding];
        params=[params stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        params=[params stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        params=[params stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        params=[params stringByReplacingOccurrencesOfString:@"\\"  withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        params=[params stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        params=[params stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@" " withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@"\n" withString:@""];
     NSString *aesstr=[SecurityUtil encryptAESData:params passwordKey:[de objectForKey:COOKIE]];
        
        
        NSDictionary *json12=@{@"param":aesstr
                               };
        
        if (_flag==1) {
            urlS= [BassAPI requestUrlWithPorType:PortTypeSavePuOrder];
            
        }else if (_flag==2){
            
            urlS=[BassAPI requestUrlWithPorType:PortTypeOrdersave];
        }else if (_flag==3){
            urlS=[BassAPI requestUrlWithPorType:PortTypeNewSmOrderSaveType];
            
        }
        
        NSString *userstr=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
       
        NSString *bassuser=[GTMBase64 encodeBase64String:userstr];
        [AFManger headerFilePostWithURLString:urlS parameters:json12 Hearfile:bassuser success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            
            Boolean   success=[[obj objectForKey:@"success"] boolValue];
            
            if (success) {
              
                
            }else{
                [Uikility alert:[obj objectForKey:@"msg"]];
                
            }
            
        } failure:^(NSError *error) {
            [Uikility alert:@"提交订单失败！"];
        }];
        
        
    }else{
        
        [Uikility alert:@"请先登录"];
        
    }
    



}
-(void)smxianshangpaysucess:(int)dd{
    NSDictionary *dicsf=[[NSMutableDictionary alloc] init];
    [dicsf setValue:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
    [dicsf setValue:[de objectForKey:@"userId"] forKey:@"userId"];
    if ([de objectForKey:@"newUserId"]) {
        [dicsf setValue:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
    }
    [dicsf setValue:_order forKey:@"orderNo"];
    [dicsf setValue:VERSION forKey:@"ios_version"];
    [dicsf setValue:@1 forKey:@"model"];
   if ([de objectForKey:@"userId"]) {
        
        if (zf==1) {
          //支付宝
            [dicsf setValue:@1 forKey:@"flag"];
            [dicsf setValue:@3 forKey:@"paymentMode"];
       }else if (zf==2){
            [dicsf setValue:@1 forKey:@"flag"];
            [dicsf setValue:@2 forKey:@"paymentMode"];
          
        
        }else if (zf==3){
        //weixinzhifu
            [dicsf setValue:@1 forKey:@"paymentMode"];
            [dicsf setValue:@1 forKey:@"flag"];
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicsf options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
// 去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json};
        if (_flag==2) {
            url=[BassAPI requestUrlWithPorType:PortTypetSorePaySucess];
        }else if (_flag==3){
        
            url=[BassAPI requestUrlWithPorType:PortTypeComePaySucess];
        }
        
              [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
                  id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
                  
                  Boolean success=[[strs objectForKey:@"success"] boolValue];
                  
                  if (success) {
                      //[self json:1];
                      
                      if (_flag==2) {
                          
                          DgViewController *dg=[[DgViewController alloc] init];
                          dg.flag=2;
                          dg.flags=1;
                          dg.indexflag=2;
                          [self.navigationController pushViewController:dg animated:YES];
                          
                          
                      }else if (_flag==3){
                          ShangmenViewController *sm=[[ShangmenViewController alloc] init];
                          sm.flag=3;
                          sm.flags=0;
                          sm.indexflag=2;
                          
                          [self.navigationController pushViewController:sm animated:YES];
                      }
                      
                      
                      
                  }else{
                      [Uikility alert:[strs objectForKey:@"msg"]];            }

              } failure:^(NSError *error) {
                  [Uikility alert:@"数据接受失败！"];
              }];
        }else{
        [Uikility alert:@"请先登录！"];
    }
}

#pragma mark*************线下支付
-(void)zfsuccess{
    
   // NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        NSDictionary *dicsf=[[NSMutableDictionary alloc] init];
         [dicsf setValue:[de objectForKey:@"userId"] forKey:@"userId"];
         [dicsf setValue:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [dicsf setValue:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
         [dicsf setValue:_order forKey:@"orderNo"];
         [dicsf setValue:@1 forKey:@"flag"];
         [dicsf setValue:@1 forKey:@"model"];
        [dicsf setValue:VERSION forKey:@"ios_version"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicsf options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
#pragma mark 去掉空白格和换行符
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
              // [self json:1];
              [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark ********加入订单
-(void)dingdan:(int)dd paymessay:(id )paymessay{
    //获取版本号
    NSString *stversion=VERSION;
    
    if (stversion.doubleValue>2.1) {
        [self generateorders:dd paydata:paymessay];
    }
}

#pragma mark**********新版本的生成订单

-(void)generateorders:(int)dd paydata:(id)paydata{
    
    dictionary=[[NSMutableDictionary alloc] initWithCapacity:0];
    if ([de objectForKey:@"userId"]) {
        NSDictionary *d=nil;
        d=@{@"userId":[de objectForKey:@"userId"]};
     
        NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *d1=@{
                           @"id": addressId
                           };
        NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
       paramarr=[NSMutableArray array];
       for(int j=0;j<_array.count;j++){
            NSArray *aarr=_array[j];
            for ( int z=0;z<aarr.count;z++) {
                CartModel *model=aarr[z];
                NSDictionary *appbrand=@{@"id":model.brandid};
               
                NSString *strbrand=[Uikility initWithdatajsonstring:appbrand];
            appgoodsId=@{    @"id": model.id,
                             @"appbrandId":strbrand
                             };
                NSData *Datad = [NSJSONSerialization dataWithJSONObject:appgoodsId options:NSJSONWritingPrettyPrinted error:nil];
                NSString *appgoods=[[NSString alloc] initWithData:Datad encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@" " withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
                NSString *sa=nil;
                NSMutableArray *muarr=[NSMutableArray array];
                NSArray *array= [de   objectForKey:@"ids"];
                for(NSData *dic in array){
                    CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:dic];
                    [muarr addObject:dmol];
                }
                //优惠券
                NSMutableArray *couponids=[NSMutableArray array];
                NSArray *array1= [de objectForKey:@"ids"];
                for(NSData *dic in array1){
                    CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:dic];
                    NSString *ssid=[NSString stringWithFormat:@"%@",dmol.userVoucherId];
                    [couponids addObject:ssid];
                }
                CGFloat shopprice;
                
                if (_IsCart) {
                    if (model.vipFlag) {
                        shopprice=model.vipPrice.floatValue;
                    }else{
                        shopprice=model.promotionPrice.floatValue;
                    }
                }else{
            shopprice=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
                    
                }
               sa=[NSString stringWithFormat:@"%.1f",shopprice];
                
            NSString *sas=[NSString stringWithFormat:@"%.1ld", (long)model.quantity];
                NSNumber * minas = @([sas integerValue]);
                
                //地址code
                NSNumber *codeid=  [de objectForKey:@"placename"];
                NSDictionary *codedic=@{@"id":codeid};
                NSString *codestr=[Uikility initWithdatajsonstring:codedic];
                
                if (dd==1) {
                  //判断第一个商品 是否满减
                if(j==0){
                    if (z==0) {
                        
                        if(_MJdiccount){
                        //满多少钱减多少钱
                            [dictionary setObject:_MJdiccount forKey:@"manjianVoucherId"];
                        }
                    //优惠券
                if (couponids.count) {
                    NSMutableString *coupstr=[[NSMutableString alloc] init];
                    for(NSString * coupid in couponids){
                        
                        [coupstr appendString:[NSString  stringWithFormat:@"%@,",coupid]];
                    }
                    [dictionary setObject:coupstr forKey:@"userVoucherId"];
                    }
                        //满件券（在第一个商品里面）
            if (_discountIds.count) {
                        NSMutableString *disstr=[[NSMutableString alloc] init];
                        for (DiscountModel *dismodel in _discountIds) {
                            //[disstr stringByAppendingString:[NSString stringWithFormat:@"%@,",dismodel.id]];
                            [disstr appendString:[NSString stringWithFormat:@"%@,",dismodel.id]];
                            
                        }
               
                        [dictionary setObject:disstr forKey:@"shopcartDiscountId"];
                        }
                        
                       
                        //满件折扣
                if(_ZheKouIDs.count){
                        NSMutableString *zkstr=[[NSMutableString alloc] init];
                        for (DiscountModel *zkModel in _ZheKouIDs) {
                            
                       // [zkstr stringByAppendingString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                           
                            [zkstr appendString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                            
                        }
                    
                        [dictionary setObject:zkstr forKey:@"shopcartZhekouId"];
                        }
                        
                        }else{
                            //除了第一个商品以外不用传优惠券
                     [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"shopcartZhekouId"];
                        }
                    }else{
                        [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"shopcartZhekouId"];
                    }
                    
                    [dictionary setObject:orderNo forKey:@"orderNo"];
                    [dictionary setObject:sa forKey:@"money"];
                    [dictionary setObject:@0 forKey:@"client"];
                    [dictionary setObject:jsond forKey:@"appuserId"];
                    [dictionary setObject:jsond1 forKey:@"appaddressId"];
                //  是否是VIP
                    if (_IsCart) {
                        NSNumber *vipflag=[NSNumber numberWithBool:model.vipFlag];
                        [dictionary setObject:vipflag forKey:@"vipFlag"];
                    }else{
                        NSNumber * isVip= [Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                        [dictionary setObject:isVip forKey:@"vipFlag"];
                  }
                    [dictionary setObject:appgoods forKey:@"appgoodsId"];
                    [dictionary setObject:model.attribute  forKey:@"attribute"];
                    [dictionary setObject:codestr forKey:@"appchinaId"];
                   
                    [dictionary setObject:minas forKey:@"quantity"];
                    if (field.text) {
                        [dictionary setObject:field.text forKey:@"remark"];
                        
                    }else{
                        
                        [dictionary setObject:@"1312" forKey:@"remark"];
                    }
                if (self.payType==UGPayObjctTypeALPay) {
                        // 支付宝
                        [dictionary setObject:@3 forKey:@"paymentMode"];
                        [dictionary setObject:@1 forKey:@"flag"];
                        if (_flag!=1) {
                            [dictionary setObject:times forKey:@"timeShop"];
                        }
                    }else if (self.payType==UGPayObjctTypeUPAPay){
                        //银联
                        
                        [dictionary setObject:@2 forKey:@"paymentMode"];
                        [dictionary setObject:@1 forKey:@"flag"];
                        [dictionary setObject:field.text forKey:@"remark"];
                        
                        if (_flag==1) {
                            
                        }else{
                            [dictionary setObject:times forKey:@"timeShop"];
                            
                        }
                        
                    }else if (self.payType==UGPayObjctTypeWX){
                        
                        [dictionary setObject:@1 forKey:@"paymentMode"];
                        [dictionary setObject:@1 forKey:@"flag"];
                        
                        [dictionary setObject:field.text forKey:@"remark"];
                        if (_flag==1) {
                            
                        }else{
                            [dictionary setObject:times forKey:@"timeShop"];
                        }
                        
                    }
                    
                }else if (dd==2){
                    
                    // 判断第一个商品 满减和优惠券
                    if(j==0){
                        if (z==0) {
                if (_MJdiccount) {
                [dictionary setObject:_MJdiccount forKey:@"manjianVoucherId"];
                    }
            NSMutableString *mustr=[[NSMutableString alloc] init];
                    if(couponids.count){
          for(NSString * coupid in couponids){
            [mustr appendString:[NSString stringWithFormat:@"%@,",coupid]];
                                    
                            }

                [dictionary setObject:mustr forKey:@"userVoucherId"];
                                
                            }
                            if (_discountIds.count) {
                                NSMutableString *disstr=[[NSMutableString alloc] init];
                                for (DiscountModel *dismodel in _discountIds) {
                                    [disstr appendString:[NSString stringWithFormat:@"%@,",dismodel.id]];
                                    
                                }
                                [dictionary setObject:disstr forKey:@"shopcartDiscountId"];
                            }
                            //满件折扣
                            if(_ZheKouIDs.count){
                                NSMutableString *zkstr=[[NSMutableString alloc] init];
                                for (DiscountModel *zkModel in _ZheKouIDs) {
                                [zkstr appendString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                                }
                            [dictionary setObject:zkstr forKey:@"shopcartZhekouId"];
                            }
         
                        }else{
                            [dictionary removeObjectForKey:@"shopcartDiscountId"];
                            [dictionary removeObjectForKey:@"manjianVoucherId"];
                            [dictionary removeObjectForKey:@"userVoucherId"];
                            [dictionary removeObjectForKey:@"shopcartZhekouId"];
                        }
                        
                        
                    }else{
                    [dictionary removeObjectForKey:@"shopcartDiscountId"];
                    [dictionary removeObjectForKey:@"manjianVoucherId"];
                    [dictionary removeObjectForKey:@"userVoucherId"];
                    [dictionary removeObjectForKey:@"shopcartZhekouId"];
                    
                    }
                    [dictionary setObject:sa forKey:@"money"];
                    [dictionary setObject:@0 forKey:@"client"];
                    [dictionary setObject:jsond forKey:@"appuserId"];
                    [dictionary setObject:jsond1 forKey:@"appaddressId"];
                    [dictionary setObject:appgoods forKey:@"appgoodsId"];
                    [dictionary setObject:model.attribute forKey:@"attribute"];
                    [dictionary setObject:minas forKey:@"quantity"];
                    [dictionary setObject:codestr forKey:@"appchinaId"];
                    //  是否是VIP
                    if (_IsCart) {
                        NSNumber *vipflag=[NSNumber numberWithBool:model.vipFlag];
                        [dictionary setObject:vipflag forKey:@"vipFlag"];
                    }else{
                        NSNumber * isVip= [Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                        [dictionary setObject:isVip forKey:@"vipFlag"];
                    }

                    
                    if (zf==4) {
                        [dictionary setObject:@0 forKey:@"paymentMode"];
                        [dictionary setObject:@0 forKey:@"flag"];
                        [dictionary setObject:@"123" forKey:@"remark"];
                        [dictionary setObject:times forKey:@"timeShop"];
                        
                    }else{
                        
                        if (self.payType==UGPayObjctTypeALPay) {
                            // 支付宝
                            [dictionary setObject:@3 forKey:@"paymentMode"];
                            [dictionary setObject:@0 forKey:@"flag"];
                            [dictionary setObject:orderNo forKey:@"orderNo"];
                            if (_flag==1) {
                                //@"remark":field.text,
                                if (field.text) {
                                    [dictionary setObject:field.text forKey:@"remark" ];
                                }else{
                                    
                                }
                           }else{
                                [dictionary setObject:@"1312" forKey:@"remark"];
                                [dictionary setObject:times forKey:@"timeShop"];
                            }
                        }else if (self.payType==UGPayObjctTypeUPAPay){
                            
                            [dictionary setObject:@2 forKey:@"paymentMode"];
                            [dictionary setObject:@0 forKey:@"flag"];
                            [dictionary setObject:orderNo forKey:@"orderNo"];
                            [dictionary setObject:field.text forKey:@"remark"];
                            
                            //银联
                            if (_flag==1) {
                            }else{
                                [dictionary setObject:times forKey:@"timeShop"];
                            }
                            
                        }else if (self.payType==UGPayObjctTypeWX){
                            [dictionary setObject:@1 forKey:@"paymentMode"];
                            [dictionary setObject:@0 forKey:@"flag"];
                            [dictionary setObject:orderNo forKey:@"orderNo"];
                            [dictionary setObject:field.text forKey:@"remark"];
                            if (_flag==1) {
                                
                            }else{
                            [dictionary setObject:times forKey:@"timeShop"];
                                
                            }
                        }
                    }
                }
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
                
                
                NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
                json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
                json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
                json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
                json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                
                
                [paramarr addObject:json];
            }
        }
        
        NSMutableDictionary *parammudic=[[NSMutableDictionary alloc] init];
        
        [parammudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
         [parammudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
            [parammudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
         [parammudic setObject:@1 forKey:@"model"];
         [parammudic setObject:VERSION forKey:@"ios_version"];
        
    if (_flag==1) {
           
        [parammudic setObject:paramarr forKey:@"order"];
        
    }else if (_flag==2){
            
            [parammudic setObject:paramarr forKey:@"yyorder"];
        
            }else if (_flag==3){
                [parammudic setObject:paramarr forKey:@"smorder"];
               
            }
        
        
        NSData *Datadp = [NSJSONSerialization dataWithJSONObject:parammudic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *params=[[NSString alloc] initWithData:Datadp encoding:NSUTF8StringEncoding];
        
        params=[params stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
         params=[params stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        params=[params stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        params=[params stringByReplacingOccurrencesOfString:@"\\"  withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        params=[params stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        params=[params stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@" " withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        
        NSString *aesparams=[SecurityUtil encryptAESData:params passwordKey:[de objectForKey:COOKIE]];
    NSDictionary *json12=@{@"param":aesparams };
        
        if (_flag==1) {
            urlS= [BassAPI requestUrlWithPorType:PortTypeNewOrderSaveType];
            
        }else if (_flag==2){
            
            urlS=[BassAPI requestUrlWithPorType:PortTypeOrdersave];
        }else if (_flag==3){
            urlS=[BassAPI requestUrlWithPorType:PortTypeSaveComecart];
            
        }
        NSString *userstr=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        NSString *bassuser=[GTMBase64 encodeBase64String:userstr];
        
        
        [AFManger headerFilePostWithURLString:urlS parameters:json12 Hearfile:bassuser success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
          
            Boolean   success=[[obj objectForKey:@"success"] boolValue];
            
            if (success) {
                //[Pingpp setDebugMode:YES];
//                [Pingpp createPayment:jsons
//                       viewController:self
//                         appURLScheme:@"wx632d6c8a00776b9d"
//                       withCompletion:^(NSString *result, PingppError *error) {
//                           _jumpbool=YES;
//                           if ([result isEqualToString:@"success"]) {
//                               if (_pagenumer==1) {
//                                   [self zfsuccess];
//
//                               }else {
//
//                                   v2.alpha=0;
//                                   UIAlertView *altview=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已生成订单是否分享优惠券" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享", nil];
//                                   altview.tag=2;
//                                   [altview show];
//
//                               }
//
//
//                           } else {
//
//
//                           }
//                       }];
                
                
                
                [SVProgressHUD dismiss];
                [UGPayManger creatPayMent:paydata viewController:self payType:self.payType payCompletion:^(NSString *result) {
                    //NSLog(@"支付宝支付成功");
                    _jumpbool=YES;
                   
                        if (_pagenumer==1) {
                            [self zfsuccess];
                    }else {
                     v2.alpha=0;
                    UIAlertView *altview=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已生成订单是否分享优惠券" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享", nil];
                        altview.tag=2;
                    [altview show];
                    
                }
                }];
                
            }else{
           
                [SVProgressHUD showErrorWithStatus:[obj objectForKey:@"msg"]];
                [SVProgressHUD dismiss];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"当前网速不佳"];
            [SVProgressHUD dismiss];
        }];
    }else{
    [Uikility alert:@"请先登录"];
        
    }
    


}
#pragma mark************上门 到店保存订单
-(void)smdingdan:(int)dd payData:(id)payData{

    dictionary=[[NSMutableDictionary alloc] initWithCapacity:0];
    if ([de objectForKey:@"userId"]) {
        NSDictionary *d=nil;
        
        if ([de objectForKey:@"newUserId"]) {
            d=@{
                @"userId":[de objectForKey:@"userId"]
                };
        }else{
        
            d=@{
                @"userId":[de objectForKey:@"userId"]
                };
        
        }
        
        
        
        
        NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *d1=@{
                           @"id": addressId
                           
                           };
        NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        
        paramarr=[NSMutableArray array];
        for(int j=0;j<_array.count;j++){
            NSArray *aarr=_array[j];
            for ( int z=0;z<aarr.count;z++) {
                CartModel *model=aarr[z];
                NSDictionary *appbrand=@{@"id":model.brandid};
                
                NSString *strbrand=[Uikility initWithdatajsonstring:appbrand];
                appgoodsId=@{
                             @"id": model.id,
                             @"appbrandId":strbrand
                             };
                NSData *Datad = [NSJSONSerialization dataWithJSONObject:appgoodsId options:NSJSONWritingPrettyPrinted error:nil];
                NSString *appgoods=[[NSString alloc] initWithData:Datad encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@" " withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
                NSDictionary *storedic=@{@"id":model.appStoresId};
                NSData *storeDatad1 = [NSJSONSerialization dataWithJSONObject:storedic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsondstore1=[[NSString alloc] initWithData:storeDatad1 encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                jsondstore1=[jsondstore1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                jsondstore1=[jsondstore1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                jsondstore1=[jsondstore1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSString *sa=nil;
                NSMutableArray *muarr=[NSMutableArray array];
                NSArray *array= [de   objectForKey:@"ids"];
                for(NSData *dic in array){
                    CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:dic];
                    [muarr addObject:dmol];
                }
                
                NSMutableArray *couponids=[NSMutableArray array];
                NSArray *array1= [de   objectForKey:@"ids"];
                for(NSData *dic in array1){
            CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:dic];
                    NSString *ssid=[NSString stringWithFormat:@"%@",dmol.userVoucherId];
                    [couponids addObject:ssid];
                }
                
                CGFloat shopprice;
                
                if (_IsCart) {
                    if (model.vipFlag) {
                        shopprice=model.vipPrice.floatValue;
                    }else{
                        shopprice=model.promotionPrice.floatValue;
                        
                    }
                }else{
                    
                    shopprice=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
                    
                }
         sa=[NSString stringWithFormat:@"%.1f",shopprice];
                
                NSString *sas=[NSString stringWithFormat:@"%.1ld", (long)model.quantity];
                NSNumber * minas = @([sas integerValue]);
                
                //地址code
            NSNumber *codeid=  [de objectForKey:@"placename"];
                NSDictionary *codedic=@{@"id":codeid};
                NSString *codestr=[Uikility initWithdatajsonstring:codedic];
                
                if (dd==1) {
                    //判断第一个商品 是否满减
        if(j==0){
                if (z==0) {
                    
                    if (_MJdiccount) {
                        [dictionary setObject:_MJdiccount forKey:@"manjianVoucherId"];
                    }
                    
                            
                    NSMutableString *mustr=[[NSMutableString alloc] init];
                            if (couponids.count) {
                                
                                for(NSString * coupid in couponids){
                                    [mustr appendString:[NSString stringWithFormat:@"%@,",coupid]];
                                   
                                }
                    [dictionary setObject:mustr forKey:@"userVoucherId"];
                            }
                    
                    if (_discountIds.count) {
                        NSMutableString *disstr=[[NSMutableString alloc] init];
                        for (DiscountModel *dismodel in _discountIds) {
                            
                            
                            [disstr appendString:[NSString stringWithFormat:@"%@,",dismodel.id]];
                            
                        }
                        [dictionary setObject:disstr forKey:@"shopcartDiscountId"];
                    }
                    
                    //满件折扣
                    if(_ZheKouIDs.count){
                        NSMutableString *zkstr=[[NSMutableString alloc] init];
                        for (DiscountModel *zkModel in _ZheKouIDs) {
                            
                            //[zkstr stringByAppendingString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                            [zkstr appendString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                        }
                        
                        
                        [dictionary setObject:zkstr forKey:@"shopcartZhekouId"];
                    }
                    

                        }else{
                    [dictionary removeObjectForKey:@"shopcartDiscountId"];
                    [dictionary removeObjectForKey:@"userVoucherId"];
                    [dictionary removeObjectForKey:@"manjianVoucherId"];
                    [dictionary removeObjectForKey:@"shopcartZhekouId"];
                        }
                    }else{
                        [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                        [dictionary removeObjectForKey:@"shopcartZhekouId"];
                    }
                    //  是否是VIP
                    if (_IsCart) {
                        NSNumber *vipflag=[NSNumber numberWithBool:model.vipFlag];
                        [dictionary setObject:vipflag forKey:@"vipFlag"];
                    }else{
                        NSNumber * isVip= [Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                        [dictionary setObject:isVip forKey:@"vipFlag"];
                    }

                    [dictionary setObject:sa forKey:@"money"];
                    [dictionary setObject:@0 forKey:@"client"];
                    //[dictionary setObject:@"flag" forKey:@1];
                    //[dictionary setObject:@"remark" forKey:@"1312"];
                    [dictionary setObject:jsond forKey:@"appuserId"];
                    [dictionary setObject:jsond1 forKey:@"appaddressId"];
                    [dictionary setObject:appgoods forKey:@"appgoodsId"];
                    [dictionary setObject:model.attribute  forKey:@"attribute"];
                    [dictionary setObject:codestr forKey:@"appchinaId"];
                    [dictionary setObject:minas forKey:@"quantity"];
                    [dictionary setObject:@0 forKey:@"flag"];
                    [dictionary setObject:jsondstore1 forKey:@"appStoresId"];
                    if(zf==1){
                        self.payType=UGPayObjctTypeALPay;
                         [dictionary setObject:@3 forKey:@"paymentMode"];
                    }else if (zf==2){
                        self.payType=UGPayObjctTypeWX;
                         [dictionary setObject:@1 forKey:@"paymentMode"];
                    }
                    if (field.text) {
                        [dictionary setObject:field.text forKey:@"remark"];
                        
                    }else{
                        
                        [dictionary setObject:@"1312" forKey:@"remark"];
                    }
                
                    if (_flag==1) {
                        
                    }else{
                            [dictionary setObject:times forKey:@"timeShop"];
                            
                        }
                    }else if (dd==2){
                    
                    // 判断第一个商品 满减和优惠券
                    if(j==0){
                        if (z==0) {
                            
                            if(_MJdiccount){
                            
                                [dictionary setObject:_MJdiccount forKey:@"manjianVoucherId"];
                            }
                            
                    if(couponids.count){
                                
                          NSMutableString *mustr=[[NSMutableString alloc] init];
                                for(NSString * coupid in couponids){
                                    
                                    [mustr appendString:[NSString stringWithFormat:@"%@,",coupid]];
                                    }
                                
                                [dictionary setObject:mustr forKey:@"userVoucherId"];
                            }
                            if(_discountIds.count){
                                NSMutableString *disstr=[[NSMutableString alloc] init];
                                for (DiscountModel *dismodel in _discountIds) {
                                    [disstr appendFormat:@"%@",dismodel.id];
                                }
                                [dictionary setObject:disstr forKey:@"shopcartDiscountId"];
                            
                            }
                            //满件折扣
                            if(_ZheKouIDs.count){
                                NSMutableString *zkstr=[[NSMutableString alloc] init];
                                for (DiscountModel *zkModel in _ZheKouIDs) {
                                    
                                    //[zkstr stringByAppendingString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                                    [zkstr appendString:[NSString stringWithFormat:@"%@,",zkModel.id]];
                                }
                                
                                
                                [dictionary setObject:zkstr forKey:@"shopcartZhekouId"];
                            }

                            
                        }else{
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        [dictionary removeObjectForKey:@"shopcartZhekouId"];
                        }
                        
                        
                    }else{
                        [dictionary removeObjectForKey:@"manjianVoucherId"];
                        [dictionary removeObjectForKey:@"userVoucherId"];
                        [dictionary removeObjectForKey:@"shopcartDiscountId"];
                        [dictionary removeObjectForKey:@"shopcartZhekouId"];
                        
                    }
                    [dictionary setObject:sa forKey:@"money"];
                    [dictionary setObject:@0 forKey:@"client"];
                    [dictionary setObject:jsond forKey:@"appuserId"];
                    [dictionary setObject:jsond1 forKey:@"appaddressId"];
                    [dictionary setObject:appgoods forKey:@"appgoodsId"];
                    [dictionary setObject:model.attribute forKey:@"attribute"];
                    [dictionary setObject:minas forKey:@"quantity"];
                    [dictionary setObject:codestr forKey:@"appchinaId"];

                        if(zf==1){
                            self.payType=UGPayObjctTypeALPay;
                            [dictionary setObject:@3 forKey:@"paymentMode"];
                        }else if (zf==2){
                            self.payType=UGPayObjctTypeWX;
                            [dictionary setObject:@1 forKey:@"paymentMode"];
                        }
                    [dictionary setObject:@0 forKey:@"flag"];
                        [dictionary setObject:@"123" forKey:@"remark"];
                        [dictionary setObject:times forKey:@"timeShop"];
                    [dictionary setObject:jsondstore1 forKey:@"appStoresId"];
                    if (_IsCart) {
                        NSNumber *vipflag=[NSNumber numberWithBool:model.vipFlag];
                        [dictionary setObject:vipflag forKey:@"vipFlag"];
                    }else{
                        NSNumber * isVip= [Uikility ifVIPmemberPprice:model.promotionPrice VIPnumber:model.vipPrice];
                        [dictionary setObject:isVip forKey:@"vipFlag"];
                    }
                    }else{
                        
                        
                }
                
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
                NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
                json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
                json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
                json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
                json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                [paramarr addObject:json];
            }
        }
        NSMutableDictionary *paramsmdic=[[NSMutableDictionary alloc] init];
        [paramsmdic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [paramsmdic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
            [paramsmdic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        [paramsmdic setObject:@1 forKey:@"model"];
        [paramsmdic setObject:VERSION forKey:@"ios_version"];
      
        
     if (_flag==2){
         [paramsmdic setObject:paramarr forKey:@"yyorder"];
            }else if (_flag==3){
                [paramsmdic setObject:paramarr forKey:@"smorder"];
            
            }
        NSData *Datadp = [NSJSONSerialization dataWithJSONObject:paramsmdic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *params=[[NSString alloc] initWithData:Datadp encoding:NSUTF8StringEncoding];
        
        params=[params stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        params=[params stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        params=[params stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        params=[params stringByReplacingOccurrencesOfString:@"\\"  withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        params=[params stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        params=[params stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@" " withString:@""];
        params=[params stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *aesstr=[SecurityUtil encryptAESData:params passwordKey:[de objectForKey:COOKIE]];
        NSDictionary *json12=@{@"param":aesstr};
      
        if (_flag==1) {
            urlS= [BassAPI requestUrlWithPorType:PortTypeSavePuOrder];
            
        }else if (_flag==2){
            
            urlS=[BassAPI requestUrlWithPorType:PortTypeNewYyOrderSaveType];
        }else if (_flag==3){
            urlS=[BassAPI requestUrlWithPorType:PortTypeNewSmOrderSaveType];
            
        }
        
        NSString *userstr=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
      NSString *bassuser=[GTMBase64 encodeBase64String:userstr];
        [SVProgressHUD showWithStatus:@"正在发起支付"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [AFManger headerFilePostWithURLString:urlS parameters:json12 Hearfile:bassuser success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            Boolean   success=[[obj objectForKey:@"success"] boolValue];
            
            if (success) {
                NSArray *orderNoArr=[obj objectForKey:@"data"];
                //发起支付
                [self smOrderPay:orderNoArr];
                
            }else{
                [SVProgressHUD showErrorWithStatus:[obj objectForKey:@"msg"]];
                [SVProgressHUD dismissWithDelay:1.5];
            }

        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"当前网速不佳"];
            [SVProgressHUD dismissWithDelay:1.5];
        }];
        
        
    }else{
        
        [Uikility alert:@"请先登录"];
        
    }



}
#pragma mark********上门 到店 线上支付
-(void)smOrderPay:(NSArray *)orderNos{
    if ([de objectForKey:@"userId"]) {
       // NSString *allprice=[NSString stringWithFormat:@"%.1f",_allprice];
        //NSNumber * min = @([allprice integerValue]);
        NSNumber *pricenum=[[NSNumber alloc] initWithFloat:_allprice];
        NSMutableDictionary *pingDic=[[NSMutableDictionary alloc] init];
        [pingDic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [pingDic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [pingDic setObject:@"苹果" forKey:@"subjectVal"];
        [pingDic setObject:@"u购" forKey:@"bodyVal"];
        [pingDic setObject:@true forKey:@"model"];
        [pingDic setObject:VERSION forKey:@"ios_version"];
        [pingDic setObject:pricenum forKey:@"summary"];
        [pingDic setObject:orderNos forKey:@"orderNoArr"];
       if(_orderNo==nil){
            [Uikility alert:@"当前网速较慢请重试"];
        }else{
            [pingDic setObject:_orderNo forKey:@"orderNo"];
            
        }
        NSString *urlstr=nil;
        if (zf==1) {
            [pingDic setObject:@"alipay" forKey:@"channelVal"];
            self.payType=UGPayObjctTypeALPay;
            urlstr=[BassAPI requestUrlWithPorType:portTypeGetUGPayALiPay];
            if (_flag==1) {
                
                [pingDic setObject:@1 forKey:@"appOrderType"];
            }else if(_flag==2){
                
                [pingDic setObject:@2 forKey:@"appOrderType"];
            }else if (_flag==3){
                
                
                [pingDic setObject:@3 forKey:@"appOrderType"];
                
                
            }
        }else if (zf==2){
//            self.payType=UGPayObjctTypeUPAPay;
//            urlstr=[BassAPI requestUrlWithPorType:portTypeGetTransReqUGPayYinL];
//            [pingDic setObject:@"upacp" forKey:@"channelVal"];
//            if(_flag==1){
//                [pingDic setObject:@1 forKey:@"appOrderType"];
//
//            }else if (_flag==2){
//                [pingDic setObject:@2 forKey:@"appOrderType"];
//            }
//            else if (_flag==3){
//
//
//                [pingDic setObject:@3 forKey:@"appOrderType"];
//            }
            
            self.payType=UGPayObjctTypeWX;
            urlstr=[BassAPI requestUrlWithPorType:portTypeGetUGPayWChatPay];
            [pingDic setObject:@"wx" forKey:@"channelVal"];
            if (_flag==1) {
                
                [pingDic setObject:@1 forKey:@"appOrderType"];
            }else if (_flag==2){
                
                [pingDic setObject:@2 forKey:@"appOrderType"];
            }else if (_flag==3){
                
                [pingDic setObject:@3 forKey:@"appOrderType"];
            }
        }else if (zf==3){
            self.payType=UGPayObjctTypeWX;
            urlstr=[BassAPI requestUrlWithPorType:portTypeGetUGPayWChatPay];
            [pingDic setObject:@"wx" forKey:@"channelVal"];
            if (_flag==1) {
                
                [pingDic setObject:@1 forKey:@"appOrderType"];
            }else if (_flag==2){
                
                [pingDic setObject:@2 forKey:@"appOrderType"];
            }else if (_flag==3){
                
                [pingDic setObject:@3 forKey:@"appOrderType"];
            }
            
            
        }
        
        NSString *jsonstr=[Uikility initWithdatajsonstring:pingDic];
        NSString *asestr=[SecurityUtil encryptAESData:jsonstr passwordKey:[de objectForKey:COOKIE]];
        
        NSDictionary*  json1=@{@"param":asestr};
        //NSString *urls=[BassAPI requestUrlWithPorType:portTypeGetTransReqUGPayYinL];
        NSString * userid=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        
        NSString *bassuser=[GTMBase64 encodeBase64String:userid];
        [AFManger headerFilePostWithURLString:urlstr parameters:json1 Hearfile:bassuser success:^(id responseObject) {
            [SVProgressHUD dismiss];
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            Boolean success=[[obj objectForKey:@"success"] boolValue];
            
            if (success) {
              
                
                
//                [Pingpp createPayment:jsons
//                       viewController:self
//                         appURLScheme:@"wx632d6c8a00776b9d"
//                       withCompletion:^(NSString *result, PingppError *error) {
//                           //_jumpbool=YES;
//                           if ([result isEqualToString:@"success"]) {
//                               if (_pagenumer==1) {
//                                   [self zfsuccess];
//
//                               }else {
//
//                                   v2.alpha=0;
//                                   UIAlertView *altview=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已生成订单是否分享优惠券" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享", nil];
//                                   altview.tag=2;
//                                   [altview show];
//
//                               }
//
//                           } else {
//
//
//                           }
//
//                }];
                [UGPayManger creatPayMent:obj viewController:self payType:self.payType payCompletion:^(NSString *result) {
                    if (_pagenumer==1) {
                        [self zfsuccess];
                        
                            }else {
                    v2.alpha=0;
                    UIAlertView *altview=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已生成订单是否分享优惠券" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享", nil];
                            altview.tag=2;
                            [altview show];
                        
                    }
                }];
                
                
            }else{
                [SVProgressHUD  showErrorWithStatus:[obj objectForKey:@"msg"]];
                [SVProgressHUD dismissWithDelay:1.5];
            }
            
            
        } failure:^(NSError *error) {
            [SVProgressHUD  showErrorWithStatus:@"当前网速不佳"];
            [SVProgressHUD dismissWithDelay:1.5];
        }];
        
    }else{
        //登录
        [Uikility alert:@"请先登录！"];
        return;
        
    }



}
#pragma mark**********分享界面弹出
-(void)creatshareview{
    
    _shareview=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //返回
    _shareview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popview1)];
    [_shareview addGestureRecognizer:tap];
 UIView *   shareviews2=[[UIView alloc]initWithFrame:CGRectMake(0*KIphoneWH, HEIGHT/3, WIDTH,  HEIGHT-HEIGHT/3)];
   shareviews2 .backgroundColor=[UIColor whiteColor];
    [_shareview addSubview:shareviews2];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-10*KIphoneWH, 30*KIphoneWH)];
    lable.text=@"分享优惠券到";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:20*KIphoneWH];
   //iamgearray=@[@"sns_icon_23@3x.png",@"common_icon_weibo@3x.png",@"common_icon_wechat@2x.png"];
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
    iamgearray=@[@"umsocial_wechat_timeline",@"umsocial_sina.png",@"umsocial_wechat.png"];

    }else{
    iamgearray=@[@"umsocial_sina.png"];

    }
    UIButton *cancebt=[[UIButton alloc] initWithFrame:CGRectMake(10*KIphoneWH, HEIGHT/3*2-35*KIphoneWH, WIDTH-30*KIphoneWH, 30*KIphoneWH)];
    [cancebt addTarget:self action:@selector(cancebt) forControlEvents:UIControlEventTouchUpInside];
    cancebt.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [cancebt setTitle:@"取消" forState:UIControlStateNormal];
  
    [cancebt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancebt.titleLabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
    
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {

        titler=@[@"微信朋友圈",@"新浪微博",@"微信好友"];
    }else{
      titler=@[@"新浪微博"];
    }
    for(int i=0;i<titler.count;i++){
        
        UIButton *button2=[[UIButton alloc] initWithFrame:CGRectMake((WIDTH-20*KIphoneWH)/3*i+5*KIphoneWH, 40*KIphoneWH, 100*KIphoneWH, 100*KIphoneWH)];
        [button2 setImage:[UIImage imageNamed:THEMEShareSrcName(iamgearray[i])] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(sharewxmessage:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag=10000+i;
        UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake((WIDTH-20*KIphoneWH)/3*i+5*KIphoneWH, 140*KIphoneWH, 100*KIphoneWH, 30*KIphoneWH)];
        lable1.text=titler[i];
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.font=[UIFont systemFontOfSize:16*KIphoneWH];
        [shareviews2 addSubview:button2];
        [shareviews2 addSubview:lable1];
    
    }
    
    
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        //zfarr=@[@"支付宝支付",@"银联",@"微信支付"];
        }else{
            
            
            UIButton *bt1=(id)[self.view viewWithTag:10000];
            bt1.alpha=0;
            UIButton *bt2=(id)[self.view viewWithTag:10002];
            bt2.alpha=0;
            
        }
    
    
    
    
    
    [shareviews2 addSubview:cancebt];
    
    [shareviews2 addSubview:lable];
    [self.view addSubview:_shareview];
    //[self  getShareImage];
}
-(void)cancebt{
    
    
    _shareview.alpha=0;
    if (_flag==1) {
        DgViewController *dg=[[DgViewController alloc] init];
        dg.flag=1;
        dg.flags=1;
        dg.indexflag=2;
        [self.navigationController pushViewController:dg animated:YES];
        
    }else if (_flag==2){
        DgViewController *dg=[[DgViewController alloc] init];
        dg.flag=2;
        dg.flags=1;
        dg.indexflag=2;
        [self.navigationController pushViewController:dg animated:YES];
    }else if (_flag==3){
        ShangmenViewController *sm=[[ShangmenViewController alloc] init];
        sm.flag=3;
        sm.flags=1;
        sm.indexflag=2;
        [self.navigationController pushViewController:sm animated:YES];
        
    }


}
-(void)getShareImage{

    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeGetShare];
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    NSDictionary *postdic=[Uikility initWithdatajson:dic];
    [AFManger postWithURLString:urlstr parameters:postdic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        Boolean sucess=[[object objectForKey:@"success"]boolValue];
        
        if (sucess) {
            NSDictionary *datadic=[object objectForKey:@"data"];
            shareURL =[datadic objectForKey:@"imgUrl"];
       NSString *  ImageUrl=[datadic objectForKey:@"img"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                shareImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self creatshareview];
                    //[self.navigationController popToRootViewControllerAnimated:YES];
                });
                //[self creatshareview];
            });
        }else{
           
        }
        
        
    } failure:^(NSError *error) {
       
    }];

}

#pragma mark*******分享按钮点击
-(void)sharewxmessage:(UIButton *)b{
    //NSString *urlstr=[BassAPI requestUrlWithPorType: PortTypeShareGenera];
    NSString *urlstr=@"http://ugouchina.com//ugouApp/yhq.html";
    if (shareURL!=nil) {
        urlstr=shareURL;
    }
    Uikility *ukit=[[Uikility alloc] init];
    if (titler.count==1) {
        if (shareImageData==nil) {
            NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
            NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",urlstr];
            [ukit shareWbsinaWithimage:data title:urls description:
             @"领取U购优惠券" url:nil];
        }else{
        
        
            NSData *data=  shareImageData;
            NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",shareURL];
            [ukit shareWbsinaWithimage:data title:urls description:
             @"领取U购优惠券" url:nil];
        }
        
       

    }else{
    if (b.tag==10000) {
        if (shareImageData==nil) {
           NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
           UIImage *image=[UIImage imageNamed:@"uuu.png"];
       
           [ukit shareWithWexintext:@"领取U购优惠券，可返现金" Withurl:urlstr title:@"U购优惠券" imagedata:data uiiamge:image];
        }else{
            NSData *data= shareImageData;
            UIImage *image=[UIImage imageWithData:data];
           
            [ukit shareWithWexintext:@"领取U购优惠券，可返现金" Withurl:shareURL title:@"U购优惠券" imagedata:data uiiamge:image];
        
        }
    }else if(b.tag==10002){
        if (shareImageData==nil) {
            NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
            //[ukit shareWithWXfrendtext:nil Withurl:urlstr title:@"领取U购优惠券" imagedata];
            UIImage *image=[UIImage imageNamed:@"uuu.png"];
            [ukit shareWithWXfrendtext:@"领取U购优惠券，可返现金" Withurl:urlstr title:@"U购优惠券" imagedata:data uiiamge:image];
        }else{
            NSData *data=shareImageData;
            UIImage *image=[UIImage imageWithData:data];
            [ukit shareWithWXfrendtext:@"领取U购优惠券，可返现金" Withurl:shareURL title:@"U购优惠券" imagedata:data uiiamge:image];
        
        }

    }else {
        if (shareImageData==nil) {
            NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
            NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",urlstr];
            [ukit shareWbsinaWithimage:data title:urls description:
             @"领取U购优惠券" url:nil];
        }else{
            NSData *data=shareImageData;
            NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",shareURL];
            [ukit shareWbsinaWithimage:data title:urls description:
             @"领取U购优惠券" url:nil];
        }
        
        
    }
    }

}
-(void)popview1{
    _shareview.alpha=0;
    if (_flag==1) {
        DgViewController *dg=[[DgViewController alloc] init];
        dg.flag=1;
        dg.flags=1;
        dg.indexflag=2;
        [self.navigationController pushViewController:dg animated:YES];
        
    }else if (_flag==2){
        DgViewController *dg=[[DgViewController alloc] init];
        dg.flag=2;
        dg.flags=1;
        dg.indexflag=2;
        [self.navigationController pushViewController:dg animated:YES];
    }else if (_flag==3){
        ShangmenViewController *sm=[[ShangmenViewController alloc] init];
        sm.flag=3;
        sm.flags=1;
        sm.indexflag=2;
        [self.navigationController pushViewController:sm animated:YES];
        
    }


}
#pragma mark *************返回 确认订单界面
-(void)popv1{
    
    if (_jumpbool==NO) {
    
        if(_oredercheart!=nil){
         //[self queryorder];
        
        }else{
         v2.alpha=0;
        
        }
        
       
    }else{
        //[self queryorder];
        v2.alpha=0;
    
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
