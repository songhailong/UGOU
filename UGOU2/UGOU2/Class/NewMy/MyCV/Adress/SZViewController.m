//
//  SZViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/6.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.6.9.24 设置
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "AdressViewController.h"
#import "SZViewController.h"
#import "PlaceViewController.h"
#import "AFManger.h"
#import "SDWebImageManager.h"
#import "LoginViewController.h"
#import "SFViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "LoginViewController.h"
@interface SZViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *table;
      NSMutableArray *muarr;
    
     NSString *url;
    // NSDictionary *dictionary;
}

@end

@implementation SZViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
 self.navigationController.navigationBar.hidden=NO;
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回p"] style:UIBarButtonItemStyleDone target:self action:@selector(push)];
    self.navigationItem.leftBarButtonItem=leftButton;
    self.navigationController.navigationBar.translucent=NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=@"设置";
    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
    self.navigationItem.titleView=label;
    self.view.backgroundColor=[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    [self addtableview];
    muarr=[NSMutableArray array];
    // Do any additional setup after loading the view.
}
#pragma mark 返回上一页
-(void)push{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark tabelview
-(void)addtableview{
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=50*KIphoneWH;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
    table.tableHeaderView=view;
   
    
}
#pragma mark 退出账号
-(void)pushout{
    UIAlertView *outview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认退出当前账号？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [outview show];
}
#pragma mark 弹出框

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //根据被点击按钮的索引处理点击事件,buttonIndex表示被点击的按钮的下标，默认cancel是0
    if (buttonIndex==0) {
        return;
    }else if (buttonIndex==1){
       // NSDictionary *dictionarys = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
//        for(NSString* key in [dictionarys allKeys]){
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sessionid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headimg"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headimgbase"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"newUserId"];
       
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else {
        return 1;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section==0) {
        if(indexPath.row==0){
            cell.textLabel.text=@"收货地址管理";
            
        }else if (indexPath.row==1){
            cell.textLabel.text=@"有效清除图片缓存";
        }else if (indexPath.row==2){
            
            cell.textLabel.text=@"关于我们";
        }
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 15*KIphoneWH, 10*KIphoneWH, 10*KIphoneWH)];
        imv.image=[UIImage imageNamed:@"向前"];
        [cell addSubview:imv];
    }else{
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 50*KIphoneWH)];
        [but setBackgroundColor:[UIColor whiteColor]];
        [but setTitle:@"退出当前的账号！" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(pushout) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:but];
    }
    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self postMethod];
    }else if (indexPath.row==1){
   
        //[[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        NSInteger size =[SDImageCache sharedImageCache].getSize;
        double bysize=size/1000.0/1000.0;
        
        [Uikility alert:[NSString stringWithFormat:@"清除缓存完成"]];
   
    }else if (indexPath.row==2){
        SFViewController *sf=[[SFViewController alloc]init];
        sf.flag=3;
        [self.navigationController pushViewController:sf animated:YES];
    }
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 判断进入那个界面
-(void)postMethod{
   
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        if ([de objectForKey:@"userId"]) {
            url=[BassAPI requestUrlWithPorType:PortTypegetAddressList];
            
            NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
//            NSDictionary *dic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"model":@1,@"ios_version":VERSION
//                                };

            NSDictionary *dictionary=[Uikility initWithdatajson:dic];
            
       [AFManger postWithURLString:url parameters:dictionary success:^(id responseObject) {
           id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[obj objectForKey:@"success"] boolValue];
           if (success) {
               PlaceViewController *place=[[PlaceViewController alloc]init];
               [self.navigationController pushViewController:place animated:YES];
           }else{
               if ([obj objectForKey:@"msg"]) {
                   [Uikility alert:[obj objectForKey:@"msg"]];
               }else{
                   AdressViewController *ad=[[AdressViewController alloc]init];
                   ad.flage=1;
                   ad.hidesBottomBarWhenPushed=YES;
                   [self.navigationController pushViewController:ad animated:YES];
               }
           }
  
       } failure:^(NSError *error) {
           [Uikility alert:@"数据接受失败！"];
       }];
    }else{
        //[Uikility alert:@"请先登录！"];
        LoginViewController *log=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:log animated:YES];
     }

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
