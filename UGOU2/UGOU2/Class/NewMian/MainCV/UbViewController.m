//
//  UbViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/20.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import "UbViewController.h"
#import "AFManger.h"
#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"
#import "MainCollectionViewCell.h"
#import "MJRefresh.h"
#import "ReusableView.h"
#import "BassAPI.h"
#import "PlaceViewController.h"
#import "AdressViewController.h"
@interface UbViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UITableView *table;
    UIView *headview;
    UILabel *label;
    NSString *url;
    NSUserDefaults *de;
    NSString *rewards;
    int U;
    NSMutableArray *muarr;
    NSDictionary *diction;
    NSInteger  gestag;
    UIAlertView *shview1;
    UIAlertView *shview2;
    UICollectionView *_collectionview;
    int hang;
}
@end

@implementation UbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //self.navigationController.navigationBar.translucent=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    //self.navigationController.na
    muarr=[NSMutableArray array];
#pragma mark U币商城
    [self addtable];
    //hang=1;
    //[self json:1];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    hang=1;
    self.tabBarController.tabBar.hidden=YES;
    //self.navigationController.navigationBar.hidden=YES;
    de=[NSUserDefaults standardUserDefaults];
    [self json:1];
//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
#pragma mark 返回
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 头部
-(void)addheadview{
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,300*KIphoneWH)];
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 300*KIphoneWH)];
    imv.image=[UIImage imageNamed:@"U币商城"];
    imv.userInteractionEnabled=YES;
    [headview addSubview:imv];
    UIButton *b1=[[UIButton alloc]initWithFrame:CGRectMake(5*KIphoneWH, 22*KIphoneWH, 70*KIphoneWH, 30*KIphoneWH)];
    [b1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b1 setTitle:@"关闭" forState:UIControlStateNormal];
    [imv addSubview:b1];
    // b1.tag=1;
    UILabel *placeLable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-80*KIphoneWH, 22*KIphoneWH, 70*KIphoneWH, 30*KIphoneWH)];
    placeLable.text=[de objectForKey:@"district"];
    placeLable.textColor=[UIColor whiteColor];
    [imv addSubview:placeLable];
    
    [b1 addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UILabel * titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-60*KIphoneWH, 15*KIphoneWH, 120*KIphoneWH, 50*KIphoneWH)];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"U币商城";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [imv addSubview:titlelabel];

   label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH, 85*KIphoneWH, 100*KIphoneWH, 60*KIphoneWH)];
  
    label.text=@"0";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:24*KIphoneWH];
    [imv addSubview:label];
    UILabel *labelsp=[[UILabel alloc]initWithFrame:CGRectMake(20*KIphoneWH, 230*KIphoneWH, WIDTH-40*KIphoneWH, 40*KIphoneWH)];
    labelsp.text=@"------ 实用好礼品 ------";
    labelsp.font=[UIFont systemFontOfSize:21*KIphoneWH];
    labelsp.textAlignment=NSTextAlignmentCenter;
    labelsp.textColor=[UIColor colorWithRed:231/255.0 green:92/255.0 blue:100/255.0 alpha:1];
    [imv addSubview:labelsp];
    if (iPhoneX) {
        headview.frame=CGRectMake(0, 0, WIDTH,300*KIphoneWH);
        headview.backgroundColor=[UIColor colorWithRed:109/255.0 green:164/255.0 blue:22/255.0 alpha:1];
        imv.frame=CGRectMake(0, 44, WIDTH, 300*KIphoneWH);
        //b1.frame=CGRectMake(5*KIphoneWH, 22*KIphoneWH+24, 70*KIphoneWH, 30*KIphoneWH);
        labelsp.frame=CGRectMake(20*KIphoneWH, 230*KIphoneWH-44, WIDTH-40*KIphoneWH, 40*KIphoneWH);
    }
    #pragma mark U币
    [self json:2];
}
#pragma mark tableview
-(void)addtable{
    
    
    //self.automaticallyAdjustsScrollViewInsets=YES;
    _collectionview.contentInset=UIEdgeInsetsMake(0,0, WIDTH,HEIGHT);
    
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)  collectionViewLayout:flowlayout];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor colorWithRed:151/255.0 green:217/255.0 blue:133/255.0 alpha:1];
    //_collectionview.backgroundColor=[UIColor colorWithRed:109/255.0 green:164/255.0 blue:22/255.0 alpha:1];
    [self.view addSubview:_collectionview];
   
    [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];
    [_collectionview registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
//    if (iPhoneX) {
//        _collectionview.frame=CGRectMake(0, 24, WIDTH, HEIGHT-24);
//    }
    _collectionview.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        hang++;
        [self json:1];
        [_collectionview.footer endRefreshing];
    }];
}
#pragma mark 个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (muarr.count) {
        return muarr.count;
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{


    
    return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(WIDTH, 300*KIphoneWH);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
}
//2015.10.19.3.50
#pragma mark 具体内容
-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCollectionViewCell *cell=[collectionView  dequeueReusableCellWithReuseIdentifier:@"qqq" forIndexPath:indexPath];
    if (muarr.count) {
        
        
        [cell.imageview sd_setImageWithURL:[Uikility URLWithString:[[muarr objectAtIndex:indexPath.row]objectForKey:@"image"]]placeholderImage:[UIImage imageNamed:@"uuu"]];
        
        cell.textlable.text=[[muarr objectAtIndex:indexPath.row]objectForKey:@"name"];
        NSString *s=[[muarr objectAtIndex:indexPath.row]objectForKey:@"integral"];
        cell.Uprice.text=[NSString stringWithFormat:@"%@",s];
        cell.Uprice.frame=CGRectMake(30*KIphoneWH, 230*KIphoneWH, 100*KIphoneWH, 25*KIphoneWH);
        cell.imv.frame=CGRectMake(5*KIphoneWH, 235*KIphoneWH,20*KIphoneWH, 20*KIphoneWH);
        cell.imv.image=[UIImage imageNamed:@"Coin-拷贝@2x"];
       
        
        
    }
    return cell;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString * headerID = @"header";
    //collectionView通过复用标志到相应的复用池去找空闲的ReusableView，有就直接用，没有就创建
    ReusableView *regestview = [_collectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
    [self addheadview];
    [regestview.view addSubview:headview];
    
    return regestview;
    
}
#pragma mark 点击tableview
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    gestag=indexPath.row;
#pragma mark 兑换商品
    //[self json:3];
    [self dzhi];
}

-(void)postMethod{
    
    if ([de objectForKey:@"userId"]) {
        NSString *urls=[BassAPI requestUrlWithPorType:PortTypegetAddressList];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        [dic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [dic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if([de objectForKey:@"newUserId"]){
            [dic setObject:[de objectForKey:@"newUserId" ] forKey:@"newUserId"];
        
        }
        if([de objectForKey:@"placename"]){
            [dic setObject:[de objectForKey:@"placename"] forKey:@"area"];
        
        
        }
        
        [dic setObject:@1 forKey:@"model"];
         [dic setObject:VERSION forKey:@"ios_version"];
        NSDictionary *json2=[Uikility initWithdatajson:dic];
//        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        [AFManger postWithURLString:urls parameters:json2 success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[obj objectForKey:@"success"] boolValue];
            
            if (success) {
                
                PlaceViewController *place=[[PlaceViewController alloc]init];
                place.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:place animated:YES];
                
                
            }else{
               
                AdressViewController *ad=[[AdressViewController alloc]init];
                ad.flage=1;
                ad.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:ad animated:YES];
            
            }

            
            
        } failure:^(NSError *error) {
            
        }];
    
    }else{
      //  [Uikility alert:@"请先登录！"];
    }
    
}


#pragma mark 弹出框

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //根据被点击按钮的索引处理点击事件,buttonIndex表示被点击的按钮的下标，默认cancel是0
    
    if (alertView==shview1) {
        if (buttonIndex==0) {
           [self postMethod];
        }else if (buttonIndex==1){
            
           //继续
            [self Forgoods];
        }

    }else{
    if (buttonIndex==0) {
        return;
    }else if (buttonIndex==1){
        
        [self postMethod];
        
    }
    }
}
-(void)dzhi{
    if ([de objectForKey:@"addressId"]) {
        shview1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否用默认地址？购买" delegate:self cancelButtonTitle:@"更改默认地址" otherButtonTitles:@"兑换", nil];
        [shview1 show];
    
    
    }else{
    
    shview2=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择收货地址！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [shview2 show];
    }
    
    
    
}


#pragma mark 数据

-(void)Forgoods{
    if ([de objectForKey:@"userId"]) {
        
        NSDictionary *d=nil;
        if ([de objectForKey:@"newUserId"]) {
        d=@{@"userId":[de objectForKey:@"userId"]
                              };
        }else{
            d=@{@"userId":[de objectForKey:@"userId"]
                              };
        }
        
                NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
                jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
                NSString *addressId=[de objectForKey:@"addressId"];
        
                NSNumber * mins = @([addressId integerValue]);
        
                NSDictionary *d1=@{
                                   @"id": mins
    
                                   };
                NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
                NSString *ids=[[muarr objectAtIndex:gestag]objectForKey:@"id"];
                NSNumber *goodids = @([ids integerValue]);
                 //NSString *intergral=[[muarr objectAtIndex:gestag]objectForKey:@"name"];
                NSString *attribute=[NSString stringWithFormat:@"这是%@",[[muarr objectAtIndex:gestag]objectForKey:@"name"]];
                NSDictionary *appgoodsId=@{
                                           @"id": goodids,
                                           @"attribute":attribute
                                           };
    
                NSData *Datad = [NSJSONSerialization dataWithJSONObject:appgoodsId options:NSJSONWritingPrettyPrinted error:nil];
                NSString *appgoods=[[NSString alloc] initWithData:Datad encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@" " withString:@""];
                appgoods=[appgoods stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
        
         [dictionary setObject:jsond forKey:@"appuserId"];
         [dictionary setObject:appgoods forKey:@"appushopId"];
         [dictionary setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
         [dictionary setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [dictionary setObject:jsond1 forKey:@"appaddressId"];
        if ([de objectForKey:@"newUserId"]) {
            [dictionary setObject:[de objectForKey:@"newUserId" ] forKey:@"newUserId"];
        }
        [dictionary setObject:goodids forKey:@"ushopId"];
        [dictionary setObject:@true forKey:@"model"];
        [dictionary setObject:VERSION forKey:@"ios_version"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
                NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                //去掉空白格和换行符
                json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
                json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
                json=[json stringByReplacingOccurrencesOfString:@"attribute\\" withString:@"attribute"];
                json=[json stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
                json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
                json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
                json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
               
               
                diction=@{@"param":json
                                       };
        
        
            
        url=[BassAPI requestUrlWithPorType:PortTypeForgoods];
    [AFManger postWithURLString:url parameters:diction success:^(id responseObject) {
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[strs objectForKey:@"success"] boolValue];
        
        if (success) {
            
            [Uikility alert:@"兑换成功！"];
            [self json:2];
            
            
        }else{
            
            
            [Uikility alert:[strs objectForKey:@"msg"]];
        }

        
    } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
    }];
    }else{
    [Uikility alert: @"请先登录！"];
    }


}


-(void)json:(int )qd{
    
    if ([de objectForKey:@"userId"]) {
        NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
        [dics setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [dics setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if([de objectForKey:@"newUserId"]){
        
        [dics setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        
        }
        if ([de objectForKey:@"placename"]) {
            [dics setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
        
        [dics setObject:@1 forKey:@"model"];
        [dics setObject:VERSION forKey:@"ios_version"];
       
            
        
            diction= [Uikility initWithdatajson:dics];
            if (qd==1) {
                
               
                
                url=[BassAPI requestUrlWithPorType:PortTypeQuerymall];
            
            }else if (qd==2){
                url=[BassAPI requestUrlWithPorType:PortTypeUcoin];
                
                
            }
       // }
//        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        [AFManger postWithURLString:url parameters:diction success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            // NSString *msg=[strs objectForKey:@"msg"];
            if (success) {
                if (qd==1) {
                    muarr=[strs objectForKey:@"data"];
                    [_collectionview reloadData];
                    
                }else if (qd==2){
                    
                    rewards=[NSString stringWithFormat:@"%@",[[strs objectForKey:@"data"]objectForKey:@"rewards"]];
                    // U=1;
                    if ([[strs objectForKey:@"data"]objectForKey:@"rewards"]) {
                        label.text=rewards;
                    }else{
                        label.text=@"0";
                        
                    }
                    
                                   }
            }else{
                
                
                [Uikility alert:[strs objectForKey:@"msg"]];
            }

            
            
        } failure:^(NSError *error) {
            [Uikility alert:@"数据接受失败！"];
        }];
        }else{
        [Uikility alert: @"请先登录！"];
        
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
