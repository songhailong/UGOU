//
//  KjViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/2/26.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "KjViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import"AFManger.h"
#import "CouponsModel.h"
#import "CardTableViewCell.h"
#import "GkViewController.h"
#import "UGHeader.h"
#import "UGShareViewController.h"
#import "UGSharePresentationController.h"
@interface KjViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate,UGShareDelegate,UIViewControllerTransitioningDelegate,UIAlertViewDelegate>{
    UITableView *_table;
    NSMutableArray *_dataarray;
    NSMutableArray *_array;
  
    NSUserDefaults *dc;
    NSInteger selecter;

}
@property(nonatomic,strong)NSData *ShareData;
@property(nonatomic,strong)NSString *ShareUrl;
@property(nonatomic,strong)NSString *Sharetitle;
@property(nonatomic,strong)NSString *Shareintro;
@end

@implementation KjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dc=[NSUserDefaults standardUserDefaults];

        [self jsonkj];
   

    self.view.backgroundColor=[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1];
      _dataarray=[NSMutableArray array];
    _array=[NSMutableArray array];
    [self addtable];
    
  

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    custemNav.Delegate=self;
    [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    custemNav.title=@"卡券列表";
    [self.view addSubview:custemNav];
    
    
}
-(void)LeftItemAction{
  
    [self push];
}
-(void)push{
    //self.navigationController.navigationBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addtable{
    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-110*KIphoneWH, NavHeight, 100*KIphoneWH, 30*KIphoneWH)];
    [but setTitle:@"过期代金券" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    but.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [but addTarget:self action:@selector(pushold) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    _table=[[UITableView alloc]initWithFrame:CGRectMake(10*KIphoneWH, NavHeight+30*KIphoneWH, WIDTH-20*KIphoneWH, HEIGHT-254*KIphoneWH) ];
    [self.view addSubview:_table];
    _table.delegate=self;
    _table.dataSource=self;
    //_table.
    _table.rowHeight=110*KIphoneWH;
        _table.separatorStyle=UITableViewCellSeparatorStyleNone;
   // _table.backgroundColor=[UIColor  colorWithRed:74.0/255.0 green:180.0/255.0 blue:236.0/255.0 alpha:1];
   /*
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-140*KIphoneWH, HEIGHT-200*KIphoneWH,120*KIphoneWH , 30*KIphoneWH)];
[button addTarget:self action:@selector(receive:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor redColor];
    [button setBackgroundImage:[UIImage imageNamed:@"一键领取.png"] forState:UIControlStateNormal];
    [self .view addSubview:button];
    */
UIImageView *ruleslable=[[UIImageView alloc] initWithFrame:CGRectMake(20*KIphoneWH, HEIGHT-170*KIphoneWH, WIDTH-40*KIphoneWH, 40*KIphoneWH)];
    
    ruleslable.image=[UIImage imageNamed:@"使用规则上方框.png"];
    UILabel *textlable=[[UILabel alloc] initWithFrame:CGRectMake(0*KIphoneWH, 0, WIDTH-40*KIphoneWH, 40*KIphoneWH)];
    textlable.backgroundColor=[UIColor clearColor];
    textlable.text=@"使 用 规 则";
    textlable.textAlignment= NSTextAlignmentCenter ;
    textlable.textColor=[UIColor whiteColor];
    textlable.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [ruleslable addSubview:textlable];
    UIView *lastview=[[UIView alloc] initWithFrame:CGRectMake(20*KIphoneWH, HEIGHT-130*KIphoneWH, WIDTH-40*KIphoneWH, 130*KIphoneWH)];
    lastview.backgroundColor=[UIColor colorWithRed:37.0/255.0 green:137.0/255.0 blue:222.0/255.0 alpha:1];
    UILabel *textlable1=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 0, WIDTH-40*KIphoneWH, 130*KIphoneWH)];
    textlable1.text=@"1.优惠券请查看文字表述，只能在限定条件内使用。\n2.优惠券过期后将无法使用。\n3.使用优惠券发生退货关系，优惠券将不再返还。\n4.活动最终解释权归U购所有";
    textlable1.numberOfLines=0;
    textlable1.textColor=[UIColor whiteColor];
    textlable1.font=[UIFont systemFontOfSize:14*KIphoneWH];
    
    
    [lastview addSubview:textlable1];
    
    //ruleslable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"使用规则上方框.png"]];
    [self.view addSubview:ruleslable];
    [self.view addSubview:lastview];
}
//一建领取
-(void)receive:(UIButton *)b{
      
    


}
-(void)pushold{
    
    GkViewController *g=[[GkViewController alloc]init];
    g.array=_array;
    [self.navigationController pushViewController:g animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_dataarray.count){
        return _dataarray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
   CardTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[CardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
   
    
    if (_dataarray.count) {
        CouponsModel *model=[_dataarray objectAtIndex:indexPath.row];
        //cell.contentView.backgroundColor=[UIImage imageNamed:@""]
        //cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:143.0/255.0 green:235.0/255.0 blue:123.0/255.0 alpha:1];
        //cell.view.backgroundColor=[UIColor colorWithRed:143.0/255.0 green:235.0/255.0 blue:123.0/255.0 alpha:1];
        if (model.banner==nil) {
            cell.iocnimageviedw.alpha=0;
        NSString * moneystr=[NSString stringWithFormat:@"¥%@", model.money01  ];
        cell.pricelable.text=moneystr;
        cell.pricelable.textColor=[UIColor  colorWithRed:252.0/255.0 green:13.0/255.0 blue:59.0/255.0 alpha:1];
        NSString *money2=[NSString stringWithFormat:@"满%@元可用",model.money02];
        cell.propolable.text=money2;
        if (model.brandName) {
           // NSString *namestr=[NSString stringWithFormat:@"%@代金券",model.brandName];
           cell.namelable.text=model.name;
            cell.namelable.textColor=[UIColor colorWithRed:253.0/255.0 green:149.0/255.0 blue:43.0/255.0 alpha:1];
        }else{
            cell.namelable.text=model.name;
            cell.namelable.textColor=[UIColor colorWithRed:253.0/255.0 green:149.0/255.0 blue:43.0/255.0 alpha:1];
        }
        long long s=  model.validity.longLongValue;
        NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];
        
        long gg=sss.integerValue;
       
        NSString *timestr=[Uikility Datetodatestyle:gg];
 
        
      
        long long vs=  model.days.longLongValue;
        NSString *vsss=[NSString stringWithFormat:@"%lld",vs/1000];
        
        long vgg=vsss.integerValue;
       
        NSString *vtimestr=[Uikility Datetodatestyle:vgg];
        cell.timelable.text=[NSString stringWithFormat:@"%@ 至 %@",  timestr,vtimestr];
        cell.timelable.textColor=[UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1];
         cell.but.tag=indexPath.row;
        }else{
            cell.alpha=1;
            [cell.iocnimageviedw sd_setImageWithURL:[Uikility URLWithString:model.banner] placeholderImage:[UIImage imageNamed:@"uuu"]];
        }
        if (model.receiveFlag) {
            cell.but.alpha=1.0;
        }else{
            cell.but.alpha=0.0;
        }
        
        
        //判断 flag
        if (model.flag.integerValue==1) {
            [cell.but setTitle:@"已领取" forState:UIControlStateNormal];
        }else{
           //[cell.but addTarget:self action:@selector(pushlq:) forControlEvents:UIControlEventTouchUpInside];
            
         //[cell.but setTitle:@"领取" forState:UIControlStateNormal];
        }
        if (model.imgUrl==nil) {
            cell.shareBt.alpha=0.0;
        }else{
            cell.shareBt.alpha=1.0;
        }
            
        
        
        //[cell.iocnimageviedw sd_setImageWithURL:[Uikility URLWithString:model.banner] placeholderImage:[UIImage imageNamed:@"uuu"]];
       
    
    
       cell.shareClickBlock = ^(NSString *strValue) {
            [self shareClickShowWithIdex:model];
        };
       
    }
    
    return cell;
}
-(void)pushlq:(NSInteger)b{
   
  
    //判断
    
    CouponsModel *model=_dataarray[b];
    if(model.flag.integerValue==0){
    
    
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeSaveGenera];
        
        
    if ([dc objectForKey:@"userId" ]) {
        NSDictionary *d1=@{
                           @"userId":[dc objectForKey:@"userId"]
                           };
        NSData *jsonData1=[NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json1=[[NSString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        json1=[json1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json1=[json1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        json1=[json1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *d2=@{
                           @"id":model.id
                           };
        NSData *jsonData2=[NSJSONSerialization dataWithJSONObject:d2 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json2=[[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        json2=[json2 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json2=[json2 stringByReplacingOccurrencesOfString:@" " withString:@""];
        json2=[json2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSMutableDictionary *ds=[[NSMutableDictionary alloc] init];
        [ds setObject:[dc objectForKey:@"sessionid"] forKey:@"sessionid"];
        [ds setObject:[dc objectForKey:@"userId"] forKey:@"userId"];
        if ([dc objectForKey:@"newUserId"]) {
            [ds setObject:[dc objectForKey:@"newUserId" ] forKey:@"newUserId"];
        }
        [ds setObject:json1 forKey:@"appuserId"];
        [ds setObject:json2 forKey:@"appvoucherId"];
        [ds setObject:model.come forKey:@"endDays"];
        [ds setObject:@1 forKey:@"model"];
        [ds setObject:VERSION forKey:@"ios_version"];
        NSData *jsonDatas=[NSJSONSerialization dataWithJSONObject:ds options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsons=[[NSString alloc]initWithData:jsonDatas encoding:NSUTF8StringEncoding];
        jsons=[jsons stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        jsons=[jsons stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        jsons=[jsons stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        jsons=[jsons stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        jsons=[jsons stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsons=[jsons stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsons=[jsons stringByReplacingOccurrencesOfString:@"\n" withString:@""];

        NSDictionary *parame=@{
                               @"param":jsons
                               };
       
   [AFManger postWithURLString:url parameters:parame success:^(id responseObject) {
       id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
       
       
       Boolean success=[[objec objectForKey:@"success"] boolValue];
       if (success) {
           [Uikility alert:@"领取成功！"];
           [_dataarray removeAllObjects];
           [_array removeAllObjects];
           [self jsonkj];
           
       }else{
           [Uikility alert:[objec objectForKey:@"msg"]];
       }

   } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
   }];
    }else{
        [Uikility alert:@"请先登录！"];
    }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"----------------");
    CouponsModel *model=_dataarray[indexPath.row];
    if (model.receiveFlag) {
        //NSLog(@"----------------");
        //[self pushlq:indexPath.row];
        
        if (model.flag.integerValue==0) {
            selecter=indexPath.row;
            UIAlertView *altview=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否领取优惠券" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"领取", nil];
            altview.tag=2;
            [altview show];
        }
    }
    
    
    //[self pushlq:indexPath.row];
}

-(void)jsonkj{
    
   // NSString *url=[BassAPI requestUrlWithPorType:PortTypeSaveGenera];
   
    
   
   NSString * strurl= [BassAPI requestUrlWithPorType:PortTypeSelectrGenera];
   if ([dc objectForKey:@"userId"]) {
        NSMutableDictionary * postdic=[[NSMutableDictionary alloc] init];
        [postdic setObject:[dc objectForKey:@"userId"] forKey:@"userId"];
        [postdic setObject:[dc objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([dc objectForKey:@"newUserId"]) {
          [postdic setObject:[dc objectForKey:@"newUserId" ] forKey:@"newUserId"];
        }
        [postdic setObject:[dc objectForKey:@"placename"] forKey:@"area"];
        [postdic setObject:@1 forKey:@"model"];
        [postdic setObject:VERSION forKey:@"ios_version"];
        
        NSDictionary *dicurl=[Uikility initWithdatajson:postdic];
       
       [AFManger postWithURLString:strurl parameters:dicurl success:^(id responseObject) {
           id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
           Boolean success=[[objec objectForKey:@"success"] boolValue];
           if (success) {
               NSArray *data=[objec objectForKey:@"data"];
               //NSLog(@"%@",objec);
               
               for (NSDictionary * datadic in data) {
                   
                   CouponsModel *model=[CouponsModel initWithModeldic:datadic];
                   // model.preid=[datadic]
                   if ([datadic objectForKey:@"appbrandId"]) {
                       NSDictionary *dicc=[datadic objectForKey:@"appbrandId"];
                       model.brandName=[dicc objectForKey:@"brandName"];
                    }
                   if([datadic objectForKey:@"appshareId"]){
                       NSDictionary *dicc=[datadic objectForKey:@"appshareId"];
                       model.banner=[dicc objectForKey:@"banner"];
                       model.img=[dicc objectForKey:@"img"];
                       model.imgUrl=[dicc objectForKey:@"imgUrl"];
                       model.intro=[dicc objectForKey:@"intro"];
                       model.title=[dicc objectForKey:@"title"];
                   }
                   NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                   NSTimeInterval a=[dat timeIntervalSince1970]*1000;
                   NSString *timeString = [NSString stringWithFormat:@"%0.0f", a];
                   
                   NSNumber *ss=[datadic objectForKey:@"days"];
                   
                   if (ss.longLongValue >timeString.longLongValue) {
                       
                       [_dataarray addObject:model];
                   }else{
                       
                       [_array addObject:model];
                   }
                   
               }
               
               
               [_table reloadData];
           }else{
               
               [Uikility alert:[objec objectForKey:@"msg"]];
           }
 
       } failure:^(NSError *error) {
            [Uikility alert:@"数据连接失败"];
       }];
               
    }else{
        [Uikility alert:@"请先登录！"];
        
    }
}
#pragma mark*****分享按钮回调
-(void)shareClickShowWithIdex:(CouponsModel*)model{
    UGShareViewController * shrevc=[[UGShareViewController alloc] init];
    shrevc.Delegate=self;
    shrevc.transitioningDelegate=self;
    shrevc.modalPresentationStyle=UIModalPresentationCustom;
    _ShareUrl=model.imgUrl;
    _Shareintro=model.intro;
    _Sharetitle=model.title;
    [self presentViewController:shrevc animated:YES completion:nil];
    
    NSString *  ImageUrl=model.img;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _ShareData =[NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
           // NSLog(@"主线程");
            // [self creatshareview];
            //[self.navigationController popToRootViewControllerAnimated:YES];
        });
        //[self creatshareview];
    });
    
}
-(UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[UGSharePresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}
#pragma  mark*****分享代理
-(void)shareBtnClick:(NSInteger)index shareImage:(NSData *)shareImage shareUrl:(NSString *)shareUrl{
    NSString *urlstr=@"http://ugouchina.com//ugouApp/yhq.html";
    Uikility *ukit=[[Uikility alloc] init];
    if (_ShareData==nil) {
        [SVProgressHUD showWithStatus:@"正在获取图片"];
        [SVProgressHUD dismissWithDelay:1.0];
       NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
        _ShareData=data;
        //return;
        
    }
    switch (index) {
        case 0:{
            NSData *data=_ShareData;
            UIImage *image=[UIImage imageWithData:data];
       [ukit shareWithWexintext:_Shareintro Withurl:_ShareUrl title:_Sharetitle imagedata:data uiiamge:image];
            
        }
            break;
        case 1:{
            NSData *data=_ShareData;
            UIImage *image=[UIImage imageWithData:data];
            [ukit shareWithWXfrendtext:_Shareintro Withurl:_ShareUrl title:_Sharetitle imagedata:data uiiamge:image];
            
        }
            
            break;
        case 2:{
            NSData *data=_ShareData;
            UIImage *image=[UIImage imageWithData:data];
            [ukit shareWithYmQQzone:_Sharetitle Withurl:_ShareUrl title:_Shareintro imagedata:image imageurl:nil viewcontrol:self];
        }
            
            break;
        case 3:{
            NSData *data=_ShareData;
            NSString *urls=[NSString stringWithFormat:@"%@%@",_Shareintro,_ShareUrl];
            [ukit shareWbsinaWithimage:data title:urls description:
             _Sharetitle url:nil];
        }
            
            break;
            
        default:
            break;
    }
    
    
    
//    if (titler.count==1) {
//        if (shareImageData==nil) {
//            NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
//            NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",urlstr];
//            [ukit shareWbsinaWithimage:data title:urls description:
//             @"领取U购优惠券" url:nil];
//        }else{
//            
//            
//            NSData *data=  shareImageData;
//            NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",shareURL];
//            [ukit shareWbsinaWithimage:data title:urls description:
//             @"领取U购优惠券" url:nil];
//        }
//        
//        
//        
//    }else{
//        if (b.tag==10000) {
//            if (shareImageData==nil) {
//                NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
//                UIImage *image=[UIImage imageNamed:@"uuu.png"];
//                
//                [ukit shareWithWexintext:@"领取U购优惠券，可返现金" Withurl:urlstr title:@"U购优惠券" imagedata:data uiiamge:image];
//            }else{
//                NSData *data= shareImageData;
//                UIImage *image=[UIImage imageWithData:data];
//                
//                [ukit shareWithWexintext:@"领取U购优惠券，可返现金" Withurl:shareURL title:@"U购优惠券" imagedata:data uiiamge:image];
//                
//            }
//        }else if(b.tag==10002){
//            if (shareImageData==nil) {
//                NSData *data=     [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
//                //[ukit shareWithWXfrendtext:nil Withurl:urlstr title:@"领取U购优惠券" imagedata];
//                UIImage *image=[UIImage imageNamed:@"uuu.png"];
//                [ukit shareWithWXfrendtext:@"领取U购优惠券，可返现金" Withurl:urlstr title:@"U购优惠券" imagedata:data uiiamge:image];
//            }else{
//                NSData *data=shareImageData;
//                UIImage *image=[UIImage imageWithData:data];
//                [ukit shareWithWXfrendtext:@"领取U购优惠券，可返现金" Withurl:shareURL title:@"U购优惠券" imagedata:data uiiamge:image];
//                
//            }
//            
//        }else {
//            if (shareImageData==nil) {
//                NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"uuu" ofType:@"png"]];
//                NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",urlstr];
//                [ukit shareWbsinaWithimage:data title:urls description:
//                 @"领取U购优惠券" url:nil];
//            }else{
//                NSData *data=shareImageData;
//                NSString *urls=[NSString stringWithFormat:@"%@%@",@"领取U购优惠券",shareURL];
//                [ukit shareWbsinaWithimage:data title:urls description:
//                 @"领取U购优惠券" url:nil];
//            }
//            
//            
//        }
//    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //根据被点击按钮的索引处理点击事件,buttonIndex表示被点击的按钮的下标，默认cancel是0
    if (buttonIndex==0) {
        return;
    }else if (buttonIndex==1){
        
        [self pushlq:selecter];
        
        
    }
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
