//
//  PlaceViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/26.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.10.26.2.24 地址
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "AFManger.h"
#import "PlaceViewController.h"
#import "AdressViewController.h"
#import "PlaceTableViewCell.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "UGHeader.h"
@interface PlaceViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate>{
    UIView *view2;
   
    NSDictionary *dic;
    NSString *url;
    NSString *url1;
    UIButton *rightButton;
    int flage;
    int hang;
    int zhen;
    int sf;
    UITableView *table;
    NSArray *array;
    UIImageView *_imageview;
    NSInteger _moren;
  
}
@end

@implementation PlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //self.navigationController.navigationBar.translucent=NO;
   
        // Do any additional setup after loading the view.
}
#pragma mark 导航栏
-(void)adddaohanglan{
    self.navigationController.navigationBar.hidden=YES;
    UGCustomNavView *custem=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custem.Delegate=self;
    custem.title=@"管理收货地址";
    [custem.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [custem setLeftImage:[UIImage imageNamed:@"返回o"]];
    [custem.RightButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.view addSubview:custem];
}
-(void)LeftItemAction{
    [self pushpop];
}
-(void)rightItemAction{
    [self pusht];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _imageview.hidden=YES;
    
}
#pragma mark 导航栏点击返回
-(void)pushpop{
    
    // [_imageview removeFromSuperview];
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;
    view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    [self adddaohanglan];
      [self addtableview];
    flage=0;
    hang=0;
    zhen=0;
    sf=0;
    array =[[NSArray alloc]init];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    [self postMethod];
}
#pragma mark 上传数据
-(void)postMethod{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dicc=[Uikility creatSinGoMutableDictionary];
    if(flage==0){
        
        url=[BassAPI requestUrlWithPorType:PortTypegetAddressList];
//        dic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"model":@1,@"ios_version":VERSION};
    }else if (flage==1) {
        url=[BassAPI requestUrlWithPorType:PortTypeDelegetAddress];
//        dic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"addressId":[[array objectAtIndex:hang]objectForKey:@"id"],@"model":@1,@"ios_version":VERSION};
        [dicc setObject:[[array objectAtIndex:hang]objectForKey:@"id"] forKey:@"addressId"];
        
        
        
        
    }else if (flage==2){
        if (sf==1) {
          
            url=[BassAPI requestUrlWithPorType:PortTypeDefaultAdress];
            //if ([de objectForKey:@"addressId"]) {
            if ([de objectForKey:@"addressId"]) {
                [dicc setObject:@0 forKey:@"flag"];
                [dicc setObject:[[array objectAtIndex:zhen]objectForKey:@"id"] forKey:@"addressId"];
                
                
                }else{
                    sf=0;
                   [self postMethod];
                
            }
        //}
        //else{
                
                    //sf=0;
                    //[self postMethod];
                
                //}
                   }else if(sf==0){
           
        url=[BassAPI requestUrlWithPorType:PortTypeDefaultAdress];

                       [dicc setObject:@1 forKey:@"flag"];
                       [dicc setObject:[[array objectAtIndex:hang]objectForKey:@"id"] forKey:@"addressId"];
                       
        }
       
    }
    NSDictionary *json2=[Uikility initWithdatajson:dicc];
    [AFManger postWithURLString:url parameters:json2 success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[obj objectForKey:@"success"] boolValue];
        if (success) {
            if (flage==0){
                array=[obj objectForKey:@"data"];
                [de removeObjectForKey:@"addressId"];
                for (NSDictionary *adressdic in array) {
                    NSNumber *sdsd=[adressdic objectForKey:@"flag"];
                    if (sdsd.integerValue==1) {
                        [de setObject:[adressdic objectForKey:@"id"] forKey:@"addressId"];
                        
                    }
                }
                
                
                [table reloadData];
            }else if (flage==1){
                flage=0;
                
                if ([[[array objectAtIndex:hang]objectForKey:@"id"]isEqual:[de objectForKey:@"addressId"]]) {
                    
                    [de removeObjectForKey:@"addressId"];
                    _moren=2;
                    
                }
                [self postMethod];
                
            }else if (flage==2) {
                if (sf==1){
                    sf=0;
                    
                    [self postMethod];
                }else if (sf==0){
                    [de setObject:[[array objectAtIndex:hang]objectForKey:@"id"] forKey:@"addressId"];
                    
                    flage=0;
                    [self postMethod];
                    
                }
            }
        }else{
            
            if ([obj objectForKey:@"msg"]) {
                [Uikility alert:[obj objectForKey:@"msg"]];
                flage=0;
                [self postMethod];
            }else{
                array =[NSArray array];
                [table reloadData];
            }
        }

        
    } failure:^(NSError *error) {
       [Uikility alert:@"连接失败！"];
    }];

}

#pragma mark点击后 添加
-(void)pusht{
    AdressViewController *ad=[[AdressViewController alloc]init];
    ad.flage=1;
    ad.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ad animated:YES];
   
}
#pragma mark 点击后 返回上一页界面
//-(void)pop{
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark tableview
-(void)addtableview{
    
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) style:UITableViewStyleGrouped];
    [view2 addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.allowsMultipleSelectionDuringEditing=YES;
    table.editing=NO;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
    table.tableHeaderView=view;
    table.rowHeight=160*KIphoneWH;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (array.count==0) {
        return 0;
    }
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
   PlaceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[PlaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (array.count) {
        
    
    if ([[array objectAtIndex:indexPath.row] objectForKey:@"zipcode"]) {
        cell.ziplabel.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"zipcode"]];
    }
   
    cell.conslabel.text=[[array objectAtIndex:indexPath.row] objectForKey:@"consignee"];
    
    cell.mobilelabel.text=[NSString stringWithFormat:@"%@",[[array  objectAtIndex:indexPath.row] objectForKey:@"mobile"]];
    
    cell.arealabel.text=[[array  objectAtIndex:indexPath.row] objectForKey:@"area"];
    
    cell.deaddlabel.text=[[array  objectAtIndex:indexPath.row] objectForKey:@"deaddress"];
   NSNumber *b=     [[array objectAtIndex:indexPath.row] objectForKey:@"flag"];
           if (b.integerValue==1) {
        cell.conslabel.textColor=[UIColor redColor];
        //cell.conslabel.textColor=[UIColor redColor];
        sf=1;
        zhen=(int)indexPath.row;
       
       
    }else{
    
    cell.conslabel.textColor=[UIColor blackColor];
    }
       
        void(^DefaultBlock)(NSInteger text)=^(NSInteger text){
            if (text==1) {
                AdressViewController *ad=[[AdressViewController alloc]init];
                ad.flage=0;
                NSDictionary *dics=[array  objectAtIndex:indexPath.row];
                ad.d=dics;
                ad.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:ad animated:YES];
                
                
            }else if (text==2){
            
               
                flage=2;
                sf=1;
                hang=(int)indexPath.row;
                [self postMethod];
            }
            
            
        
        };
        
        cell.myblock=DefaultBlock;
        
    }
    
//    void(^backDefaultBlock)(NSInteger text)=^(NSInteger text){
//        cell.button.backgroundColor=[UIColor colorWithRed:146.0/255.0 green:208.0/255.0 blue:76.0/255.0 alpha:1];
//        cell.button1.backgroundColor=[UIColor colorWithRed:146.0/255.0 green:208.0/255.0 blue:76.0/255.0 alpha:1];
//        
//    };
//    
//    _backblock=backDefaultBlock;
    



    return cell;
}
#pragma mark 修改地址
-(void)pushxg:(UITapGestureRecognizer *)g{
    AdressViewController *ad=[[AdressViewController alloc]init];
    ad.flage=0;
    NSDictionary *dics=[array  objectAtIndex:g.view.tag];
    ad.d=dics;
    ad.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ad animated:YES];
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    
//    AdressViewController *ad=[[AdressViewController alloc]init];
//    ad.flage=0;
//    NSDictionary *dics=[array  objectAtIndex:indexPath.row];
//    ad.d=dics;
//    ad.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:ad animated:YES];
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark 删除 默认
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
UITableViewRowAction *delete=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    
    flage=1;
    hang=(int)indexPath.row;
    [self postMethod];

}];
    
    UITableViewRowAction *moren=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"默认" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
       
        flage=2;
        sf=1;
        hang=(int)indexPath.row;
        [self postMethod];
       
    }];
    return @[delete,moren];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    //if (_backblock) {
     //   _backblock(1);
    //}
    //[tableView reloadData];

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
