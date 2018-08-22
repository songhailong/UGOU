//
//  SMorderstatusViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/25.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "SMorderstatusViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "SMmodel.h"
#import "OrderstatusTableViewCell.h"
#import "UGHeader.h"
@interface SMorderstatusViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate>
{
    NSMutableArray *_dataarray;
    UITableView *_tableview;
    NSUserDefaults * _defue;

}

@end

@implementation SMorderstatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _defue=[NSUserDefaults standardUserDefaults];
    _dataarray=[[NSMutableArray alloc] init];
    [self creattable];
    [self jsondata];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custemNav.Delegate=self;
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    custemNav.title=@"订单状态";
    [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:custemNav];
    
}
-(void)LeftItemAction{
    [self pushback];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden=YES;


}
-(void)pushback{

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark---------数据请求
-(void)jsondata{
    
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeSmOrderStatusList ];
    
    if ([_defue objectForKey:@"userId"]) {
        NSMutableDictionary *dicurl=[Uikility creatSinGoMutableDictionary];
        [dicurl setObject:_orderno forKey:@"order_no"];
        
//        NSDictionary *dicurl=@{@"sessionid":[_defue objectForKey:@"sessionid"],@"userId":[_defue objectForKey:@"userId"],@"newUserId":[_defue objectForKey:@"newUserId"],@"order_no":_orderno,@"model":@1,@"ios_version":VERSION};
        
        NSDictionary *jsondic=[Uikility initWithdatajson:dicurl];
        
        
         [AFManger postWithURLString:url parameters:jsondic success:^(id responseObject) {
             id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             
             Boolean success=[[object objectForKey:@"success"] boolValue];
             
             if (success) {
                 NSArray *arr=[object objectForKey:@"data"];
                 for (NSDictionary * oederdic in  arr) {
                     [_dataarray addObject:[SMmodel initModelWithdic:oederdic]];
                 }
                 [_tableview reloadData];
                 
             }else{
                 
                 
             }

         } failure:^(NSError *error) {
             [Uikility alert:@"当前网络有问题"];
         }];
    }else{
    
        [Uikility alert:@"请先登录"];
    }
}
#pragma mark-------ui搭建
-(void)creattable{

    _tableview= [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight)];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSelectionStyleNone;
    [_tableview registerClass:[OrderstatusTableViewCell class] forCellReuseIdentifier:@"order"];
    _tableview.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:232.0/255.0 blue:238.0/255.0 alpha:1];
    [self.view addSubview:_tableview];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataarray.count) {
        return _dataarray.count;
    }

    return 0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 100*KIphoneWH;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderstatusTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"order" forIndexPath:indexPath];
    if (_dataarray.count) {
    SMmodel *model=_dataarray[indexPath.row];
        cell.namelable.text=model.title;
        cell.titlelable.text=model.body;
//        long gg=model.time.integerValue;
//        
//        NSString *timestr=[Uikility Datetodatestyle:gg];
//
        long long s=  model.time.longLongValue;
        NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];
        
        long gg=sss.integerValue;
        
        NSString *timestr=[Uikility DatetoTime:gg];
        NSString *str=       [timestr substringFromIndex:11];
        NSString *time=[str substringToIndex:5];
        cell.timelable.text=time;
                
    }
    
    
    return cell;

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
