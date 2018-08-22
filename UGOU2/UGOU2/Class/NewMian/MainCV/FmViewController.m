//
//  FmViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/12/23.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import "FmViewController.h"
#import "DdViewController.h"

#import "FmTableViewCell.h"
//#import <CoreLocation/CoreLocation.h>
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "PpViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "StoresmapViewController.h"
#import "MapModel.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MBProgressHUD.h"
@interface FmViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate,AMapSearchDelegate,CLLocationManagerDelegate>{
    

    UIBarButtonItem *leftbut;
    NSString *dz;
    NSMutableArray *muarr;
    UIBarButtonItem *left;
    NSString *city;
    UIAlertView *alert1;
    NSDictionary *_dicss;
    NSMutableArray *_dataarray;
    CGFloat latitude;
    CGFloat longitude;
    UITableView * table;
    NSInteger _p;
    NSInteger _ps;
   CLLocationManager  *locationManager;
    AMapSearchAPI *search;
    MBProgressHUD *HUB;
   
}
@end
@implementation FmViewController

- (void)viewDidLoad {
    //NSString *latitude1=@"36.65330591";
   // NSString *longtiude=@"117.08966732";
    //latitude =latitude1.floatValue;
    //longitude=longtiude.floatValue;
    [super viewDidLoad];
    [self addnavigation];
    muarr=[NSMutableArray array];
    _dataarray=[NSMutableArray array];
    _p=0;
    _ps=0;
    [self addheadview];
    [self json];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=NO;
    
    self.tabBarController.tabBar.hidden =YES;
    //NSLog(@"hhjvghcjhgcccjfc");
    self.navigationController.navigationBar.hidden =NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.tabBarController.tabBar.hidden=NO;
    //self.navigationController.navigationBar.hidden=NO;
}
-(void)addnavigation{
    #pragma mark  导航栏
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=@"附近门店";
    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
    self.navigationItem.titleView=label;
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"定位@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(pushmapview)];
    leftbut = [[UIBarButtonItem alloc]initWithTitle:@"定位…" style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem=rightButton;
    self.navigationItem.leftBarButtonItems=@[left,leftbut];
    //self.navigationController.navigationBar.translucent=NO;
    
    //[self addheadview];
}
//  查看在地图得位置
-(void)pushmapview{

    StoresmapViewController *mapst=[[StoresmapViewController alloc] init];
    mapst.maparray=muarr;
    mapst.city=city;
    [self.navigationController pushViewController:mapst animated:YES];


}
-(void)pop{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dingwei{
    #pragma mark 地址


}

-(void)addheadview{
    [AMapServices sharedServices].apiKey =MAPKEY;
    [[AMapServices sharedServices]setEnableHTTPS:YES];
//    locationManager = [[AMapLocationManager alloc] init];
//    locationManager.delegate = self;
//    search = [[AMapSearchAPI alloc] init];
//    search.delegate = self;
    
    
    if (![CLLocationManager locationServicesEnabled]) {
        //[Uikility alert:@"定位不可用"];
    }
    locationManager=[[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus]==0) {
        [locationManager requestWhenInUseAuthorization];
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0) {
        //[_locationmanger requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }else{
        [locationManager startUpdatingLocation];
        
    }
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=1000.0;
    locationManager.delegate=self;

    
    
    
    [locationManager startUpdatingLocation];
    HUB=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUB.color=[UIColor grayColor];
    HUB.labelText=@"正在获取位置信息.....";
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        ////////////////////////NSLog(@"等待用户授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse)
        
    {
        
        // 开始定位
        
        
        [locationManager startUpdatingLocation];
        
    }else
    {
        leftbut = [[UIBarButtonItem alloc]initWithTitle:@"定位失败" style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
            self.navigationItem.leftBarButtonItems=@[left,leftbut];
        [self json];
    }
    
    
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location=[locations firstObject];
    
    latitude=location.coordinate.latitude;
      longitude=location.coordinate.longitude;
    if (_p==0) {
        
        search = [[AMapSearchAPI alloc] init];
        search.delegate = self;
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        //NSLog(@"%f,%f",location.coordinate.latitude,location.coordinate.longitude);
        regeo.location= [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        regeo.requireExtension= YES;
        [search AMapReGoecodeSearch:regeo];
        
        
        _p++;
    }
    [locationManager stopUpdatingLocation];
    //}];
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    leftbut = [[UIBarButtonItem alloc]initWithTitle:@"定位失败" style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
    self.navigationItem.leftBarButtonItems=@[left,leftbut];

}

////定位成功
//-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
//    latitude=location.coordinate.latitude;
//    longitude=location.coordinate.longitude;
//    if (reGeocode.adcode != nil){
//        
//        NSUserDefaults *    de=[NSUserDefaults standardUserDefaults];
//        
//        [de setObject:reGeocode.adcode forKey:@"placename"];
//        leftbut = [[UIBarButtonItem alloc]initWithTitle:reGeocode.district style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
//        self.navigationItem.leftBarButtonItems=@[left,leftbut];
//        if (_p==0) {
//            [self json];
//            _p++;
//        }
//
//       
//    }else{
//        
//        search = [[AMapSearchAPI alloc] init];
//        search.delegate = self;
//        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//        
//        regeo.location= [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
//        regeo.requireExtension= YES;
//        [search AMapReGoecodeSearch:regeo];
//        
//    }
//
//
//    [locationManager stopUpdatingLocation];
// }
//-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
//    NSLog(@"定位失败%@",error);
//    
//    leftbut = [[UIBarButtonItem alloc]initWithTitle:@"定位失败" style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
//    self.navigationItem.leftBarButtonItems=@[left,leftbut];
//}
//高德地图逆地理编码成功的代理
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
    
    if (response.regeocode != nil){
        if (_ps==0) {
           
         NSUserDefaults*   de=[NSUserDefaults standardUserDefaults];
            //[de removeObjectForKey:@"placeid"];
            [de setObject:response.regeocode.addressComponent.adcode forKey:@"placename"];
            [de setObject:response.regeocode.addressComponent.district forKey:@"cityname"];
            leftbut = [[UIBarButtonItem alloc]initWithTitle:response.regeocode.addressComponent.district style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
            self.navigationItem.leftBarButtonItems=@[left,leftbut];
            [self json];
            _ps++;
        }
        
    }
}


#pragma mark tableview
-(void)addtableview{
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    table.rowHeight=130*KIphoneWH;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
    table.tableHeaderView=view;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return muarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    FmTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[FmTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    if (_dataarray.count) {
        MapModel *shopmodel=[_dataarray objectAtIndex:indexPath.row];
        NSString *im=shopmodel.logopicUrl;
       [cell.logopicUrl sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];
       cell.shopName.text=shopmodel.shopName;
        NSString *Addr=shopmodel.shopAddr;
    cell.shopAddr.text=[NSString stringWithFormat:@"地址 %@",Addr];
    
        NSString *tele=shopmodel.shopTele;
    cell.shopTele.text=[NSString stringWithFormat:@"电话 %@",tele];
        CGFloat distance=shopmodel.distance/1000;
    cell.distancelable.text=[NSString stringWithFormat:@"%.1f千米",distance];
    if (shopmodel.businessHours) {
        NSString * business=shopmodel.businessHours;
      cell.businessHours.text=[NSString stringWithFormat:@"营业时间 %@",business];
    }else{
    
    cell.businessHours.text=@"营业时间 ";
    }
        cell.Ydbut.layer.cornerRadius=5*KIphoneWH;
    if (_flag==2) {
        
        [cell.Ydbut. layer setBorderWidth:1];
        cell.Ydbut.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
        [cell.Ydbut setTitle:@"我要预订" forState:UIControlStateNormal];
        cell.Ydbut.titleLabel.font=[UIFont systemFontOfSize:10*KIphoneWH];
        
        [cell.Ydbut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        
    }else if (_flag==3){
        [cell.Ydbut.layer setBorderWidth:1];
        
        cell.Ydbut.layer.borderColor=[[UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1]CGColor];
        [cell.Ydbut setTitle:@"上门试衣" forState:UIControlStateNormal];
        cell.Ydbut.titleLabel.font=[UIFont systemFontOfSize:10*KIphoneWH];
        
        [cell.Ydbut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [cell.Ydbut addTarget:self action:@selector(pushyd:) forControlEvents:UIControlEventTouchUpInside];
    cell.Ydbut.tag=indexPath.row;
    }
    
    return cell;
    
    
}
-(void)pushyd:(UIButton *)b{
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *now;
    NSDateComponents  *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
   
    MapModel *model =[_dataarray objectAtIndex:indexPath.row];
    
    if (model.businessHours) {
        
        if([  model.businessHours   rangeOfString:@"-"].location !=NSNotFound)//_roaldSearchText
    {
       
        
        NSArray  * imarray= [ model.businessHours  componentsSeparatedByString:@"-"];
        ////////////////////////NSLog(@"%@",imarray);
        NSString *s1 =[imarray objectAtIndex:0];
        if([s1 rangeOfString:@":"].location !=NSNotFound)//_roaldSearchText
        {
           
            
            NSArray  * imarrays= [s1 componentsSeparatedByString:@":"];
            int a=[[imarrays objectAtIndex:0]intValue];
           
            if (comps.hour<a) {
                [Uikility alert:@"不在预定时间！"];
                return;
            }else if (comps.hour==a){
                int b=[[imarrays objectAtIndex:1]intValue];
                if (comps.minute<b) {
                     [Uikility alert:@"不在预定时间！"];
                    return;
                }else{
                    NSString *s2=[imarray objectAtIndex:1];
                   
                    if([s2 rangeOfString:@":"].location !=NSNotFound)//_roaldSearchText
                    {
                        
                        
                        NSArray  * imarrayss= [s2 componentsSeparatedByString:@":"];
                        int as=[[imarrayss objectAtIndex:0]intValue];
                        //int b=[comps hour];
                        ////////////////////////NSLog(@"%d",as);
                        if (comps.hour>as) {
                            [Uikility alert:@"不在预定时间！"];                            return;
                        }else if (comps.hour==as){
                            int bs=[[imarrayss objectAtIndex:1]intValue];
                            if (comps.minute>bs) {
                                 [Uikility alert:@"不在预定时间！"];
                                return;
                            }else{
                                PpViewController *pp=[[PpViewController alloc]init];
                               // pp.hidesBottomBarWhenPushed=YES;
                                pp.appstoreId=model.id;
                                pp.appbrandId=[NSString stringWithFormat:@"%zd",model.appbrandId.integerValue];
                                pp.flag=_flag;
                                
                                pp.dic=[muarr objectAtIndex:indexPath.row];
                                pp.model=model;
                                [self.navigationController pushViewController:pp animated:NO];
                                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                            }
                        }else{
                            PpViewController *pp=[[PpViewController alloc]init];
                           // pp.hidesBottomBarWhenPushed=YES;
                            pp.appstoreId=model.id;
                            pp.flag=_flag;
                            
                            pp.appbrandId=[NSString stringWithFormat:@"%zd",model.appbrandId.integerValue];
                            
                            
                            pp.model=model;
                            pp.dic=[muarr objectAtIndex:indexPath.row];
                            [self.navigationController pushViewController:pp animated:NO];
                            [tableView deselectRowAtIndexPath:indexPath animated:YES];
                        }
                    }
                    
                }
            }else{
                NSString *s2=[imarray objectAtIndex:1];
                ////////////////////////NSLog(@"%@--%@",s1,s2);
                if([s2 rangeOfString:@":"].location !=NSNotFound)//_roaldSearchText
                {
                    ////////////////////////NSLog(@"yes");
                    
                    NSArray  * imarrayss= [s2 componentsSeparatedByString:@":"];
                    int as=[[imarrayss objectAtIndex:0]intValue];
                    //int b=[comps hour];
                    ////////////////////////NSLog(@"%d",as);
                    if (comps.hour>as) {
                        [Uikility alert:@"不在预定时间！"];
                        return;
                    }else if (comps.hour==as){
                        int bs=[[imarrayss objectAtIndex:1]intValue];
                        if (comps.minute>bs) {
                            [Uikility alert:@"不在预定时间！"];
                            return;
                        }else{
                            PpViewController *pp=[[PpViewController alloc]init];
                           // pp.hidesBottomBarWhenPushed=YES;
                            pp.appstoreId=model.id;
                            pp.appbrandId=[NSString stringWithFormat:@"%zd",model.appbrandId.integerValue];
                            pp.flag=_flag;
                            pp.model=model;
                            pp.dic=[muarr objectAtIndex:indexPath.row];
                            [self.navigationController pushViewController:pp animated:NO];
                            [tableView deselectRowAtIndexPath:indexPath animated:YES];
                        }
                    }else{
                        PpViewController *pp=[[PpViewController alloc]init];
                       // pp.hidesBottomBarWhenPushed=YES;
                        pp.appstoreId=model.id;
                        pp.appbrandId=[NSString stringWithFormat:@"%zd",model.appbrandId.integerValue];
                        pp.model=model;
                        pp.flag=_flag;
                         //////////////////////NSLog(@"%@--------%zd",pp.appbrandId,_flag);
                        //pp.dic=[muarr objectAtIndex:indexPath.row];
                        [self.navigationController pushViewController:pp animated:NO];
                        [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    }
                }
                
            }
        }
        
    }
    }else{
        PpViewController *pp=[[PpViewController alloc]init];
        // pp.hidesBottomBarWhenPushed=YES;
        pp.appstoreId=model.id;
        pp.appbrandId=[NSString stringWithFormat:@"%zd",model.appbrandId.integerValue];
        pp.flag=_flag;
        pp.model=model;
         //////////////////////NSLog(@"%@--------%zd",pp.appbrandId,_flag);
        pp.dic=[muarr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:pp animated:NO];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    }
    
}

#pragma mark 数据
-(void)json{
   
    [_dataarray removeAllObjects];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    //if ([de objectForKey:@"userId"]) {
        ////////////////////////NSLog(@"%@",leftbut.title);
        if([leftbut.title rangeOfString:@"市"].location !=NSNotFound)//_roaldSearchText
        {
           
           
           
            //city=[imarray objectAtIndex:0];
            if ([de objectForKey:@"placename"]) {
                city=[de objectForKey:@"placename"];
            }
            
        }else{
           // city=leftbut.title;
            if ([de objectForKey:@"placename"]) {
                city=[de objectForKey:@"placename"];
            }
        }
        
    if ([de objectForKey:@"userId"]) {
        if ([de objectForKey:@"newUserId"]) {
            _dicss=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"area":city,@"model":@true,@"ios_version":VERSION
                     };
        }else{
            _dicss=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"area":city,@"model":@true,@"ios_version":VERSION
                     };
        }
        
        
    }else{
        _dicss=@{@"area":city,@"model":@true,@"ios_version":VERSION};
    
    }
        
    

        
        NSDictionary *json1=[Uikility initWithdatajson:_dicss];
    
    NSString *    urls=[BassAPI requestUrlWithPorType:PortTypeoNearbystores];
   
    [AFManger postWithURLString:urls parameters:json1 success:^(id responseObject) {
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[strs objectForKey:@"success"] boolValue];
 
        if (success) {
            //NSLog(@"%@",strs);
            muarr=[strs objectForKey:@"data"];
            for (NSDictionary *dic in muarr) {
                MapModel *model=[MapModel initWithModeldic:dic];
                NSDictionary *showdic=[dic objectForKey:@"appbrandId"];
                model.showpic=[showdic objectForKey:@"showpic"];
                model.appbrandId=[showdic objectForKey:@"id"];
                [_dataarray  addObject:model];
         
            }
            
            
            [self addtableview];
            
            [self  distance];
            //[HUB hide:YES];
        }else{
            [HUB hide:YES];
            [Uikility alert:[strs objectForKey:@"msg"]];
        }

        
    } failure:^(NSError *error) {
        [HUB hide:YES];
         [Uikility alert:@"数据接受失败！"];
    }];
    
}
#pragma mark------计算距离自己的距离，由近到远排序
-(void)distance{
    if (_dataarray.count>1) {
    for (int i=0; i<_dataarray.count-1; i++) {
        
   for (int j=0; j<_dataarray.count-i-1;j++) {
            MapModel *model=[_dataarray objectAtIndex:j];
       
            MapModel *model1=[_dataarray objectAtIndex:j+1];
      
           MAMapPoint point1=MAMapPointForCoordinate(CLLocationCoordinate2DMake(latitude, longitude));
            MAMapPoint point2=MAMapPointForCoordinate(CLLocationCoordinate2DMake(model.latitude.floatValue, model.longitude.floatValue));
            MAMapPoint point3=MAMapPointForCoordinate(CLLocationCoordinate2DMake(model1.latitude.floatValue, model1.longitude.floatValue));
            CLLocationDistance distance=MAMetersBetweenMapPoints(point1, point2);
            CLLocationDistance distance1=MAMetersBetweenMapPoints(point1, point3);
           model.distance=distance;
           model1.distance=distance1;
       
       
            if ( model.distance >model1.distance) {
              _dataarray[j]=model1;
               _dataarray[j+1]=model;
               
           }
       }
    }
    
   // [table reloadData];
    }else{
    
        for (int j=0; j<_dataarray.count;j++) {
            
            
            MapModel *model=[_dataarray objectAtIndex:j];
            
           
                       MAMapPoint point1=MAMapPointForCoordinate(CLLocationCoordinate2DMake(latitude, longitude));
            MAMapPoint point2=MAMapPointForCoordinate(CLLocationCoordinate2DMake(model.latitude.floatValue, model.longitude.floatValue));
           
            CLLocationDistance distance=MAMetersBetweenMapPoints(point1, point2);
          
            
            model.distance=distance;
           _dataarray[j]=model;
        }
        
    }
    [HUB hide:YES];
    
    [table reloadData];

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
