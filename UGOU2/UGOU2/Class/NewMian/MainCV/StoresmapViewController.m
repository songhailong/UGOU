//
//  StoresmapViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/4/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "StoresmapViewController.h"
#import<MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapNaviKit/AMapNaviKit.h>
#import<AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "SpeechSynthesizer.h"
#import "CustomAnnotation.h"
#import "Uikility.h"
#define MAPAPPKEY @"742ca8b07f70c1cc37e400d324759405"

@interface StoresmapViewController ()<MAMapViewDelegate,AMapNaviDriveManagerDelegate,AMapNaviDriveViewDelegate,AMapSearchDelegate>

  {
      MAMapView *_mapview;
      //AMapNaviDriveView * _naviDriveView;
     // AMapNaviDriveManager *drvivemanger;
      NSMutableArray *_anotions;
      CGFloat didlatitude;
      CGFloat didlongitude;
      
      CGFloat startlatitude;
      CGFloat startlongitude;
      
      UIButton *_button;
      AMapSearchAPI *_search;
      
      
 }
@property (nonatomic, strong) AMapNaviDriveManager *driveManager;
@property (nonatomic, strong) AMapNaviDriveView *naviDriveView;
@end

@implementation StoresmapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _anotions=[[NSMutableArray alloc] init];
    [AMapServices sharedServices].apiKey=MAPAPPKEY;
    _mapview=[[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapview.showsUserLocation=YES;
    _mapview.showsCompass=NO;
    _mapview.showsScale=YES;
    //_mapview.scaleOrigin= CGPointMake(_mapview.scaleOrigin.x, 1000);
   // _mapview.showTraffic=YES;
  _mapview.userTrackingMode=MAUserTrackingModeFollow;
    _mapview.delegate=self;
    
    _button=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH, HEIGHT, 200*KIphoneWH, 50*KIphoneWH)];
    [_button setTitle:@"去这里" forState:UIControlStateNormal];
    _button.backgroundColor=[UIColor redColor];
    [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _button.alpha=1;
    //[self addSubview:_button];
    //_mapview.delegate=self;
    
    
    [_mapview setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapview];
    [self.view addSubview:_button];
    //_naviDriveView=[[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5*KIphoneWH, 20*KIphoneWH,50*KIphoneWH , 40*KIphoneWH)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(popblack) forControlEvents:UIControlEventTouchUpOutside];
    //UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 10*KIphoneWH, 30*KIphoneWH, 20*KIphoneWH)];
//    imageview.image=[UIImage imageNamed:@"返回o"];
//    [button addSubview:imageview];
//    [self.view addSubview:button];
    //[self creatannotation];
    [self creatannotation];
    
}


-(void)buttonclick:(UIButton *)b{
    
    self.driveManager = [[AMapNaviDriveManager alloc] init];
    
    [self.driveManager setDelegate:self];
    
    
    
    self.naviDriveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];

    self.naviDriveView.delegate = self;
  
    AMapNaviPoint *endpoint=[AMapNaviPoint  locationWithLatitude:didlatitude longitude:didlongitude];
    AMapNaviPoint *stratpoint=[AMapNaviPoint locationWithLatitude:startlatitude longitude:startlongitude];
    NSArray  *endpoints=@[endpoint];
    NSArray *startpoints=@[stratpoint];
     
   //[self.driveManager calculateDriveRouteWithEndPoints:endpoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];
    [self.driveManager calculateDriveRouteWithStartPoints:startpoints endPoints:endpoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyFastestTime];
   _button.frame=CGRectMake(WIDTH, HEIGHT, WIDTH-200*KIphoneWH, HEIGHT-150*KIphoneWH);

}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    startlatitude=userLocation.coordinate.latitude;
    startlongitude=userLocation.coordinate.longitude;
    //CLLocationCoordinate2D coord=                  CLLocationCoordinate2DMake(startlatitude, startlongitude);
    //_mapview.centerCoordinate=coord;
   


}
- (void)initNaviDriveView
{
    if (self.naviDriveView == nil)
    {
        self.naviDriveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        //[Uikility alert:@"执行导航"];
        self.naviDriveView.delegate = self;
    }
}
- (void)initDriveManager
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        //[Uikility alert:@"执行路线规划"];
        [self.driveManager setDelegate:self];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
   // [self.nav]
    //self.navigationController.navigationBar.hidden=YES;
    
   // UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5*KIphoneWH, 20*KIphoneWH,50*KIphoneWH , 40*KIphoneWH)];
    
    //self.title=@"店铺位置";
    
//   UIImage *image1=[UIImage imageNamed:@"返回o"];
//    UIBarButtonItem *bakcItem1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(popblack)];
//    //UINavigationItem *item=[[UINavigationItem alloc] in]
//    self.navigationItem.leftBarButtonItem=bakcItem1;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=@"门店位置";
    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
    self.navigationItem.titleView=label;
    
    
    UIBarButtonItem *leftbut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(popblack)]   ;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftbut;
    
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;    

}


-(void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{

//    _search=[[AMapSearchAPI alloc] init];
//    _search.delegate=self;
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.address = @"西单";
//    
//    //发起正向地理编码
//    [_search AMapGeocodeSearch: geo];

   
}
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
//    _button.alpha=1;
//    _button.frame= CGRectMake(WIDTH-200*KIphoneWH, HEIGHT-150*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH);
    
    _search=[[AMapSearchAPI alloc] init];
    _search.delegate=self;
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = [view.annotation subtitle];
    geo.city=_city;
    //发起正向地理编码
    [_search AMapGeocodeSearch: geo];
    
}
//实现正向地理编码的回调函数
-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if(response.geocodes.count == 0)
    {
        return;
    }
    
    //通过AMapGeocodeSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
    NSString *strGeocodes = @"";
    for (AMapTip *p in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %f--------%f", strGeocodes, p.location.longitude,p.location.latitude];
        didlatitude=p.location.latitude;
        didlongitude=p.location.longitude;
        _button.alpha=1;
        _button.frame= CGRectMake(WIDTH-200*KIphoneWH, HEIGHT-150*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH);
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
    


}

-(void)popblack{

    [self.navigationController popViewControllerAnimated:YES];

}
//定义大头针
-(void)creatannotation{
    
    if(_maparray.count){
        for (NSDictionary *dic in _maparray) {
           MAPointAnnotation *custanotion=[[MAPointAnnotation alloc] init];
            custanotion.title=[dic objectForKey:@"shopName"];
            custanotion.subtitle=[dic objectForKey:@"shopAddr"];
            NSNumber *longitude=[dic objectForKey:@"longitude"];
            NSNumber *latitude=[dic objectForKey:@"latitude"];
            //custanotion.longitude=longitude;
            //custanotion.latitude=latitude;
            custanotion.coordinate=CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
            [_anotions addObject:custanotion];
            //[_mapview addAnnotations:custanotion];
            [_mapview addAnnotation:custanotion];
        }
        //[_mapview addAnnotations:_anotions];
        [_mapview showAnnotations:_anotions animated:YES ];
    
    
    
    }else{
//        NSArray *arrla=@[@"117.02430725",@"117.03440725",@"117.02730725"];
//        //NSArray *arrwei=@[ @"36.18081494",@"36.17081494",@"36.19081494"];
//        for (NSString *dic in arrla) {
//            MAPointAnnotation *custanotion=[[MAPointAnnotation alloc] init];
//            custanotion.title=@"济南店";
//            custanotion.subtitle=@"和平路";
//            //NSNumber *longitude=dic.floatValue;
//            NSString *latitude=@"36.19081494";
//            custanotion.coordinate=CLLocationCoordinate2DMake(dic.floatValue, latitude.floatValue);
//            [_anotions addObject:custanotion];
        
        //}
    
    }
    
    

}
//-(void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
//
//    NSLog(@"gghvhbjbjkbhvhjb");
//
//
//}

//路线规划成功的代理
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    _button.frame=CGRectMake(WIDTH, HEIGHT, WIDTH-200*KIphoneWH, HEIGHT-150*KIphoneWH);
    //将naviDriveView添加到AMapNaviDriveManager中
    [self.driveManager addDataRepresentative:self.naviDriveView];
    
    //将导航视图添加到视图层级中
    [self.view addSubview:self.naviDriveView];
    
    //开始实时导航
    [Uikility alert:@"开始导航"];
    [self.driveManager startGPSNavi];
    [self.driveManager readNaviInfoManual];
    
}
//规划路线失败
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error{
    NSString *str=[NSString stringWithFormat:@"%@",error];
   

}
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    //停止导航
    [self.driveManager stopNavi];
    
    //将naviDriveView从AMapNaviDriveManager中移除
    [self.driveManager removeDataRepresentative:self.naviDriveView];
    
    //将导航视图从视图层级中移除
    [self.naviDriveView removeFromSuperview];
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    
}

-(void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
   
    
    didlatitude=coordinate.latitude;
    didlongitude=coordinate.longitude;
    _button.alpha=1;
    _button.frame= CGRectMake(WIDTH-200*KIphoneWH, HEIGHT-150*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH);

   


}
-(void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate{
//    didlatitude=coordinate.latitude;
//    didlongitude=coordinate.longitude;
//    _button.alpha=1;
//    _button.frame= CGRectMake(WIDTH-200*KIphoneWH, HEIGHT-150*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH);
}
-(void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated{}
-(void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
    
}


-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
   
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:pointReuseIndentifier];
        }
        
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        //annotationView.annotation=[_anotions indexOfObject:<#(nonnull id)#>];
        //annotationView.pinColor=[_anotions indexOfObject:annotation];
        return annotationView;
    }
    return nil;


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
