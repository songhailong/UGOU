//
//  BrandViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
/*xujing2015.11.4.9.24 品牌
*/
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "SearchViewController.h"
#import "TheBrandTableViewCell.h"
#import "BrandViewController.h"
#import "PpViewController.h"
#import "AFManger.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"
#import "TwobrandTableViewCell.h"
#import "BassAPI.h"
#import "LocateFailureView.h"
#import "UGHeader.h"
@interface BrandViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    UIView *headview;
    UIView *footview;
    UITableView *table;
    NSDictionary *d;
   
    NSMutableArray *recommend;
    NSMutableArray * appBrandAll;
    NSMutableDictionary *_datadic;
    int n;
    MBProgressHUD *hud;
    BOOL scy;
    
    LocateFailureView *_locatfailureView;
}
@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //[self addnavigation];
    recommend=[NSMutableArray array];
    appBrandAll=[NSMutableArray array];
    n=0;
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [self addnavigation];
    if ([de objectForKey:@"placename"]) {
        _locatfailureView.alpha=0;
        [self json];
    }else{
        [self creatfailView];
    
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSucess:) name:@"locationSucess" object:nil];

    

}
-(void)locationSucess:(NSNotification *)noti{
    _locatfailureView.alpha=0;
    [self  json];
    
}
-(void)creatfailView{
    _locatfailureView=[[LocateFailureView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40)];
    [self.view addSubview:_locatfailureView];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.translucent=NO;
     self.navigationController.navigationBar.hidden = YES;
    //[self addnavigation];
    //recommend=[NSMutableArray array];
    //appBrandAll=[NSMutableArray array];
    //n=0;
    //[self json];
}

    #pragma mark 导航栏
-(void)addnavigation{
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
     custemNav.title=@"品牌";
    [self.view addSubview:custemNav];
}

#pragma mark头 尾 视图 行高度

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
        return 40*KIphoneWH;
}

#pragma mark 头视图 标题
-(UIView *)addview:(int)i{
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50*KIphoneWH)];
    headview.backgroundColor=[UIColor whiteColor];
    [table addSubview:headview];
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10*KIphoneWH, 40*KIphoneWH)];
    imv.image=[UIImage imageNamed:@"矩形-3@2x"];
    [headview addSubview:imv];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15*KIphoneWH, 5*KIphoneWH, 100*KIphoneWH, 40*KIphoneWH)];
    label.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    label.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [headview addSubview:label];

    if (i==0) {
        label.text=@"推荐品牌";
    }else if(i==1){
    label.text=@"全部品牌";
    
    }
    return headview;
}
#pragma mark 自定义头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v1=[[UIView alloc]init];
    v1= [self addview:0];
    return v1;
}
#pragma mark tableview
-(void)addtableview{
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight-49)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    table.rowHeight=100;
    
}
#pragma mark 行
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_datadic.allKeys.count) {
        
      return  _datadic.allKeys.count;
   
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return  appBrandAll.count/3+1;
    }
    return recommend.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    
    if (indexPath.section==0) {
    static NSString *identifier=@"cell";
    TheBrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[TheBrandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
        NSString *im=[[recommend objectAtIndex:indexPath.row]objectForKey:@"logopic"];
        [cell.logopic sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];

        cell.brandname.text=[[recommend objectAtIndex:indexPath.row]objectForKey:@"brandName"];
    
        cell.detail.text=[[recommend objectAtIndex:indexPath.row]objectForKey:@"detail"];
        if ([[[recommend objectAtIndex:indexPath.row]objectForKey:@"flag"]integerValue]==1) {
           [cell.savebut setBackgroundImage:[UIImage imageNamed:@"34-33(1)"] forState:UIControlStateNormal];
        }else{
        
        
        [cell.savebut setBackgroundImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        
        [cell.savebut addTarget:self action:@selector(pushsavebrand:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.savebut.tag=indexPath.row;
      
        return cell;
    }else if(indexPath.section==1){
        TwobrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qqq"];
        if (!cell) {
            cell=[[TwobrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        if (appBrandAll.count>indexPath.row *3) {
            
        
       NSString *imgurl=[[appBrandAll objectAtIndex:indexPath.row *3]objectForKey:@"logopic"];
        UIImageView *imageview1=[[UIImageView alloc] init];
        [imageview1 sd_setImageWithURL:[Uikility URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"uuu"]];
        [cell.fistbutton setImage:imageview1.image forState:UIControlStateNormal];
        }
         if(appBrandAll.count>indexPath.row *3+1){
             ;
        NSString *imgurl2=[[appBrandAll objectAtIndex:indexPath.row *3+1]objectForKey:@"logopic"];
     
    UIImageView *imageview2=[[UIImageView alloc] init];
        [imageview2 sd_setImageWithURL:[Uikility URLWithString:imgurl2] placeholderImage:[UIImage imageNamed:@"uuu"]];
        [cell.secondbutton setImage:imageview2.image forState:UIControlStateNormal];
        }
       if(appBrandAll.count>indexPath.row *3+2){
    NSString *imgurl3=[[appBrandAll objectAtIndex:indexPath.row *3+2]objectForKey:@"logopic"];
           
        UIImageView *imageview3=[[UIImageView alloc] init];
        
        [imageview3 sd_setImageWithURL:[Uikility URLWithString:imgurl3] placeholderImage:[UIImage imageNamed:@"uuu"]];
        [cell.threedbutton setImage:imageview3.image forState:UIControlStateNormal];
        }
    
       __block void(^brandblock)(NSInteger text)=^(NSInteger text){
           PpViewController *pp=[[PpViewController alloc]init];
           // pp.hidesBottomBarWhenPushed=YES;
            pp.flag=1;
           if (appBrandAll.count>indexPath.row*3+text ) {
               pp.dic=[appBrandAll objectAtIndex:indexPath.row *3+text];
               pp.appbrandId=[[appBrandAll objectAtIndex:indexPath.row *3+text]objectForKey:@"id"];
               [self.navigationController pushViewController:pp animated:NO];
               [tableView deselectRowAtIndexPath:indexPath animated:YES];

           }
           
        
        };
        cell.myblock=brandblock;
        return cell;
     }

    return cell;
}
-(void)pushsavebrand:(UIButton *)b{
    

    
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        NSDictionary *ds=nil;
        if ([de objectForKey:@"newUserId"]) {
            ds=@{
                 @"userId":[de objectForKey:@"userId"]
                 };
        }else{
        ds=@{ @"userId":[de objectForKey:@"userId"]
                      };
        }
    NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:ds options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
    //去掉空白格和换行符
    jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *d1=@{
                       @"id":[[recommend objectAtIndex:b.tag]objectForKey:@"id"]
                       
                       };
    NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
    //去掉空白格和换行符
    jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
        [dics setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [dics setObject:jsond1 forKey:@"appbrandId"];
        [dics setObject:jsond forKey:@"appuserId"];
        [dics setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [dics setObject:@1 forKey:@"model"];
        [dics setObject:VERSION forKey:@"ios_version"];
        if ([de objectForKey:@"newUserId"]) {
            [dics setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
         
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dics options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //去掉空白格和换行符
    json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
    json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
    json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
    json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSDictionary *json123=@{@"param":json
                          };
    NSString * url3=[BassAPI requestUrlWithPorType:PortTypeSaveBrand];
    [AFManger postWithURLString:url3 parameters:json123 success:^(id responseObject) {
    id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
    
    Boolean success=[[strs objectForKey:@"success"] boolValue];
        if (success) {
        
        [b setBackgroundImage:[UIImage imageNamed:@"34-33(1)"] forState:UIControlStateNormal];
        [Uikility alert:@"收藏成功！"];
        [self json];
        
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
#pragma mark 点击tableview
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    
    PpViewController *pp=[[PpViewController alloc]init];
    pp.hidesBottomBarWhenPushed=YES;
    pp.flag=1;
       
        pp.dic=[recommend objectAtIndex:indexPath.row];
       pp.appbrandId=[[recommend objectAtIndex:indexPath.row]objectForKey:@"id"];
    [self.navigationController pushViewController:pp animated:YES];
     //[tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}

#pragma mark 请求数据
-(void)json{
    //d=[[NSDictionary alloc]init];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
    if ([de objectForKey:@"userId"]) {
        
    
    [dics setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
    [dics setObject:[de objectForKey:@"userId"] forKey:@"userId"];
    [dics setObject:@1 forKey:@"model"];
    if ([de objectForKey:@"newUserId"]) {
        [dics setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
    [dics setObject:VERSION forKey:@"ios_version"];
        NSDictionary *json1=[Uikility initWithdatajson:dics];
        NSString *url=[BassAPI requestUrlWithPorType:PortTypeSelectBrandList];
    [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[strs objectForKey:@"success"] boolValue];
        
        if (success) {
            _datadic=[strs objectForKey:@"data"];
            appBrandAll=[[strs objectForKey:@"data"]objectForKey:@"appBrandAll"];
            recommend=[[strs objectForKey:@"data"]objectForKey:@"recommend"];
            [self addtableview];
           
            
        }else{
            [Uikility alert:[strs objectForKey:@"msg"]];
        }

    } failure:^(NSError *error) {
         [Uikility alert:@"数据接受失败！"];
    }];
  }else{
        NSDictionary *dics=@{@"model":@1,@"ios_version":VERSION
                             };
        
        NSDictionary *json1=[Uikility initWithdatajson:dics];

        NSString *url=[BassAPI requestUrlWithPorType:PortTypeSelectBrandList];
       
        [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
            //从网络获取数据
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            
            if (success) {
                _datadic=[strs objectForKey:@"data"];
                appBrandAll=[[strs objectForKey:@"data"]objectForKey:@"appBrandAll"];
                recommend=[[strs objectForKey:@"data"]objectForKey:@"recommend"];
                [self addtableview];
                //[hud removeFromSuperview];
                // hud=nil;
                
            }else{
                [Uikility alert:[strs objectForKey:@"msg"]];
            }

            
        } failure:^(NSError *error) {
           [Uikility alert:@"数据接受失败！"];
        }];
                
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
