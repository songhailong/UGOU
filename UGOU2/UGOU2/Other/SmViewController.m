//
//  SmViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/20.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import "SmViewController.h"
#import "TableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "Uikility.h"
//#import "UIImageView+WebCache.h"
@interface SmViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *managers;
    NSString *meg;
    NSString *dz;
    UIBarButtonItem *leftbut;
}
@end

@implementation SmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addheadview];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.navigationBar.hidden = NO;
}
-(void)addnavigation:(Boolean)flag{
    #pragma mark 导航栏
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40, 50)];
    label.textColor=[UIColor whiteColor];
    label.text=@"上门试衣";
    label.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=label;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
     UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"定位@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
    if (flag) {
       
        leftbut = [[UIBarButtonItem alloc]initWithTitle:dz style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
    }else{
     leftbut = [[UIBarButtonItem alloc]initWithTitle:@"定位…" style:UIBarButtonItemStyleDone target:self action:@selector(dingwei)];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem=rightButton;
    self.navigationItem.leftBarButtonItems=@[left,leftbut];
    self.navigationController.navigationBar.translucent=NO;
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dingwei{

}
-(void)addheadview{
    if (![CLLocationManager locationServicesEnabled]) {
        
        meg=@"定位不可用";
        [self alert];
    }
    //用户
    managers=[[CLLocationManager alloc]init];
    if ([CLLocationManager authorizationStatus]==0) {
        
        [managers requestAlwaysAuthorization];
    }
    //精度
    managers.desiredAccuracy=kCLLocationAccuracyBest;
    //频率 多少米
    managers.distanceFilter=5.0;
    //开始
    managers.delegate=self;
    [managers startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
   
    [self addnavigation:NO];
}
//成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location=[locations firstObject];
   
    CLLocation *loca=[[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate .longitude];
    CLGeocoder *geo=[[CLGeocoder alloc]init];
    [geo reverseGeocodeLocation:loca completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place=[placemarks firstObject];
        
        if (place.thoroughfare) {
            
            
            dz=place.thoroughfare;
        }else{
           
            dz=place.locality;
        }
    }];
    [self addnavigation:YES];
}
-(void)addtableview{
  UITableView * table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT+70) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    table.rowHeight=100;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
   // NSurl *im=[[recommend objectAtIndex:indexPath.row]objectForKey:@"logopic"];
   
    //[cell. imageview sd_setImageWithURL:im placeholderImage:[UIImage imageNamed:@"uuu"]];
    
    cell.imageview.frame=CGRectMake(5, 0, 100, 100);
  
    cell.leftlabel.frame=CGRectMake(110, 5, 150, 30);
    //cell.leftlabel.text=[[recommend objectAtIndex:indexPath.row]objectForKey:@"brandName"];
    cell.dlabel.frame=CGRectMake(110, 30, WIDTH-170, 60);
    cell.dlabel.numberOfLines=0;
    cell.dlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    cell.dlabel.font=[UIFont systemFontOfSize:15];
    //cell.dlabel.text=[[recommend objectAtIndex:indexPath.row]objectForKey:@"detail"];
    cell.titleimageview.frame=CGRectMake(WIDTH-60, 70, 20, 20);
    cell.titleimageview.userInteractionEnabled=YES;
    cell.titleimageview.tag=indexPath.row+3;
   // UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    cell.titleimageview.image=[UIImage imageNamed:@"收藏@2x"];
    //[cell.titleimageview addGestureRecognizer:imgtap];
    
    cell.rightlabel.frame=CGRectMake(WIDTH-40, 70, 40, 30);
    cell.rightlabel.text=@"125";
    cell.rightlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    cell.rightlabel.font=[UIFont systemFontOfSize:15];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    
}
//弹出框
-(void)alert{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:meg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
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
