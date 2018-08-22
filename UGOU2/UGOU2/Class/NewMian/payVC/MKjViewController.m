//
//  MKjViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/3.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//
#import "MKjViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "CouponsModel.h"
#import "CardTableViewCell.h"
#import "GkViewController.h"
#import "Singonarray.h"
#import "UGHeader.h"
@interface MKjViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate>{
    UITableView *_table;
    NSMutableArray *_dataarray;
    NSMutableArray *_array;

    NSUserDefaults *dc;
   // NSString *strurl;
  UIImageView *  _imageview;
   
    
}

@end

@implementation MKjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dc=[NSUserDefaults standardUserDefaults];
   
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;

    self.view.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    _dataarray=[NSMutableArray array];
    _array=[NSMutableArray array];
    [self addtable];
    [self jsonkj];
    [self screebrand];

    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custemNav.Delegate=self;
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [custemNav setLeftImage:[UIImage imageNamed:@"返回p"]];
    custemNav.title=@"我的卡券";
    [self.view addSubview:custemNav];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;

}
-(void)LeftItemAction{
   
    [self push];
}
-(void)push{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addtable{
    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-110*KIphoneWH, NavHeight, 100*KIphoneWH, 30*KIphoneWH)];
    [but setTitle:@"过期代金券" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    but.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [but addTarget:self action:@selector(pushold) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    _table=[[UITableView alloc]initWithFrame:CGRectMake(10*KIphoneWH, 30*KIphoneWH+NavHeight, WIDTH-20*KIphoneWH, HEIGHT-30*KIphoneWH) ];
    [self.view addSubview:_table];
    _table.delegate=self;
    _table.dataSource=self;
    _table.rowHeight=110*KIphoneWH;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor colorWithRed: 231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    
    
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
    ////////////////////NSLog(@"%zd",_dataarray.count);
    CardTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[CardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (_dataarray.count) {
        CouponsModel *model=[_dataarray objectAtIndex:indexPath.row];
        NSString * moneystr=[NSString stringWithFormat:@"¥%@", model.money01  ];
        cell.pricelable.text=moneystr;
        cell.pricelable.textColor=[UIColor  colorWithRed:252.0/255.0 green:13.0/255.0 blue:59.0/255.0 alpha:1];
        NSString *money2=[NSString stringWithFormat:@"满%@元可用",model.money02];
        cell.propolable.text=money2;
        if (model.brandName) {
            NSString *namestr=[NSString stringWithFormat:@"%@代金券",model.brandName];
            cell.namelable.text=namestr;
            cell.namelable.textColor=[UIColor colorWithRed:253.0/255.0 green:149.0/255.0 blue:43.0/255.0 alpha:1];
        }else{
            cell.namelable.text=model.brandName;
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
        
        if ([dc objectForKey:@"ids"]) {
            NSArray *arr=[dc objectForKey:@"ids"];
            for (NSData *d  in arr) {
                CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d];
                    if ([dmol.preid isEqualToNumber: model.preid]) {
                        [cell.but setTitle:@"已选择" forState:UIControlStateNormal];
                         cell.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.1f];
                //}
                }
            }
    
        }
   }
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (_flagss==2) {
        
   
        CouponsModel *model=_dataarray[indexPath.row];
        if ([dc objectForKey:@"ids"]) {
            NSArray *arr=[dc objectForKey:@"ids"];
            for (NSData *d  in arr) {
                    CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d ];
                    if ( [dmol.preid isEqualToNumber: model.preid]) {
                        [Uikility alert:@"已选择！"];
                        return;
                   
                }
            }
        }
//如果是通用券

        
        
        NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
        NSString *s=[NSString stringWithFormat:@"%zd",_buttag];
        model.buttag=s;
        
        
        
        
        
        [d setValue:model.preid forKey:s];
        
        //传过去  再传回来
        if ([dc objectForKey:@"ids"]) {
            NSMutableArray *arr=[NSMutableArray array];
            NSArray *array=[dc objectForKey:@"ids"];
            [arr addObjectsFromArray:array];
            NSData *data=[NSKeyedArchiver archivedDataWithRootObject:model];
            [arr addObject:data];
            [dc setObject:arr forKey:@"ids"];
        }else{
            
            NSMutableArray *arr=[NSMutableArray array];
            NSData * data=[NSKeyedArchiver archivedDataWithRootObject:model];
            [arr addObject:data];
             [dc setObject: arr forKey:@"ids"];
        }
       
        
#pragma mark---调用代理
        
        [self.orderdeleget preferentialchangge:model.money01.integerValue page:_buttag];
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)screebrand{
   


}
-(void)jsonkj{
    
     NSString *  strurl= [BassAPI requestUrlWithPorType:PortTypeSelectrMDGenera];
   
    
    
    if ([dc objectForKey:@"userId"]) {
        NSMutableDictionary *postdic=[[NSMutableDictionary alloc] init];
        
        [postdic setObject:[dc objectForKey:@"userId"] forKey:@"userId"];
        [postdic setObject:[dc objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([dc objectForKey:@"newUserId"]) {
           [postdic setObject:[dc objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        [postdic setObject:@1 forKey:@"model"];
        [postdic setObject:VERSION forKey:@"ios_version"];
        NSDictionary *dicurl=[Uikility initWithdatajson:postdic];
      
       [AFManger postWithURLString:strurl parameters:dicurl success:^(id responseObject) {
           id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
           //NSLog(@"%@",objec);
           Boolean success=[[objec objectForKey:@"success"] boolValue];
           if (success) {
               NSArray *data=[objec objectForKey:@"data"];
               
               if (_flagss==2) {
                   for (NSDictionary * datadics in data) {
                       NSDictionary *datadic=[datadics objectForKey:@"appvoucherId"];
                       CouponsModel *model=[CouponsModel initWithModeldic:datadic];
                       model.preid=[datadics objectForKey:@"id"];
                       if ([datadic objectForKey:@"appbrandId"]) {
                           NSDictionary *dicc=[datadic objectForKey:@"appbrandId"];
                           
                           if ([dicc objectForKey:@"id"]) {
                               model.brandids=[dicc objectForKey:@"id"];
                               model.brandName=[dicc objectForKey:@"brandName"];
                               
                               
                               if (model.brandids.integerValue ==_brandid.integerValue) {
                                   
                                   NSNumber *ss=[datadic objectForKey:@"money02"];
                                   
                                   if (ss.integerValue<_price) {
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
                               }else{
                                   
            }
                               
        }else{
                               NSDictionary *dicc=[datadic objectForKey:@"appbrandId"];
                               model.brandName=[dicc objectForKey:@"brandName"];
                               
                               NSNumber *ssa=[datadic objectForKey:@"money02"];
                               if (ssa.integerValue<_price) {
                                   //return;
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
                           }
                           
                       }
                       
                   }
                   
               }else{
                   
                   for (NSDictionary * datadics in data) {
                       
                       NSDictionary *datadic=[datadics objectForKey:@"appvoucherId"];
                       
                       CouponsModel *model=[CouponsModel initWithModeldic:datadic];
                       
                       model.preid=[datadics objectForKey:@"id"];
                       if ([datadic objectForKey:@"appbrandId"]) {
                           NSDictionary *dicc=[datadic objectForKey:@"appbrandId"];
                           
                           
                           if ([dicc objectForKey:@"brandName"]) {
                               model.brandName=[dicc objectForKey:@"brandName"];
                               model.brandids=[dicc objectForKey:@"id"];
                           }
                           
                           
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

