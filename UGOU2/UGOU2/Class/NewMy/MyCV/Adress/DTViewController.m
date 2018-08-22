//
//  DTViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/6.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.7.10.24 地图
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "AFManger.h"
#import "DTViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <MapKit/MapKit.h>

#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "Uikility.h"
#define APPKEY @"742ca8b07f70c1cc37e400d324759405"
@interface DTViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,MAMapViewDelegate>{
    UIView *view1;
    UIView *view2;
    UIView *headview;
  
    CGFloat latitude;
    CGFloat longitude;
    CLLocationManager *managers;
    //MKMapView *mapviews;
    UITextField *sfield;
    UILabel *label;
    UIView *rightview;
    NSMutableArray *_muarr;
    NSString *placenames;
    CLLocationCoordinate2D centerCoordinate;
    CLGeocoder *_Geocoder;
    MAMapView*_mapview;
    AMapLocationManager *_locationmansger;
    AMapSearchAPI *_search;
    //CLGeocoder*_Geocoder;
    NSString *_city;
    UITableView *table;
    UITableView *table1;
    //MKCoordinateRegion regions;
}

@end

@implementation DTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib
    self.view.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent=NO;
    [AMapServices sharedServices].apiKey=@"742ca8b07f70c1cc37e400d324759405";
    //[AMapSearchServices sharedServices].apiKey=APPKEY;
    //[AMapLocationServices sharedServices].apiKey=APPKEY;

  
    _Geocoder=[[CLGeocoder alloc] init];
    _muarr=[[NSMutableArray alloc] init];
    //创建地图视图
    [self addheadview];
    [self addtableview:1];
    [self addseachview];
    [self addseachdata];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;

}
#pragma mark 右侧
-(void)addview{
    rightview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30*KIphoneWH, 30*KIphoneWH)];
    // [v1 addSubview:leftview];
    
    UIImageView *imv1=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    imv1.image=[UIImage imageNamed:@"search-灰@2x"];
    [rightview addSubview:imv1];
    imv1.tag=1;
    imv1.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    [imv1 addGestureRecognizer:imgtap1];
}
#pragma mark 关键字搜索
-(void)imvpush:(UITapGestureRecognizer *)g{
   
    if (sfield.text.length==0) {
       [Uikility alert:@"请输入收货地址！"];
    }else{
        table1.alpha=1;
        AMapPOIKeywordsSearchRequest *requst=[[AMapPOIKeywordsSearchRequest alloc] init];
        requst.keywords=sfield.text;
        requst.city=_city;
        requst.requireExtension=YES;
         requst.cityLimit           = YES;
           requst.requireSubPOIs      = YES;
        [_search AMapPOIKeywordsSearch:requst];
        
    }
}
#pragma mark 点击 返回 清空
-(void)butpush:(UIButton *)b{
    if (b.tag==1) {
       
        [self.navigationController popViewControllerAnimated:YES];
    }else if (b.tag==2){
        sfield.text=@"";
        table1.alpha=0;
        [self addseachdata];
        //[self.view addSubview:view1];
    }
}

#pragma mark 头视图
-(void)addseachview{
   
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60*KIphoneWH)];
    v1.backgroundColor=[UIColor whiteColor];
    [ self.view addSubview:v1];
    UIButton *leftbut=[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 50*KIphoneWH, 60*KIphoneWH)];
    [v1 addSubview:leftbut];
    
   
    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
    UIImage *img=[UIImage imageNamed:@"返回p"];
    UIImageView *imgv1=[[UIImageView alloc]initWithImage:img];
    [leftbut addSubview:imgv1];
    imgv1.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 15*KIphoneWH, 15*KIphoneWH);
    [leftbut addTarget:self action:@selector(butpush:) forControlEvents:UIControlEventTouchUpInside];
    leftbut.tag=1;
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(50*KIphoneWH, 25*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
    imgv.image=[UIImage imageNamed:@"搜索框"];
    [v1 addSubview:imgv];
    imgv.userInteractionEnabled=YES;
    sfield=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
    [imgv addSubview:sfield];
    [sfield setBorderStyle:UITextBorderStyleNone];
    sfield.delegate=self;
    sfield.clearButtonMode=YES;
    sfield.placeholder=@"请输入您的送货地址";
    [self addview];
    sfield.rightViewMode=UITextFieldViewModeAlways;
    sfield.rightView=rightview;
    UIButton *cancelbut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 15*KIphoneWH, 50*KIphoneWH, 40*KIphoneWH)];
    [v1 addSubview:cancelbut];
    [cancelbut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbut setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelbut addTarget:self action:@selector(butpush:) forControlEvents:UIControlEventTouchUpInside];
    cancelbut.tag=2;
}
#pragma mark 定位
-(void)addheadview{
   
    _locationmansger=[[AMapLocationManager alloc] init];
    _locationmansger.delegate=self;
    [_locationmansger startUpdatingLocation];
//    [_locationmansger setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    [_locationmansger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//        if (error)
//        {
//            // nslog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//        latitude=location.coordinate.latitude;
//        longitude=location.coordinate.longitude;
//        [_locationmansger stopUpdatingLocation];
//        [_Geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//            CLPlacemark *placemark=[placemarks firstObject];
//            _city=placemark.locality;
//        }];
//
//        [self addseachdata];
//        
//        
//        if (regeocode)
//        {
//
//        }
//    }];
        //精度
//    managers.desiredAccuracy=kCLLocationAccuracyBest;
//    //频率 多少米
//    managers.distanceFilter=100.0;
//    //开始
//    managers.delegate=self;
//    [managers startUpdatingLocation];
//    headview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/3)];
//    [self.view addSubview:headview];
    _mapview=[[MAMapView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/2)];
    [self.view addSubview:_mapview];
//    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-10*KIphoneWH,HEIGHT/3/2-30*KIphoneWH, 20*KIphoneWH, 30*KIphoneWH)];
//    imv.image=[UIImage imageNamed:@"定位@2x"];
//    [_mapview addSubview:imv];
    _mapview.delegate=self;
    //用户
    _mapview.showsUserLocation=YES;
    //跟踪
   _mapview.userTrackingMode=MAUserTrackingModeFollowWithHeading;
   _mapview.allowsBackgroundLocationUpdates=YES;
    
}
//mapview 代理
-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    // nslog(@"%@",error);
}
// 开启跟踪模式
//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//  
//     latitude=userLocation.location.coordinate.latitude;
//     longitude=userLocation.location.coordinate.longitude;
//    //       根据clgeo
//    //[_Geocoder reverseGeocodeLocation:userLocation completionHandler:<#^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)completionHandler#>]
//    
//    
//  //  [self getadressfromlocation];
//}
-(void)addseachdata{
    [AMapServices sharedServices].apiKey=APPKEY;
    _search=[[AMapSearchAPI alloc] init];
    _search.delegate=self;
    AMapPOIAroundSearchRequest *requset=[[AMapPOIAroundSearchRequest alloc] init];
    requset.location=[AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    requset.types = @"地名地址信息|公司企业|住宿服务";
       requset.sortrule = 0;
        //request.radius=100;
        requset.requireExtension = YES;
    
        //发起周边搜
    [_search AMapPOIAroundSearch: requset];
    

}
-(void)searchPOI{
    AMapPOIKeywordsSearchRequest *requst=[[AMapPOIKeywordsSearchRequest alloc]init];
    requst.keywords=sfield.text;
    requst.city=_city;
    requst.requireExtension=YES;
    requst.cityLimit=YES;
    requst.requireSubPOIs=YES;
    [_search AMapPOIKeywordsSearch:requst];
}
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    latitude=location.coordinate.latitude;
    longitude=location.coordinate.longitude;
    [_locationmansger stopUpdatingLocation];
    [_Geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark=[placemarks firstObject];
        _city=placemark.locality;
    }];
    [self addseachdata];
}
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if(response.pois.count == 0)
    {
        return;
    }
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %zd",response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion.cities];
    NSString *strPoi = @"";
    [_muarr removeAllObjects];
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@%@%@%@",p.province,p.city,p.district,p.name];
        
        [_muarr addObject:strPoi];
         //_city=p.city;
        
        //[table reloadData];
        for (AMapSubPOI *doc  in p.subPOIs) {
           
        }
        
    }
    [table reloadData];
    [table1 reloadData];
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    // nslog(@"Place: %@", result);
    
}
//
//////经纬度得地址
//-(void)getadressfromlocation{
//    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
//    CLGeocoder *geo=[[CLGeocoder alloc]init];
//    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        CLPlacemark *place=[placemarks firstObject];
//        // nslog(@"地址信息：%@",place.name);
//        placenames=place.name;
//    }];
//}


#pragma mark 附近信息
//- (void)fetchNearbyInfo:(CLLocationDegrees )la lo:(CLLocationDegrees)lo
//{
//
//    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(la, lo);
//    
//    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location, 10.0f ,10.0f );
//    
//    MKLocalSearchRequest *requst = [[MKLocalSearchRequest alloc] init];
//    requst.region = region;
//    requst.naturalLanguageQuery = @"place"; //想要的信息
//    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:requst];
//    
//    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
//        if (!error)
//        {
//    
//            muarr=[NSMutableArray array];
//            NSArray *arr=[NSArray array];
//            arr=response.mapItems;
//            for (int i=0; i<arr.count; i++) {
//           
//                NSString *string=[NSString stringWithFormat:@"%@",[response.mapItems objectAtIndex:i].placemark];               //
//                NSArray* foo = [string componentsSeparatedByString:@"@"];
//                NSString* place = [foo objectAtIndex: 0];
//                // nslog(@"%@",place);
//                NSArray* foo1 = [place componentsSeparatedByString:@","];
//                NSString* place1 = [foo1 objectAtIndex: 1];
//                [muarr addObject:place1];
//                int i=1;
//                [self addtableview:i];
//            }
//           
//        }
//        else
//        {
//            // nslog(@"%@",error);
//          
//        }
//    }];
//}
#pragma mark 中间点
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//   
//    MKCoordinateRegion regions;
//   
//    centerCoordinate = mapView.region.center;
//    regions.center= centerCoordinate;
//    
//    // nslog(@" ]]]]]]]]]]]]]]]]regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
//    latitude=centerCoordinate.latitude;
//    longitude=centerCoordinate.longitude;
//    [self addseachdata];
//    
//}
//-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//     MACoordinateRegion regions;
//    
//        centerCoordinate = mapView.region.center;
//        regions.center= centerCoordinate;
//    
//        // nslog(@" ]]]]]]]]]]]]]]]]regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
//        latitude=centerCoordinate.latitude;
//        longitude=centerCoordinate.longitude;
//        [self addseachdata];
//    //
//
//}
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    centerCoordinate = mapView.region.center;
    
    latitude=centerCoordinate.latitude;
    longitude=centerCoordinate.longitude;
    [self addseachdata];


}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 5;
}
#pragma mark tableview
-(void)addtableview:(int)i{
      table=[[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/2) style:UITableViewStyleGrouped];
        
        table.delegate=self;
        table.dataSource=self;
        table.rowHeight=50*KIphoneWH;
        [self.view addSubview:table];
   // }else if (i==2){
        table1=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
        
        table1.delegate=self;
        table1.dataSource=self;
        table1.rowHeight=50*KIphoneWH;
        [self.view addSubview:table1];
         table1.alpha=0;
//    }

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_muarr.count==0) {
        return 1;
    }
    return _muarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_muarr.count) {
       cell.textLabel.text=[_muarr objectAtIndex:indexPath.row];
       
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
    table1.alpha=0;
    [d setValue:[_muarr objectAtIndex:indexPath.row] forKey:@"deaddress"];
    // nslog(@"%f, %f",centerCoordinate.latitude,latitude);
    if (indexPath.row==0) {
        if (centerCoordinate.latitude==latitude ) {
            // nslog(@" %@",[_muarr objectAtIndex:indexPath.row]);
            NSString *lo=[NSString stringWithFormat:@"%.2f",longitude];
            NSString *la=[NSString stringWithFormat:@"%.2f",latitude];
            
            [d setValue:lo forKey:@"longitude"];
            [d setValue:la forKey:@"latitude"];
        }
 
    }
    [self.delegate passAdress:d];
    // nslog(@"d%@ %@",d,[d objectForKey:@"deaddress"]);
    [self.navigationController popViewControllerAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 键盘
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addtoolBar];
}
#pragma mark 键盘 完成建
-(void)addtoolBar{
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30*KIphoneWH)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [sfield setInputAccessoryView:topview];
    
    
}
-(void)resignKeyboard{
       [sfield resignFirstResponder];
}
#pragma mark 点击空白 键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [sfield resignFirstResponder];
    
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
