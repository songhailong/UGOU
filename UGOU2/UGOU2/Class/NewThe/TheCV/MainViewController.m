//
//  MainViewController.m
//  UgouAppios
//

//  Created by 靓萌服饰 on 15/9/23.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.9.21.4.24 tableview 主页
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "MainViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "TableViewCell.h"
#import "SpViewController.h"
#import "BrandViewController.h"
#import "TheViewController.h"
#import "MyViewController.h"
#import "CartViewController.h"
#import "QdqViewController.h"
#import "SmViewController.h"
#import "DdViewController.h"
#import "UbViewController.h"
#import "MBProgressHUD.h"
#import "LPLabel.h"
#import "FmViewController.h"
#import "MainCollectionViewCell.h"
#import "ReusableView.h"
#import "CartModel.h"
#import "FMDBSingleTon.h"
#import "InsiderViewController.h"
#import "ThemeViewController.h"
#import "Btbutton.h"
#import "MainHearViewController.h"
#import "KjViewController.h"
#import "Activity618ViewController.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "RegionViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CeShiViewController.h"
#import "SaoTableView.h"
#import "UGSweepYardViewController.h"
#import "SweepPayViewController.h"
#import "DgViewController.h"
#import "LocateFailureView.h"
#import "UGHeader.h"
#import <AVFoundation/AVFoundation.h>
#import "MSdetailsViewController.h"
@interface MainViewController ()<MBProgressHUDDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PlaceselectDelegate,UIAlertViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,MAMapViewDelegate,CLLocationManagerDelegate,UGCustomnNavViewDelegate>
{
    LPLabel *lplabel;
    
    UIBarButtonItem *leftitem;
    
     NSArray *banner;
     NSArray *category;
     NSArray *recommend;
     NSArray *activity;
     NSMutableArray *appgoodsid;
     int hang;
     NSDictionary *dic;
     NSDictionary *d;
    // MBProgressHUD *hud;
    UIImageView *ima;
    UICollectionView *_collectionview;
    NSUserDefaults *de;
    CLLocationManager *_locationmanger;
    NSInteger _p;
    UILabel *_leftlable;
    AMapLocationManager  *locationManager;
    AMapSearchAPI *search;
    UIImageView *_imageview;
    
    
    UIButton * _loctionbutton;
    
    UIButton *_adressbutton;
    
    
    MAMapView *_mapview;
    
    UIButton *backgroudView;
    SaoTableView *  saoview;
    
    LocateFailureView*failView;
    //导航栏
    UGCustomNavView *navView;
    //导航栏右按钮点击
    BOOL isNavRightSelect;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hang=1;
    _p=0;
    self.view.backgroundColor=[UIColor whiteColor];
    appgoodsid=[NSMutableArray array];
    [self.view removeFromSuperview];
     //[self startlocation];
    //[self creatNav];
    [self loicationauthorization];

    //[self addheadview];
   // [self addtableview];
    
    [self getBestNewVerson];
    //self.view.safeAreaInsets;
    //safeAreaLayoutGuide的顶部显示了视图(e)的未被遮挡的顶部边缘。g,不支持
    //状态栏或导航栏，如果存在)。对于其他边也是一样。
    //self.view.safeAreaLayoutGuide;
   // NSLog(@"高度%f",self.view.frame.size.height);
 
  //NSString *sss=[[NSUserDefaults standardUserDefaults] objectForKey:@"ssss"];
    
   #pragma mark 等待框
  

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //[self creatNav];
    //[self getcooike];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden = YES;
    de = [NSUserDefaults standardUserDefaults];
    [self creatUInav];
    //[self getcooike];
   // [self creatNav];
    
   
    [self getcooike];
   
    
    
}
-(void)creatUInav{
    NSString *str=nil;

    navView=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    //NSLog(@"导航栏高度%lf",NavHeight);
    navView.Delegate=self;
    [navView.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    if ([de objectForKey:@"district"]) {
        str=[de objectForKey:@"district"];
    }else{
        str=@"济南市";
    }
    [navView.leftButton setTitle:str forState:UIControlStateNormal];
    [navView setrightImage:[UIImage imageNamed:@"addfollow"]];
    //[navView.RightButton setImage:[UIImage imageNamed:@"addfollow"] forState:UIControlStateNormal];
    [self.view addSubview:navView];
    
    UIImageView *label=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-25*KIphoneWH, 27*KIphoneWH, 50*KIphoneWH, 25*KIphoneWH)];
    label.image=[UIImage imageNamed:@"logo"];
    if (iPhoneX) {
        label.frame=CGRectMake(WIDTH/2-25, 50, 50, 30);
    }
    navView.custemView=label;
    
}
-(void)rightItemAction{
    isNavRightSelect=!isNavRightSelect;
    [self pushsearch];
}
-(void)creatNav{
    self.navigationController.navigationBar.hidden=YES;
    UIButton *leftbutton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 74*KIphoneWH, 64)];
    _leftlable=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 54*KIphoneWH, 30)];
    de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"district"]) {
        _leftlable.text=[de objectForKey:@"district"];
    }else{
        _leftlable.text=@"济南市";
    }
    //_leftlable.text=@"济南市";
    _leftlable.textColor=[UIColor whiteColor];
    _leftlable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [leftbutton addSubview:_leftlable];
    
    [leftbutton addTarget:self action:@selector(leftpush) forControlEvents:UIControlEventTouchUpInside];
   
    self.tabBarController.tabBar.hidden = NO;
    UIImageView *label=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-25, 25, 50, 30)];
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
    _imageview.image=image;
    //_imageview.backgroundColor=[UIColor greenColor];
    
    _imageview.userInteractionEnabled=YES;
    label.image=[UIImage imageNamed:@"logo"];
    [_imageview addSubview:label];
    UIButton * rightbutton=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-60, 20, 60, 44)];
    //[rightbutton addTarget:self action:@selector(pushsearch:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightimage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    rightimage.image=[UIImage imageNamed:@"addfollow"];
    [rightbutton addSubview:rightimage];
    //rightbutton.backgroundColor=[UIColor whiteColor];
    [_imageview addSubview:rightbutton];
    [self.view addSubview:_imageview];
    [_imageview  addSubview:leftbutton];
    
    
    
}
-(void)leftpush{
   


}
//选择地区的代理回调
-(void)selectpalecereload:(NSNumber *)paleceid placename:(NSString *)placename{
    
    [de setObject:placename forKey:@"placename"];
   
    _leftlable.text=placename;
    hang=1;
    [self json];

}
#pragma mark***** 高德地图定位成功
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
 
    if (reGeocode.adcode) {
        
        if (_p==0) {
            
            de=[NSUserDefaults standardUserDefaults];
            //[de removeObjectForKey:@"placeid"];
            
            [de setObject:reGeocode.adcode forKey:@"placename"];
            _leftlable.text=reGeocode.district;
//            [self.view removeFromSuperview];
//            [self addheadview];
//            [self addtableview];
            [self json];
            _p++;
        }

        
    }else{
     //定位成功后逆地理编码
        search = [[AMapSearchAPI alloc] init];
        search.delegate = self;
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location= [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        regeo.requireExtension= YES;
        [search AMapReGoecodeSearch:regeo];
        [locationManager stopUpdatingLocation];
    }

}
-(void)cReatAltiview{
    UIAlertView *alteview=[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请进入系统《设置》《隐私》《定位服务》中打开开关，并允许U购使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
    alteview.tag=10;
    [alteview show];

}
#pragma mark********定位失败
-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{

    navView.leftButton.titleLabel.text=@"定位失败";
    [de removeObjectForKey:@"placename"];
    [self readIsPlace];

}
//高德地图逆地理编码成功的代理
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{   if (response.regeocode != nil){
         //if (_p==0) {
        
        de=[NSUserDefaults standardUserDefaults];
        //[de removeObjectForKey:@"placeid"];
  
    
    //isLocation=YES;
    [de setBool:YES forKey:isLocationSucess];
    
    
        [de setObject:response.regeocode.addressComponent.adcode forKey:@"placename"];
       [de setObject:response.regeocode.addressComponent.district forKey:@"district"];
   navView.leftButton.titleLabel.text=response.regeocode.addressComponent.district;
            failView.alpha=0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationSucess" object:nil];
             [self addheadview];
             [self addtableview];
             [self json];
             //_p++;
         //}
        
    }
}
#pragma mark**********创建地图用地图定位
-(void)creatMapView{
    _mapview=[[MAMapView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/2)];
   
    
    _mapview.delegate=self;
    //用户
    _mapview.showsUserLocation=YES;
    //跟踪
    _mapview.userTrackingMode=MAUserTrackingModeNone;
    _mapview.allowsBackgroundLocationUpdates=NO;


}
#pragma mark********地图定位成功
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
   
    //定位成功后逆地理编码
    if (_p==0) {
        
        
        
        
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location= [AMapGeoPoint locationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    regeo.requireExtension= YES;
    [search AMapReGoecodeSearch:regeo];
    [locationManager stopUpdatingLocation];
        _p++;
    }
}

-(void)loicationauthorization{
    if (![CLLocationManager locationServicesEnabled]) {
        //[Uikility alert:@"定位不可用"];
    }
    _locationmanger=[[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus]==0) {
        [_locationmanger requestWhenInUseAuthorization];
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0) {
        //[_locationmanger requestAlwaysAuthorization];
        [_locationmanger requestWhenInUseAuthorization];
    }else{
        [_locationmanger startUpdatingLocation];
        
    }
    _locationmanger.desiredAccuracy=kCLLocationAccuracyBest;
    _locationmanger.distanceFilter=1000.0;
    _locationmanger.delegate=self;
    
}

//授权成功
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        ////////////////////////NSLog(@"等待用户授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse)
        
    {
        [_locationmanger startUpdatingLocation];
        
    }else
    {
        _leftlable.text=@"定位失败";
        [de removeObjectForKey:@"placename"];
        [self readIsPlace];
//        if (isLocation) {
//            [de setObject:@"370101" forKey:@"placename"];
//        }else{
//        [self creatLocateFailView];
//        }
        
        
    }
    
    
    
    
}
-(void)readIsPlace{
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeStartpicture];
    NSDictionary *dicurl=nil;
    
   
   dicurl=@{@"model":@1,@"ios_version":VERSION};
    
    
    NSDictionary *jsondic=[Uikility initWithdatajson:dicurl];
    
    [AFManger postWithURLString:url parameters:jsondic success:^(id responseObject) {
        id  object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        Boolean  secess=[[object objectForKey:@"success"] boolValue];
        if (secess) {
            
           
            NSDictionary *dic1=[object objectForKey:@"data"];
           
         NSNumber * isplace =[dic1 objectForKey:@"locationFlag"];
            if (isplace.integerValue==1) {
               
                failView.alpha=0;
                [de setObject:@"370102" forKey:@"placename"];
                [self addheadview];
                [self addtableview];
                [self json];
            }else if(isplace.integerValue==0){
                
                [self creatLocateFailView];
            }else if(isplace==nil){
               
              [self creatLocateFailView];
            
            }
            
            
        }else{
        
         [self creatLocateFailView];
        }
        
    } failure:^(NSError *error) {
        
    }];



}
-(void)creatLocateFailView{
    
    //if([de objectForKey:@"placename"]){
    failView=[[LocateFailureView  alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-40)];
    failView.alpha=1;
    [self.view addSubview:failView];
   // }else{
    
    
   // }

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location=[locations firstObject];
    
    
    if (_p==0) {
        
        search = [[AMapSearchAPI alloc] init];
        search.delegate = self;
        
        
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location= [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        regeo.requireExtension= YES;
        [search AMapReGoecodeSearch:regeo];
        
        
        _p++;
    }
    [_locationmanger stopUpdatingLocation];
    //}];
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
   
        _leftlable.text=@"定位失败";
        [de removeObjectForKey:@"placename"];
        [self readIsPlace];
   
    

}

-(void)againloction:(UIButton *)bt{
    //[self startlocation];

}
-(void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
   
    NSString *errorstr=[NSString stringWithFormat:@"%@",error];
    [Uikility alert:errorstr];
 
    _leftlable.text=@"定位失败";
    [de removeObjectForKey:@"placename"];
    [self readIsPlace];
}

#pragma mark**********alteview的代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
    }else if (buttonIndex==1){
        
        if (alertView.tag==10) {
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else if (alertView.tag==100){
        
            [self loicationauthorization];
            
        
        }else if (alertView.tag==300){
        
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/u-gou/id1100111597?mt=8"]];
        
        }
    
    }

}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat offset=_collectionview.contentOffset.y;
//    if (offset<HEIGHT) {
//       [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1"] forBarMetrics:UIBarMetricsDefault];
//    }else{
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"下拉后顶部导航"] forBarMetrics:UIBarMetricsDefault];
//    }
//}
#pragma mark ****************点击加号
-(void)pushsearch{
        backgroudView=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        backgroudView.alpha=0.4;
        backgroudView.backgroundColor=[UIColor blackColor];
        [self.view addSubview:backgroudView];
    
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapRes:)];
        
        [backgroudView addGestureRecognizer:tapGesture];
        saoview=[[SaoTableView alloc] initWithFrame:CGRectMake(WIDTH-160*KIphoneWH, NavHeight+15*KIphoneWH, 150*KIphoneWH, 50*KIphoneWH)];
        saoview.alpha=1;
        void (^saoPayblcok)(NSInteger text)=^(NSInteger text){
        
            backgroudView.alpha=0;
            saoview.alpha=0;
            
            
            if (text==0) {
                
                //跳转到搜索界面
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                    if ([def objectForKey:@"placename"]) {
                        SearchViewController *search11=[[SearchViewController alloc]init];
                        //search.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:search11 animated:YES];
                    }else{
               
                    
                    }

                
            }else if (text==1){
                NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if(status == AVAuthorizationStatusAuthorized||status==AVAuthorizationStatusNotDetermined) {
                    if ([def objectForKey:@"placename"]) {
                        SweepPayViewController *ug=[[SweepPayViewController alloc] init];
                        //UGSweepYardViewController *ug =      [[UGSweepYardViewController alloc] init];
                        [self.navigationController pushViewController:ug animated:YES];
                        
                        
                    }
                } else {
                    //[SVProgressHUD showWithStatus:tips];
                    // []
                    //[self setupCamera];
                    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“U购”打开相机访问权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    
                    [alert show];
                }
            
            }
        
        
        };
       saoview.saosblock=saoPayblcok;
       [self.view addSubview:saoview];
 }

-(void)handletapRe{
    
}
#pragma mark***********手势监听事件
-(void)handletapRes:(UITapGestureRecognizer*)tapGes{
    backgroudView.alpha=0;
    saoview.alpha=0;

}
+(void) dimissAlert:(UIAlertView *)alert {
    if(alert)     {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        
    }
}

#pragma mark  tableview
-(void)addtableview{
    self.automaticallyAdjustsScrollViewInsets=YES;
    if (IPHONEVERSION.floatValue>=10.0) {
     _collectionview.contentInset=UIEdgeInsetsMake(0, NavHeight, WIDTH, HEIGHT-NavHeight);
    }else{
        _collectionview.contentInset=UIEdgeInsetsMake(0, NavHeight, WIDTH, HEIGHT-NavHeight);
    
    }
    //_collectionview.backgroundColor=[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    if(IPHONEVERSION.floatValue>=10.0){
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) collectionViewLayout:flowlayout];
    
    }else{
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-64) collectionViewLayout:flowlayout];
    }
    
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:_collectionview];
    [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];
    [_collectionview registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _collectionview.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
          //[appgoodsid removeAllObjects];
          hang=1;
          [self json1];
          [_collectionview.header endRefreshing];
      }];
    
}
#pragma mark 头视图
-(void)addheadview{
    _headview=[[UIView alloc]initWithFrame:CGRectMake(0, 5*KIphoneWH, WIDTH, 530*KIphoneWH+150*activity.count*KIphoneWH+50*KIphoneWH)];
    
    _headview.userInteractionEnabled=YES;
     _headview.backgroundColor=[UIColor whiteColor];
    //2015.10.19.1.6 加数据
    #pragma mark 按钮 类目
    UIScrollView *butscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, WIDTH, 30*KIphoneWH)];
    butscroll.tag=100;
    butscroll.scrollEnabled=YES;
    butscroll.showsHorizontalScrollIndicator=false;
    int a=0;
    int b=(category.count)%4;
    if (b==0) {
        a=(int)(category.count)/4;
    }else{
        a=(int)(category.count)/4+1;
    }
    butscroll.contentSize=CGSizeMake(WIDTH*a, 30*KIphoneWH);
    
    for (int i=0; i<category.count; i++) {
        NSString *title=[[category objectAtIndex:i]objectForKey:@"name"];
        UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
        but.tag=i+1;
        [but setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
         but.frame=CGRectMake(20*KIphoneWH+((WIDTH-50*KIphoneWH)/4+10*KIphoneWH)*i, 0, (WIDTH-50*KIphoneWH)/4, 30*KIphoneWH);
        [but setTitle:title forState:UIControlStateNormal];
        [but addTarget:self action:@selector(pushbut:) forControlEvents:UIControlEventTouchUpInside];
        [butscroll addSubview:but];
    }
    [_headview addSubview:butscroll];
    #pragma mark 滚动图
    _headscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50*KIphoneWH, WIDTH, 150*KIphoneWH)];
    _headscroll.contentSize=CGSizeMake(WIDTH *banner.count, 150*KIphoneWH);
    _headscroll.pagingEnabled = YES;
    _headscroll.scrollEnabled = YES;
    _headscroll.delegate = self;
    _headscroll.tag=200;
    for (int i=0; i<banner.count; i++) {
        NSString *im=[[banner objectAtIndex:i]objectForKey:@"image"];
        UIImageView *imageView=[[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];
        imageView.frame=CGRectMake(WIDTH*i, 0, WIDTH, 150*KIphoneWH);
        #pragma mark 2015.10.21.1.30 图片点击
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushshangpin:)];
        imageView.tag=i+1;
        [imageView addGestureRecognizer:imgtap];
       [_headscroll addSubview:imageView];
        
    }
    [_headview addSubview:_headscroll];
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 170*KIphoneWH, 40*KIphoneWH, 30*KIphoneWH)];
    _page.numberOfPages = banner.count;
    [_page addTarget:self action:@selector(sender:) forControlEvents:UIControlEventEditingChanged];
    [self performSelector:@selector(video) withObject:nil afterDelay:1.5];
    [_headview addSubview:_page];
    #pragma mark 签到
    NSArray *arrays=@[@"Main签到",@"上门试衣",@"到店预定",@"u币00"];
    for (int i=0; i<arrays.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        button.tag=i+1;
        button.frame=CGRectMake(20*KIphoneWH+i*((WIDTH-160*KIphoneWH)/4+40*KIphoneWH), 210*KIphoneWH, (WIDTH-160*KIphoneWH)/4, 50*KIphoneWH);
        [button setBackgroundImage:[UIImage imageNamed:[arrays objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        [_headview addSubview:button];
        }
    NSArray *arrb=@[@"签到",@"上门试衣",@"到店预订",@"U币"];
    for (int i=0; i<arrb.count; i++) {
        UIButton *but=[[UIButton alloc]init];
        but.tag=i+1;
        [but setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
        but.titleLabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
        but.frame=CGRectMake(5*KIphoneWH+i*((WIDTH-40*KIphoneWH)/4+10*KIphoneWH), 260*KIphoneWH, (WIDTH-40*KIphoneWH)/4, 30*KIphoneWH);
        
        [but setTitle:[arrb objectAtIndex:i]forState:UIControlStateNormal];
        [but addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        [_headview addSubview:but];
    }
    [self addview];
}
#pragma mark 头视图 流行指南 最新活动
-(void)addview{
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"绿方框"]];
    img.frame=CGRectMake(0, 300*KIphoneWH, 10*KIphoneWH, 40*KIphoneWH) ;
    [_headview addSubview:img];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25*KIphoneWH, 300*KIphoneWH, 200*KIphoneWH, 40*KIphoneWH)];
    label.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    label.font=[UIFont systemFontOfSize:22*KIphoneWH];
    label.text=@"流行指南";
    [_headview addSubview:label];
//第三个
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 350*KIphoneWH, WIDTH, 130*KIphoneWH)];
    //scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    scroll.showsHorizontalScrollIndicator=false;
    scroll.tag=300;
    int a=0;
    int b=(recommend.count)%3;
    if (b==0) {
        a=(int)(recommend.count)/3;
    }else{
        a=(int)(recommend.count)/3+1;
    }
    scroll.contentSize=CGSizeMake(WIDTH*a, 120*KIphoneWH);
    for (int i=0; i<recommend.count; i++) {
       NSString *im=[[recommend objectAtIndex:i]objectForKey:@"img"];
        UIImageView *imageview=[[UIImageView alloc]init];
       [imageview sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];
        imageview.contentMode=UIViewContentModeScaleAspectFit;
        imageview.frame=CGRectMake(5*KIphoneWH+((WIDTH-20*KIphoneWH)/3+5*KIphoneWH)*i, 5*KIphoneWH, (WIDTH-20*KIphoneWH)/3, 120*KIphoneWH);
        imageview.userInteractionEnabled=YES;
        UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushlh:)];
        imageview.tag=i+1;
        [imageview addGestureRecognizer:imgtap];
        
        [scroll addSubview:imageview];
        UIImageView * titleimageview=[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"精致套装黑框"]];
        titleimageview.frame=CGRectMake(5*KIphoneWH, 90*KIphoneWH, (WIDTH-20*KIphoneWH)/3-10*KIphoneWH, 30*KIphoneWH);
        [imageview addSubview:titleimageview];
        
       UILabel *dlabel=[[UILabel alloc]initWithFrame: CGRectMake(5*KIphoneWH, 5*KIphoneWH, (WIDTH-20*KIphoneWH)/3-10*KIphoneWH, 20*KIphoneWH)];
        dlabel.textAlignment=NSTextAlignmentCenter ;
        dlabel.text=[[recommend objectAtIndex:i]objectForKey:@"intro"];
        dlabel.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
         dlabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
        [titleimageview addSubview:dlabel];
    }
    [_headview addSubview:scroll];
    
    UIImageView *img1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"绿方框"]];
    img1.frame=CGRectMake(0, 480*KIphoneWH, 10*KIphoneWH, 40*KIphoneWH) ;
    [_headview addSubview:img1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(25*KIphoneWH, 480*KIphoneWH, 200*KIphoneWH, 40*KIphoneWH)];
    label1.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    label1.font=[UIFont systemFontOfSize:22*KIphoneWH];
    label1.text=@"最新动态";
    [_headview addSubview:label1];

    for (int i=0; i<activity.count; i++) {
        NSString *im=[[activity objectAtIndex:i]objectForKey:@"img"];
        Btbutton *button=[[Btbutton alloc] initWithFrame:CGRectMake(0,530*KIphoneWH+150*KIphoneWH*i, WIDTH, 140*KIphoneWH) ];
         button.tag=i+1;
        [button addTarget:self action:@selector(dianjishijian:) forControlEvents:UIControlEventTouchUpInside];
        
        [button.imageview sd_setImageWithURL:[Uikility URLWithString:im] placeholderImage:[UIImage imageNamed:@"uuu"]];
        [_headview addSubview:button];

    }

    UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"绿方框"]];
    img2.frame=CGRectMake(0, 530*KIphoneWH+150*KIphoneWH*activity.count+5*KIphoneWH, 10*KIphoneWH, 40*KIphoneWH) ;
    [_headview addSubview:img2];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(25*KIphoneWH, 530*KIphoneWH+150*KIphoneWH*activity.count, 200*KIphoneWH, 40*KIphoneWH)];
    label2.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    label2.font=[UIFont systemFontOfSize:22*KIphoneWH];
    label2.text=@"推荐商品";
    [_headview addSubview:label2];

    [self.view addSubview:_headview];
}
-(void)readheardview{
     _headview.frame=CGRectMake(0, 5*KIphoneWH, WIDTH, 530*KIphoneWH+150*activity.count*KIphoneWH+50*KIphoneWH);
    UIScrollView *scrollviewbut=(id)[_headview viewWithTag:100];
    NSArray *viewsarray=[scrollviewbut subviews];
    for (UIButton *bt in viewsarray) {
        [bt removeFromSuperview];
    }
    int a=0;
    int b=(category.count)%4;
    if (b==0) {
        a=(int)(category.count)/4;
    }else{
        a=(int)(category.count)/4+1;
    }
    scrollviewbut.contentSize=CGSizeMake(WIDTH*a, 30*KIphoneWH);
    scrollviewbut.scrollEnabled=YES;
    scrollviewbut.showsHorizontalScrollIndicator=false;
    
    for (int i=0; i<category.count; i++) {
        NSString *title=[[category objectAtIndex:i]objectForKey:@"name"];
        UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
        but.tag=i+1;
        [but setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
        but.frame=CGRectMake(20*KIphoneWH+((WIDTH-50*KIphoneWH)/4+10*KIphoneWH)*i, 0, (WIDTH-50*KIphoneWH)/4, 30*KIphoneWH);
        [but setTitle:title forState:UIControlStateNormal];
        [but addTarget:self action:@selector(pushbut:) forControlEvents:UIControlEventTouchUpInside];
        [scrollviewbut addSubview:but];
    }
    
}
#pragma mark but点击 类目等等
-(void)pushbut:(UIButton *)b{
   
    InsiderViewController *inside=[[InsiderViewController alloc] init];
    inside.Insiderid=  [[category objectAtIndex:b.tag-1]objectForKey:@"id"];
    
    inside.InsiderName=b.titleLabel.text;
    if ([de objectForKey:@"placename"]) {
       [self.navigationController pushViewController:inside animated:YES];
    }
    
   

}
#pragma mark 点击后 签到等
-(void)push:(UIButton *)b{
    if ([de objectForKey:@"userId"]) {
    if (b.tag==1) {
        QdqViewController *qd=[[QdqViewController alloc]init];
         qd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:qd animated:YES];
    }else if (b.tag==2){
       
        FmViewController *fm=[[FmViewController alloc]init];
        fm.flag=3;
        if([de objectForKey:@"placename"]){
            [self.navigationController pushViewController:fm animated:YES];
        }
    }else if (b.tag==3){
      if([de objectForKey:@"placename"]){
        FmViewController *fm=[[FmViewController alloc]init];
        fm.flag=2;
          [self.navigationController pushViewController:fm animated:YES];}
    }else if (b.tag==4){
        
       
        UbViewController *ub=[[UbViewController alloc]init];
         ub.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:ub animated:YES];
     
    }
    }else{
        
        if (b.tag==2){
            
            FmViewController *fm=[[FmViewController alloc]init];
            fm.flag=3;
            if([de objectForKey:@"placename"]){
            [self.navigationController pushViewController:fm animated:YES];
            }
        }else if (b.tag==3){
            if([de objectForKey:@"placename"]){
            FmViewController *fm=[[FmViewController alloc]init];
            fm.flag=2;
                [self.navigationController pushViewController:fm animated:YES];}
        }else{
            
           
            LoginViewController *log=[[LoginViewController alloc] init];
            if([de objectForKey:@"placename"]){
            [self.navigationController pushViewController:log animated:YES];
        
            }
        
        }
    }

}

#pragma mark 点击图片 滚动图
-(void)pushshangpin:(UIGestureRecognizer *)ges{

    ThemeViewController *tvc=[[ThemeViewController alloc] init];
    
    tvc.imgurl=[[banner objectAtIndex:ges.view.tag-1]objectForKey:@"imgUrl"];
    [self.navigationController pushViewController:tvc animated:YES];

}
#pragma mark 流行指南
-(void)pushlh:(UIGestureRecognizer *)ges{
    SpViewController *sp=[[SpViewController alloc]init];
    sp.goodsId=[[[recommend objectAtIndex:ges.view.tag-1]objectForKey:@"appgoodsId" ] objectForKey:@"id"];
    sp.flag=1;
    sp.hidesBottomBarWhenPushed=YES;
    if([de objectForKey:@"placename"]){
    [self.navigationController pushViewController:sp animated:YES];
    }else{
    
        //[self cReatAltiview];
    }
}
#pragma mark 最新活动  主题
-(void)dianjishijian:(Btbutton *)g{
    NSNumber *number=[[activity objectAtIndex:g.tag-1]objectForKey:@"flag"];
    if (number.integerValue==3){
        
        if([de objectForKey:@"placename"]){
        
        if ([de objectForKey:@"userId"]) {
           
       
        KjViewController *k=[[KjViewController alloc]init];
        
        [self.navigationController pushViewController:k animated:YES];
        }else{
         //[Uikility alert:@"请先登录！"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
            
            
        }
        }
    }else if (number.integerValue==4){
        Activity618ViewController *activity1=[[Activity618ViewController alloc] init];
        [self.navigationController pushViewController:activity1 animated:YES];
    
    
    }else{
        ThemeViewController *tvc=[[ThemeViewController alloc] init];
        
        tvc.imgurl=[[activity objectAtIndex:g.tag-1]objectForKey:@"imgUrl"];
        [self.navigationController pushViewController:tvc animated:YES];
    }
}

#pragma mark 绑定page 和 scroll
-(void)sender:(UIPageControl *)p{
    int index = (int)p.currentPage;
    [_headscroll setContentOffset:CGPointMake(WIDTH*index, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = _headscroll.contentOffset.x/WIDTH;
    _page.currentPage = index;
}
#pragma mark自动滚动图片
-(void)video{
    int i = (int)_page.currentPage+1;
    if (i==banner.count) {
        _page.currentPage = 0;
        [_headscroll setContentOffset:CGPointMake(0, 0) animated:NO];
        [self performSelector:@selector(video) withObject:nil afterDelay:1.5];
    }else{
        _page.currentPage = i;
        [_headscroll setContentOffset:CGPointMake(_headscroll.frame.size.width*i, 0) animated:YES];
        [self performSelector:@selector(video) withObject:nil afterDelay:1.5];
    }
}

#pragma mark 个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (appgoodsid.count) {
        return appgoodsid.count;
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
   return  CGSizeMake(WIDTH, 530*KIphoneWH+150*activity.count*KIphoneWH+50*KIphoneWH);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
}
//2015.10.19.3.50
#pragma mark ********具体内容
-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCollectionViewCell *cell=[collectionView  dequeueReusableCellWithReuseIdentifier:@"qqq" forIndexPath:indexPath];
    if (appgoodsid.count) {
        CartModel *model=[appgoodsid objectAtIndex:indexPath.row];

    [cell.imageview sd_setImageWithURL:[Uikility  URLWithString:model.logopicUrl]placeholderImage:[UIImage imageNamed:@"uuu"]];
        
    cell.textlable.text=model.goodsName;
   CGFloat s=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
        cell.pricelable.text=[NSString stringWithFormat:@"￥%.1f",s];
        NSNumber *salecount=model.saleCount;
        if (salecount==nil) {
            //cell.salesLable.text=@"0人付款";
        }else{
            cell.salesLable.text=[NSString stringWithFormat:@"%@人付款",salecount];
        }
     CGFloat s1=model.goodsPrice.floatValue;
    if (s1>s) {
        cell.procelable.text=[NSString stringWithFormat:@"￥%.1f",s1];
        cell.procelable.alpha=1;
    }else{
        cell.procelable.alpha=0;
    }
    }
    return cell;
   
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        static NSString * headerID = @"header";
        //collectionView通过复用标志到相应的复用池去找空闲的ReusableView，有就直接用，没有就创建
          ReusableView *regestview = [_collectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
    regestview.view.frame=CGRectMake(0, 0, WIDTH,530*KIphoneWH+150*activity.count*KIphoneWH+50*KIphoneWH );
        [regestview.view addSubview:_headview];
    
        return regestview;
    
}
#pragma mark 点击tableview
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
      SpViewController *sp=[[SpViewController alloc]init];
    
     //MSdetailsViewController *sp=[[MSdetailsViewController alloc]init];
    if (appgoodsid.count) {
        
    
    CartModel *model=[appgoodsid objectAtIndex:indexPath.row];
    NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
    sp.goodsId=sreid;
    sp.flag=1;
    sp.hidesBottomBarWhenPushed=YES;
    
    //存储
    FMDBSingleTon *singon=[FMDBSingleTon shareSinglotn];
    [singon addshop:model];
        
        if ([de objectForKey:@"placename"]) {
            
//            DgViewController*dg=[[DgViewController alloc] init];
//            dg.flag=1;
//            dg.flags=1;
//            dg.indexflag=2;
          [self.navigationController pushViewController:sp animated:YES];
            
            //[self presentViewController:sp animated:YES completion:nil];
            
            
        }else{
            //[self cReatAltiview];
        
        }
        
        
    
    }
}

#pragma mark 2015.10.19.9.10 接受数据
-(void)json{
    
    d=[[NSDictionary alloc]init];
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    if ([de objectForKey:@"placename"]) {
      [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
       
    }
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    if ([de objectForKey:@"userId"]) {
       
           [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
           [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
             [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        
    }
    
    d=[Uikility initWithdatajson:mudic];
     NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetHome];
   
    
    
  AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer=[AFHTTPResponseSerializer serializer];
    //manger.requestSerializer.HTTPShouldHandleCookies=YES;
    [manger POST:url parameters:d progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *respons=(NSHTTPURLResponse *)task.response;
        [de setObject:respons.allHeaderFields[@"Set-Cookie"] forKey:@"setcookie"];//setcookie
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        //NSLog(@"%@",strs);
        Boolean success=[[strs objectForKey:@"success"] boolValue];
        
        if (success) {
            banner=[NSArray array];
            category=[NSArray array];
            recommend=[NSArray array];
            activity=[NSArray array];
            banner=[[strs objectForKey:@"data"]objectForKey:@"banner"];
            category=[[strs objectForKey:@"data"]objectForKey:@"category"];
            recommend=[[strs objectForKey:@"data"]objectForKey:@"recommend"];
            
            activity=[[strs objectForKey:@"data"]objectForKey:@"activity"];
            
            [self addheadview];
            
            [self json1];
        
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //NSLog(@"失败原因%@",error);
  
        
        [Uikility alert:@"请求失败"];
    }];

   
}
#pragma mark 第二次请求
-(void)json1{
    [appgoodsid removeAllObjects];
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:@20 forKey:@"max"];
    [mudic setObject:@0 forKey:@"min"];
   if ([de objectForKey:@"placename"]){
       [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
       
     
   }else {
      
//       UIAlertView *alteview=[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请进入系统《设置》《隐私》《定位服务》中打开开关，并允许U购使用定位服务" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即开启", nil];
//       
//       [alteview show];
//       _leftlable.text=@"定位失败";
       
   }
    
    if ([de objectForKey:@"userId"]) {
    
            [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
            [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
    }
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetHomeReList];
    NSDictionary *dh=[Uikility initWithdatajson:mudic];
    
   [AFManger postWithURLString:url parameters:dh success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
       
       
       //NSLog(@"%@",obj);
        Boolean success=[[obj objectForKey:@"success"] boolValue];
        if (success) {
            NSArray *array=  [obj objectForKey:@"data"];
            for (NSDictionary * datadic in array) {
                NSDictionary *dicc=[datadic objectForKey:@"appgoodsId"];
                [appgoodsid addObject:[CartModel initwithdic:dicc]];
            }
            [_collectionview reloadData];
            
        }else{
            [Uikility alert:[obj objectForKey:@"msg"]];
            
        }
    } failure:^(NSError *error) {
         [Uikility alert:@"数据接受失败！"];
    }];

}
-(void)getcooike{
    d=[[NSDictionary alloc]init];
    NSMutableDictionary *mudic1=[[NSMutableDictionary alloc] init];
    if ([de objectForKey:@"placename"])
    {
        [mudic1 setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
    [mudic1  setObject:@1 forKey:@"model"];
    [mudic1  setObject:VERSION forKey:@"ios_version"];
    if([de objectForKey:@"userId"]){
        [mudic1  setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [mudic1  setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
             [mudic1 setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
       
    }
    
    d=[Uikility initWithdatajson:mudic1 ];
    NSString *urlhome=[BassAPI requestUrlWithPorType:PortTypeGetHome];
    
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer=[AFHTTPResponseSerializer serializer];
    //manger.requestSerializer.HTTPShouldHandleCookies=YES;
    [manger POST:urlhome parameters:d progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *respons=(NSHTTPURLResponse *)task.response;
        [de setObject:respons.allHeaderFields[@"Set-Cookie"] forKey:@"setcookie"];//setcookie
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //[Uikility alert:@"请求失败"];
    }];
}

-(void)refresh{
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:@10 forKey:@"max"];
    if ([de objectForKey:@"placename"]){
        [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    }

    if ([de objectForKey:@"userId"]) {
        if (hang==1) {
            [mudic setObject:@0 forKey:@"min"];
            [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
            if ([de objectForKey:@"newUserId"]) {
               [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
            }
           
        }else{
            NSString *minstr=[[NSString alloc]initWithFormat:@"%d",10*(hang-1)+1];
            NSNumber * min = @([minstr integerValue]);
            [mudic setObject:min forKey:@"min"];
            [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
            [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
          
            if ([de objectForKey:@"newUserId"]) {
               [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
            }
        }
    }else{
        if (hang==1) {
             [mudic setObject:@0 forKey:@"min"];
        }else{
            NSString *minstr=[[NSString alloc]initWithFormat:@"%d",10*(hang-1)+1];
            NSNumber * min = @([minstr integerValue]);
             [mudic setObject:min forKey:@"min"];
        }
        
    }
    
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetHomeReList];
    
    
    NSDictionary *dh=[Uikility initWithdatajson:mudic];
    [AFManger postWithURLString:url parameters:dh success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[obj objectForKey:@"success"] boolValue];
        if (success) {
            NSArray *array=  [obj objectForKey:@"data"];
            // [appgoodsid addObjectsFromArray:[obj objectForKey:@"data"]];
            
            [appgoodsid removeAllObjects];
            
            for (NSDictionary * datadic in array) {
                NSDictionary *dicc=[datadic objectForKey:@"appgoodsId"];
                [appgoodsid addObject:[CartModel initwithdic:dicc]];
            }
            
            [_collectionview reloadData];
        }else{
            [Uikility alert:[obj objectForKey:@"msg"]];
            
        }

        
    } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
    }];
    
   
}
-(void)getBestNewVerson{
    NSString *strurl=[BassAPI requestUrlWithPorType: PortTypeUpdataVerson];
    NSMutableDictionary *mudic=[Uikility creatSinGoMutableDictionary];
    [mudic setObject:@2 forKey:@"systemtype"];
    [mudic setObject:VERSION forKey:@"versionNumber"];
    NSDictionary *postdic=[Uikility initWithdatajson:mudic];
    [AFManger postWithURLString:strurl parameters:postdic success:^(id responseObject) {
       
        
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[obj objectForKey:@"success"] boolValue];
        if (success) {
            [self creatUpdataVersonUI:[[obj objectForKey:@"data"] objectForKey:@"explains"]];
        }else{
            
            
        }

        
        
    } failure:^(NSError *error) {
        
    }];



}
-(void)creatUpdataVersonUI:(NSString *)mesesge{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertView *alteview=[[UIAlertView alloc] initWithTitle:@"发现新版本" message:mesesge delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
        alteview.tag=300;
        [alteview show];
    });
    
    
    
    
 

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
