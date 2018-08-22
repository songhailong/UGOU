//
//  AdressViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/11.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
/*
 xujing2015.11.11.2.24 地址
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height//


#import "PlaceViewController.h"
#import "DTViewController.h"
#import "AdressViewController.h"
#import "BassAPI.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "UGHeader.h"
#define APPKEY @"742ca8b07f70c1cc37e400d324759405"

@interface AdressViewController ()<UITextFieldDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,MAMapViewDelegate,UGCustomnNavViewDelegate>{
    UIView *view1;
   
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    NSDictionary *dic;
    NSString *url;
    NSString *url1;
    UIBarButtonItem *rightButton;
    UILabel *titlelabel;
    NSDictionary *dic1;
    NSUserDefaults *de;
    NSDictionary *_deadd;
    UITableView *table;
    UIImageView *_imageview;
    NSString   *  _seturl;
    CGFloat latitude;
    CGFloat longitude;
    
    MAMapView*_mapview;
    NSMutableArray *_muarr;
    NSString *placenames;
    CLLocationCoordinate2D centerCoordinate;
    CLGeocoder *_Geocoder;
    
    AMapLocationManager *_locationmansger;
    AMapSearchAPI *_search;
    //CLGeocoder*_Geocoder;
    NSString *_city;

    
}
@end

@implementation AdressViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.view.backgroundColor=[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    de = [NSUserDefaults standardUserDefaults];
    dic=[[NSDictionary alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden=YES;
    [AMapServices sharedServices].apiKey=MAPKEY;
    [[AMapServices sharedServices]setEnableHTTPS:YES];
    //[MapSearchServices sharedServices].apiKey=APPKEY;
    //[AMapLocationServices sharedServices].apiKey=APPKEY;
    
    _Geocoder=[[CLGeocoder alloc] init];
    _muarr=[[NSMutableArray alloc] init];

    [self adddaohanglan];
    [self addheadview];
    self.tabBarController.tabBar.hidden = YES;
    if ([_deadd objectForKey:@"deaddress"]) {
         textfield5.text=[de objectForKey:@"deaddress"];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;

}

-(void)addheadview{
    _locationmansger=[[AMapLocationManager alloc] init];
    _locationmansger.delegate=self;
    [_locationmansger setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [_locationmansger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        latitude=location.coordinate.latitude;
        longitude=location.coordinate.longitude;
       
        [_locationmansger stopUpdatingLocation];
        [_Geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark=[placemarks firstObject];
            _city=placemark.locality;
        }];
     
        [self addseachdata];
        
        
        if (regeocode)
        {
            
        }
    }];


}
-(void)addseachdata{
    
    //[MapSearchServices sharedServices].apiKey=APPKEY;
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

-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{

    if(response.pois.count == 0)
    {
        return;
    }
    //通过 AMapPOISearchResponse 对象处理搜索结果
    //NSString *strCount = [NSString stringWithFormat:@"count: %zd",response.count];
    // NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion.cities];
    NSString *strPoi = @"";
    [_muarr removeAllObjects];
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@%@%@",p.province,p.city,p.district];
    }

    textfield4.text=strPoi;



}
#pragma mark 返回的地址信息




-(void)passAdress:(NSMutableDictionary *)deaddress{
   
    _deadd=deaddress;
    if ([_deadd objectForKey:@"deaddress"]) {
        textfield4.text=[_deadd objectForKey:@"deaddress"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent=NO;
       [self AddShippingadress];
     //[self addplace];
     // Do any additional setup after loading the view.
}
#pragma mark 导航栏
-(void)adddaohanglan{
    self.navigationController.navigationBar.hidden=YES;
    
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custemNav.Delegate=self;
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    if (_flage==1) {
        custemNav.title=@"添加收货地址";
    }else {
        custemNav.title=@"修改收货地址";
    }
    [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:custemNav];
}
-(void)LeftItemAction{
    [self pushpop];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _imageview.hidden=YES;
    
}
#pragma mark 导航栏点击返回
-(void)pushpop{
   
    // [_imageview removeFromSuperview];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)AddShippingadress{
    
    
    NSArray *textarr=@[@"收货人:",@"手  机:",@"固  话:",@"地  区:",@"地  址:",@"邮  编:"];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, 300*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:view];

    for (int i=0; i <6; i++) {
        
       UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH+50*i*KIphoneWH, 70*KIphoneWH, 40*KIphoneWH)];
        lable.text=textarr[i];
        lable.textColor=[UIColor colorWithRed:131.0/225.0 green:131.0/225.0 blue:131.0/225.0 alpha:1];
        lable.textAlignment=NSTextAlignmentRight;
        [view addSubview:lable];
        
        UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 49*KIphoneWH+50*i*KIphoneWH, WIDTH, 1*KIphoneWH)];
        imageview.image=[UIImage  imageNamed:@"我的资料-分割线.png"];
        [view addSubview:imageview];
    }
    textfield1=[[UITextField alloc]initWithFrame:CGRectMake(80*KIphoneWH, 5*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
        textfield1.tag=0;
        textfield1.delegate=self;
        textfield1.clearButtonMode=UITextFieldViewModeWhileEditing;
        [view addSubview:textfield1];
        if (_flage==0) {
            
            textfield1.text=[_d objectForKey:@"consignee"];
    
            
        }

        textfield2=[[UITextField alloc]initWithFrame:CGRectMake(80*KIphoneWH, 5*KIphoneWH+50*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
        textfield2.tag=1;
        textfield2.delegate=self;
        textfield2.clearButtonMode=UITextFieldViewModeWhileEditing;
    textfield2.keyboardType=UIKeyboardTypeNumberPad;    
        [view addSubview:textfield2];
        if (_flage==0) {
            textfield2.text=[_d objectForKey:@"mobile"];
        }

        textfield3=[[UITextField alloc]initWithFrame:CGRectMake(80*KIphoneWH, 5*KIphoneWH+100*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
        textfield3.tag=2;
        textfield3.delegate=self;
        textfield3.clearButtonMode=UITextFieldViewModeWhileEditing;
        [view addSubview:textfield3];
        if (_flage==0) {
            if ([_d objectForKey:@"telephone"]) {
                textfield3.text=[_d objectForKey:@"telephone"];
            }
        }
        textfield4=[[UITextField alloc]initWithFrame:CGRectMake(80*KIphoneWH, 5*KIphoneWH+150*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
        textfield4.tag=3;
        textfield4.delegate=self;
        textfield4.clearButtonMode=UITextFieldViewModeWhileEditing;
        [view addSubview:textfield4];
        if (_flage==0) {
            textfield4.text=[_d objectForKey:@"area"];
        }
    if ([_deadd objectForKey:@"deaddress"]) {
            textfield4.text=[_deadd objectForKey:@"deaddress"];
        }
//定位按钮
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 5*KIphoneWH+150*KIphoneWH, 20*KIphoneWH, 30*KIphoneWH)];
        imv.image=[UIImage imageNamed:@"定位@2x"];
        
        imv.userInteractionEnabled=YES;
        UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushditu)];
        [imv addGestureRecognizer:imgtap];
        //[view addSubview:imv];

        textfield5=[[UITextField alloc]initWithFrame:CGRectMake(80*KIphoneWH, 5*KIphoneWH+200*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
        textfield5.tag=4;
        textfield5.delegate=self;
        textfield5.clearButtonMode=UITextFieldViewModeWhileEditing;
        [view addSubview:textfield5];
        if (_flage==0) {
            textfield5.text=[_d objectForKey:@"deaddress"];
        }

        textfield6=[[UITextField alloc]initWithFrame:CGRectMake(80*KIphoneWH, 5*KIphoneWH+250*KIphoneWH, WIDTH-120*KIphoneWH, 40*KIphoneWH)];
        textfield6.tag=5;
        textfield6.delegate=self;
        textfield6.clearButtonMode=UITextFieldViewModeWhileEditing;
        [view addSubview:textfield6];
        if (_flage==0) {
            if ([_d objectForKey:@"zipcode"]) {
                textfield6.text=[NSString stringWithFormat:@"%@",[_d objectForKey:@"zipcode"]];
            }
        }
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];

    [nc addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UIView *viewsecond=[[UIView alloc] initWithFrame:CGRectMake(0, 300*KIphoneWH+64*KIphoneWH, WIDTH, 110*KIphoneWH)];
    viewsecond.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0  blue:246.0/255.0  alpha:1];
      [self.view addSubview:viewsecond];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-20*KIphoneWH, 40*KIphoneWH )];
    lable.numberOfLines=2;
    lable.text=@"温馨提示：\n手机和固定电话选择其中一项填写即可";
    lable.font=[UIFont systemFontOfSize:10*KIphoneWH];
    lable.textColor=[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
    [viewsecond addSubview:lable];
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH, 50*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH)];
        
    [but addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:@"保存地址@2x.png"] forState:UIControlStateNormal];
    
       // [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [viewsecond addSubview:but];
    


}


#pragma mark 点击进入 地图
-(void)pushditu{
    DTViewController *dt=[[DTViewController alloc]init];
    dt.delegate=self;
    dt.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:dt animated:YES];
}
#pragma mark 点击后 返回上一页界面
//-(void)pop{
//        [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark点击 保存后
-(void)push{
   
    if (textfield1.text.length==0) {
     
        [Uikility alert:@"收货人不能为空！"];
        return;
    }
    if (textfield2.text.length==0) {
        
      [Uikility alert:@"手机号不能为空！"];
        return;
    }
    if (textfield4.text.length==0) {
        [Uikility alert:@"地区不能为空"];
        return;
    }
    if(textfield1.text.length>20){
    
     [Uikility alert:@"收货人字符太多"];
        return;
    }
    if (textfield5.text.length==0) {
    
        [Uikility alert:@"地址不能为空！"];
        return;
        
    }else{
        //要改
        [self postMethod1];
    }
    
}
#pragma mark 上传数据
-(void)postMethod1{
   
    if (_flage==1) {
        
        url1=[BassAPI requestUrlWithPorType:PortTypeSaveAddress];
    }else if(_flage==0){
        url1=[BassAPI requestUrlWithPorType:PortTypeUpAddress];
    }
    NSDictionary *dc=nil;
    if ([de objectForKey:@"newUserId"]) {
        dc=@{ @"userId":[de objectForKey:@"userId"] };
    }else{
       dc=@{ @"userId":[de objectForKey:@"userId"]
                           };
    
    }
    
    
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dc options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSMutableDictionary *dic2=[[NSMutableDictionary alloc] init];
    if ([_deadd objectForKey:@"longitude"]) {
        [dic2 setObject:textfield1.text forKey:@"consignee"];
        [dic2 setObject:textfield2.text forKey:@"mobile"];
        [dic2 setObject:textfield4.text forKey:@"area"];
        [dic2 setObject:textfield5.text forKey:@"deaddress"];
        [dic2 setObject:[_deadd objectForKey:@"longitude"] forKey:@"longitude"];
        [dic2 setObject:[_deadd objectForKey:@"latitude"] forKey:@"latitude"];
         [dic2 setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [dic2 setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }

       
        [dic2 setObject:json forKey:@"appuserId"];
        [dic2 setObject:@true forKey:@"model"];
        [dic2 setObject:textfield3.text forKey:@"telephone"];
        [dic2 setObject:VERSION forKey:@"ios_version"];
//        dic1=@{@"consignee":textfield1.text,@"mobile":textfield2.text,@"area":textfield4.text,@"deaddress":textfield5.text,@"longitude":[deadd objectForKey:@"longitude"],@"latitude":[deadd objectForKey:@"latitude"],@"sessionid":[de objectForKey:@"sessionid"],@"appuserId":json,@"model":@true,@"telephone":textfield3.text,@"ios_version":VERSION
//              };
       
        
    }else{
        NSString *adressstr=[NSString stringWithFormat:@"%@",[_d objectForKey:@"id"]];
        //[Uikility alert:@"vhvhvhvhjjjvjvjvjvj"];
        [dic2 setObject:textfield1.text   forKey:@"consignee"];
        [dic2 setObject:textfield2.text  forKey:@"mobile"];
        [dic2 setObject:textfield4.text  forKey:@"area"];
        [dic2 setObject:textfield5.text  forKey:@"deaddress"];
        [dic2 setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [dic2 setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
         }
        
        [dic2 setObject:json forKey:@"appuserId"];
        [dic2 setObject:@true forKey:@"model"];
        [dic2 setObject:textfield3.text forKey:@"telephone"];
        [dic2 setObject:textfield6.text forKey:@"zipcode"];
        [dic2 setObject:adressstr forKey:@"addressId"];
        [dic2 setObject:VERSION forKey:@"ios_version"];
//        dic1=@{@"consignee":textfield1.text,@"mobile":textfield2.text,@"area":textfield4.text,@"deaddress":textfield5.text,@"sessionid":[de objectForKey:@"sessionid"],@"appuserId":json,@"model":@true,@"telephone":textfield3.text,@"zipcode":textfield6.text,@"addressId":adressstr,@"ios_version":VERSION                        };
        //@"zipcode":textfield6.text,
       
    }
       //
   
        NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:dic2 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json1=[[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
    
        json1=[json1 stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        json1=[json1 stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        json1=[json1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json1=[json1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        json1=[json1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        json1=[json1 stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    
    
    
        NSDictionary *json2=@{@"param":json1
                              };
        [AFManger postWithURLString:url1 parameters:json2 success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[obj objectForKey:@"success"] boolValue];
            NSString *msg=[obj objectForKey:@"msg"];
            
            if (success) {
                [self  Selectdefault];
                //[Uikility alert:@"上传成功！"];
                
                //[self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [Uikility alert:msg];
            }

            
        } failure:^(NSError *error) {
            [Uikility alert:@"上传失败！"];
        }];
    }
//查询
-(void)Selectdefault{
    
    if(_flage==1){
       
   // NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
   url=[BassAPI requestUrlWithPorType:PortTypegetAddressList];
        NSMutableDictionary *dicjson=[Uikility creatSinGoMutableDictionary];
        
//   NSDictionary * dicjson=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId" ],@"model":@1,@"ios_version":VERSION
//              };
        NSDictionary *json2=[Uikility initWithdatajson:dicjson];
       [AFManger postWithURLString:url parameters:json2 success:^(id responseObject) {
           id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[obj objectForKey:@"success"] boolValue];
           if (success) {
               NSArray *arr=[obj objectForKey:@"data"];
               NSDictionary *datadic=[arr objectAtIndex:arr.count-1];
               
               NSNumber *adressid=[datadic objectForKey:@"id"];
               NSNumber *deaddressid;
               for (NSDictionary *adressdic in arr) {
                   NSNumber *flage=[adressdic objectForKey:@"flag"];
                   if (flage.integerValue==1) {
                       deaddressid=[adressdic objectForKey:@"id"];
                   }
               }
               [self Setdefault:adressid deaddressid:deaddressid ];
               
           }

           
       } failure:^(NSError *error) {
          [Uikility alert:@"连接失败！"];
       }];
        
        
        
    
    }else{
        [Uikility alert:@"修改成功"];
    
        [self.navigationController popViewControllerAnimated:YES];
    
    
    }

}
-(void)Setdefault:(NSNumber *)adressid deaddressid:(NSNumber *)deaddressid{
   _seturl=[BassAPI requestUrlWithPorType:PortTypeDefaultAdress];
   NSMutableDictionary *   setdic=[Uikility creatSinGoMutableDictionary];
    if (deaddressid!=nil) {
        [setdic setObject:@0 forKey:@"flag"];
        [setdic setObject:deaddressid forKey:@"addressId"];
        
//        setdic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@0,@"addressId":deaddressid,@"model":@1,@"ios_version":VERSION};
    }else{
        [setdic setObject:@1 forKey:@"flag"];
        [setdic setObject:adressid forKey:@"addressId"];
//   setdic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@1,@"addressId":adressid,@"model":@1,@"ios_version":VERSION};
    }


   NSDictionary *   jsontt=[Uikility initWithdatajson:setdic];
   [AFManger postWithURLString:_seturl parameters:jsontt success:^(id responseObject) {
       id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       
       Boolean success=[[object objectForKey:@"success"] boolValue];
       
       if (success) {
           
           if (deaddressid!=nil) {
               [self setseconddefault:adressid];
           }else{
               [Uikility alert:@"上传成功"];
               [self.navigationController popViewControllerAnimated:YES];
           }
           
       }else{
           
           [Uikility alert:@"上传失败"];
           
       }

   } failure:^(NSError *error) {
       
   }];
    

}
-(void)setseconddefault:(NSNumber *)adressid{
    _seturl=[BassAPI requestUrlWithPorType:PortTypeDefaultAdress];
    NSMutableDictionary *   setdic=[Uikility creatSinGoMutableDictionary];
    
    [setdic setObject:@1 forKey:@"flag"];
    [setdic setObject:adressid forKey:@"addressId"];
    
    
//    setdic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"flag":@1,@"addressId":adressid,@"model":@1,@"ios_version":VERSION};
   
    
    
    NSDictionary *   jsontt=[Uikility initWithdatajson:setdic];
   [AFManger postWithURLString:_seturl parameters:jsontt success:^(id responseObject) {
       id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       
       Boolean success=[[object objectForKey:@"success"] boolValue];
       
       if (success) {
           
           [Uikility alert:@"上传成功"];
           [self.navigationController popViewControllerAnimated:YES];
           
           
       }else{
           
           [Uikility alert:@"上传失败"];
           
       }
       

   } failure:^(NSError *error) {
       
   }];

}
#pragma mark 点击后输入按钮边框上方
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    [self addtoolBar];

}
#pragma mark 键盘 消失否
-(void)addtoolBar{
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30*KIphoneWH)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [textfield1 setInputAccessoryView:topview];
    [textfield2 setInputAccessoryView:topview];
    [textfield3 setInputAccessoryView:topview];
    [textfield4 setInputAccessoryView:topview];
    [textfield5 setInputAccessoryView:topview];
    [textfield6 setInputAccessoryView:topview];
}
//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [textfield5 resignFirstResponder];
    [textfield6 resignFirstResponder];
}
-(void)resignKeyboard{
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [textfield5 resignFirstResponder];
    [textfield6 resignFirstResponder];
}
//键盘小时的代理
-(void)keyboardWillHidden:(NSNotification *)notify{

    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect bounds = self.view.bounds;
        bounds.origin = CGPointZero;
        self.view.bounds = bounds;
    }];



}
   //点击textfiled的代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSInteger i=textField.tag;
    if (i>3) {
        [UIView animateWithDuration:0.25 animations:^{
            /*
             textFiled1.frame = CGRectMake(60, 80, 200, 50);
             textFiled2.frame = CGRectMake(60, 170, 200, 50);
             */
            self.view.bounds = CGRectMake(0, 100*KIphoneWH, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
        

    }
    
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSInteger i=textField.tag;
    if (i<3) {
        [UIView animateWithDuration:0.25 animations:^{
            /*
             textFiled1.frame = CGRectMake(60, 80, 200, 50);
             textFiled2.frame = CGRectMake(60, 170, 200, 50);
             */
            self.view.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }
    
    
    
    return YES;
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
