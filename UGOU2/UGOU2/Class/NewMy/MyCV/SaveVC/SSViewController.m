//
//  SSViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/16.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.16.9.24 收藏
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "SSViewController.h"
#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFManger.h"
#import "Uikility.h"
#import "SaveTableViewCell.h"
#import "BassAPI.h"
#import "CartModel.h"
#import "SaveBrandTableViewCell.h"
#import "SpViewController.h"
#import "PpViewController.h"
//#import <TencentOpenAPI/QQApiInterface.h>
#import "UGHeader.h"
@interface SSViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_dataarray;
    NSString *_url;
   
    UIView *view;
    NSData *imdata;
    NSString *title;
    NSString *detext;
    NSArray *arrimg;
    NSArray *arrtext;
}

@end

@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataarray=[[NSMutableArray alloc] init];
    [self addnavview];
    [self addtableview];
    [self addfootview];
    [self json];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden=YES;
}
#pragma mark 导航栏
-(void)addnavview{
    UGCustomNavView *cutemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    cutemNav.Delegate=self;
    [cutemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    if (_flage==1) {
        cutemNav.title=@"收藏商品";
    }else if (_flage==2){
        //titlelabel.text=@"收藏的品牌";、
        cutemNav.title=@"收藏品牌";
    }
    [cutemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:cutemNav];
}
-(void)LeftItemAction{
    [self pop];
    
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  搜索
-(void)pushsearch{

}
#pragma mark  tableview
-(void)addtableview{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight)style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableview];
    UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1*KIphoneWH)];
    views.backgroundColor=[UIColor whiteColor];
    _tableview.tableHeaderView=views;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100*KIphoneWH;
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataarray.count) {
        return _dataarray.count;
    }
    return 0;
   // return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    
    if (_flage==1) {
        
    static NSString *identifier=@"cell";
    SaveTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[SaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_dataarray.count) {
        CartModel *model=_dataarray[indexPath.row];
        
        [cell.logpicUrl sd_setImageWithURL:[Uikility URLWithString:model.logopicUrl]placeholderImage:[UIImage imageNamed:@"uuu"]];
        cell.goodsname.text=model.goodsName;
        CGFloat s1=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
        cell.pirce.text=[NSString stringWithFormat:@"￥%.1f",s1];
        cell.lalable.alpha=0;
        CGFloat s=model.goodsPrice.floatValue;
        if (s>s1) {
            cell.orgpirce.text=[NSString stringWithFormat:@"￥%.1f",s];
            cell.lalable.alpha=1;
        }
        [cell.savebut addTarget:self action:@selector(pushsave:) forControlEvents:UIControlEventTouchUpInside];
        cell.savebut.tag=indexPath.row;
        

    }
    
       return cell;
    }else {
    
        static NSString *identifier=@"cell";
        SaveBrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[SaveBrandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (_dataarray.count) {
//            w *brandimv;
//            @property(nonatomic,strong)UILabel *brandname;
//            @property(nonatomic,strong)UILabel *brandintro;
            
           NSString *im=[[[_dataarray objectAtIndex:indexPath.row]objectForKey:@"appbrandId" ]  objectForKey:@"logopic"];
            [cell.brandimv sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];
            
            cell.brandname.text=[[[_dataarray objectAtIndex:indexPath.row]objectForKey:@"appbrandId" ] objectForKey:@"brandName"];
            
            cell.brandintro.text=[[[_dataarray objectAtIndex:indexPath.row]objectForKey:@"appbrandId" ] objectForKey:@"detail"];
            [cell.fxbut addTarget:self action:@selector(pushsave:)forControlEvents:UIControlEventTouchUpInside];
            cell.fxbut.tag=indexPath.row;
            
            
        }
        return cell;
    }
    return cell;
}
#pragma mark  分享
-(void)pushsave:(UIButton *)b{
    //view.alpha=1;
    

    [UIView beginAnimations:@"animatePopView" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView commitAnimations];
        if (_flage==1) {
        CartModel *model=_dataarray[b.tag];
        imdata=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.logopicUrl]];
            detext=model.promotionPrice;
            title=model.goodsName;
        }else{
        imdata=[NSData dataWithContentsOfURL:[NSURL URLWithString: [[_dataarray[b.tag]objectForKey:@"appbrandId"]objectForKey:@"logopic"]]];
            title=[[_dataarray[b.tag]objectForKey:@"appbrandId"]objectForKey:@"brandName"];
            detext=[[_dataarray[b.tag]objectForKey:@"appbrandId"]objectForKey:@"detail"];
        }
    
    
}
-(void)addfootview{
    
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
        
        
        
        
        //if ([QQApiInterface isQQInstalled]) {
            arrimg=@[@"common_icon_weibo@2x",@"common_icon_qq@2x",@"sns_icon_23@3x.png",@"common_icon_wechat@2x.png"];
        //}else{
           // arrimg=@[@"common_icon_weibo@2x",@"sns_icon_23@3x.png",@"common_icon_wechat@2x"];
            
        //}
        
        
    }else  {
        
        //if ([QQApiInterface isQQInstalled]) {
            arrimg=@[@"common_icon_qq@2x",@"common_icon_weibo@2x"];
        //}else{
            
            
           // arrimg=@[@"common_icon_weibo@2x"];
        //}
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
            //arrtext=@[@"新浪微博",@"微信朋友圈",@"微信好友"];
            
        //}
        
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

-(void)pushfx:(UIButton *)b{
    Uikility * utl=[[Uikility alloc] init];
    switch (b.tag) {
            
        case 1:
            
           [utl shareWbsinaWithimage:imdata title:title description:detext url:nil];
            break;
        case 2:
        if (arrtext.count==3) {
            [utl shareWithWexintext:detext Withurl:nil title:title imagedata:imdata uiiamge:nil];
            }else{
                CartModel *model=_dataarray[b.tag];
                UIImage *image=[UIImage imageNamed:@"uuu"];
                
                [utl shareWithYmQQzone:detext Withurl:nil title:title imagedata:image imageurl:model.logopicUrl viewcontrol:nil];
            }
            
            break;
            
        case 3:
            if (arrtext.count==3) {
                [utl shareWithWXfrendtext:detext Withurl:nil title:title imagedata:imdata uiiamge:nil];
            }else{
                
                [utl shareWithWexintext:detext Withurl:nil title:title imagedata:imdata uiiamge:nil];
            }
            break;
        case 4:
            [utl shareWithWXfrendtext:detext Withurl:nil title:title imagedata:imdata uiiamge:nil];
            break;
            
        default:
            break;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (_flage==1) {
        SpViewController *sp=[[SpViewController alloc]init];
        CartModel *model=[_dataarray objectAtIndex:indexPath.row];
        NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
        
        sp.goodsId=sreid;
        sp.flag=1;
        sp.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sp animated:YES];
    }else{

        
        PpViewController *pp=[[PpViewController alloc]init];
        pp.hidesBottomBarWhenPushed=YES;
        pp.flag=1;
        
        pp.dic=[[_dataarray objectAtIndex:indexPath.row]objectForKey:@"appbrandId" ] ;
        pp.appbrandId=[[[_dataarray objectAtIndex:indexPath.row]objectForKey:@"appbrandId" ] objectForKey:@"id"];
        
        [self.navigationController pushViewController:pp animated:YES];
    }
    
    
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)json{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    
    if ([de objectForKey:@"userId"]) {
        NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
        [dics setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [dics setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
            [dics setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        [dics setObject:@1 forKey:@"model"];
        [dics setObject:VERSION forKey:@"ios_version"];
        NSDictionary *dic=[Uikility initWithdatajson:dics];
        if (_flage==1) {
           _url=[BassAPI requestUrlWithPorType:PortTypeSelctGoods];
        }else if (_flage==2){
         _url=[BassAPI requestUrlWithPorType:PortTypeSelectBrand];
        }
       
    
       [AFManger postWithURLString:_url parameters:dic success:^(id responseObject) {
           id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[strs objectForKey:@"success"] boolValue];
           
           if (success) {
               
               if (_flage==1) {
                   NSArray *array=[strs objectForKey:@"data"];
                   for (NSDictionary *dic in array) {
                       NSDictionary *dicc=[dic objectForKey:@"appgoodsId"];
                       [_dataarray addObject:[CartModel initwithdic:dicc]];
                   }
               }else if (_flage==2){
                   // for (NSDictionary *dic in array) {
                   //    // NSDictionary *dicc=[dic objectForKey:@"appbrandId"];
                   //[_dataarray addObject:[CartModel initwithdic:dicc]];
                   // }
                   _dataarray=[strs objectForKey:@"data"];
               }
               
               [_tableview reloadData];
           }else{
               [Uikility alert:[strs objectForKey:@"msg"]];
           }

       } failure:^(NSError *error) {
            [Uikility alert:@"连接失败！"];
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
