//
//  VipselectViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/10/9.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "VipselectViewController.h"
#import "Uikility.h"
#import "VipshowTableViewCell.h"
#import "VipModel.h"
#import "AFManger.h"
#import "MBProgressHUD.h"
#import "BassAPI.h"
#import "UGHeader.h"
@interface VipselectViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate>{
    UIImageView *_imageview;
    NSMutableArray *_dataarray;
    NSUserDefaults *def;
    UITableView * _tableview;

}

@end

@implementation VipselectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataarray=[NSMutableArray array];
    def=[NSUserDefaults standardUserDefaults];
    [self creatUI];
    [self readdata];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [_tableview registerClass:[VipshowTableViewCell class] forCellReuseIdentifier:@"vipcell"];
    [self.view addSubview:_tableview];


}
-(void)readdata{
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeGetUservip];
    [mudic setObject:[def objectForKey:@"userId"] forKey:@"userId"];
    [mudic setObject:[def objectForKey:@"sessionid"] forKey:@"sessionid"];
    if ([def objectForKey:@"newUserId"]) {
        [mudic setObject:[def objectForKey:@"newUserId"] forKey:@"newUserId"];
    }
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:@1 forKey:@"model"];
    NSDictionary *jsondic=[Uikility initWithdatajson:mudic];
    [AFManger postWithURLString:urlstr parameters:jsondic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Boolean suscess=[[objec objectForKey:@"success"]boolValue];
        
        if(suscess){
            NSArray  *jsonarr=[objec objectForKey:@"data"];
            for (NSDictionary * vipdic in jsonarr) {
                VipModel *vipmodel=[VipModel initWithVipModeldic:vipdic];
                vipmodel.brandName=[[vipdic objectForKey:@"appbrandId"] objectForKey:@"brandName"];
                [_dataarray addObject:vipmodel];
            }
            [_tableview reloadData];
        }
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网络出现问题"];
    }];

   

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40*KIphoneWH, 20*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH)];
//    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
//    UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
//    _imageview.image=image;
//    //_imageview.backgroundColor=[UIColor greenColor];
//    
//    _imageview.userInteractionEnabled=YES;
//    label.textColor=[UIColor whiteColor];
//    label.text=@"会员中心";
//    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
//    [_imageview addSubview:label];
//    
//    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 60*KIphoneWH, 64*KIphoneWH )];
//    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
//    UIImage *img=[UIImage imageNamed:@"返回p"];
//    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
//    [leftButton addSubview:imgv];
//    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
//    
//    [leftButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchDown];
//    
//    leftButton.tag=1;
//    
//    [self.view addSubview:_imageview];
//    [_imageview  addSubview:leftButton];
    
    self.view.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [custemNav setLeftImage:[UIImage imageNamed:@"返回p"]];
    custemNav.Delegate=self;
    [self.view addSubview:custemNav];
    custemNav.title=@"会员中心";
}
-(void)LeftItemAction{
    
    
    [self push];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_dataarray.count){
    
        return _dataarray.count;
    }
    
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 60;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VipshowTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"vipcell" forIndexPath:indexPath];
    if(_dataarray.count){
        
        VipModel *model=[_dataarray objectAtIndex:indexPath.row];
        if(model.type.integerValue==0){
        //银卡
            cell.iconeimageview.image=[UIImage imageNamed:@"vip_gold"];
           
        }else if (model.type.integerValue==1){
        //金卡
         
        cell.iconeimageview.image=[UIImage imageNamed:@"vip_sliver"];
        }
    
     cell.namelable.text=model.brandName;
     cell.titlelable.text=model.details;
     
    
    }
    
    return cell;

}
-(void)push{

    [self.navigationController popViewControllerAnimated:YES];


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
