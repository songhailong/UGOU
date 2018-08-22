//
//  UGBidSrecordViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/27.
//

#import "UGBidSrecordViewController.h"
#import "UGCustomNavView.h"
#import "UGHeader.h"
#import "BassAPI.h"
#import "SVProgressHUD.h"
#import "UGBidSrecordTableViewCell.h"
#import "UGMarginModel.h"
@interface UGBidSrecordViewController ()<UGCustomnNavViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UGCustomNavView *_CustomNavView;
    UITableView *_tableview;
    NSMutableArray *_dataArr;
}

@end

@implementation UGBidSrecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc] init];
    UGMarginModel *model=[[UGMarginModel alloc] init];
    model.staus=@"状态";
    model.userName=@"竞拍号";
    model.time=@"时间";
    model.Price=@"价格";
    [_dataArr insertObject:model atIndex:0];
    [self ug_creatBidSrecodUI];
    [self ug_loadDate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    _CustomNavView=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    //[_CustomNavView.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    _CustomNavView.Delegate=self;
    _CustomNavView.title=@"出价记录";
    _CustomNavView.titleView.textColor=[UIColor blackColor];
    [_CustomNavView setLeftImage:[UIImage imageNamed:@"返回p"]];
    //[custemView.leftButton setImage:[UIImage imageNamed:@"返回p"] forState:UIControlStateNormal];
    [self.view addSubview:_CustomNavView];
}
-(void)LeftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ug_loadDate{
    NSString  * urlstr=[BassAPI requestUrlWithPorType:portTypeGiveInsertList];
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    [dic setObject:self.auctionId forKey:@"auctionId"];
    NSDictionary *postDic=[Uikility initWithdatajson:dic];

    [SVProgressHUD showWithStatus:@"正在加载"];
    //弹窗颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //设置小菊花转圈
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [AFManger postWithURLString:urlstr parameters:postDic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        BOOL isSucess=[[object objectForKey:@"success"] boolValue];
        if(isSucess){
            NSArray *dataA=[object objectForKey:@"data"];
            for (NSDictionary *dateD in dataA) {
                UGMarginModel *model=[UGMarginModel initModelWithDic:dateD];
                model.userName=[[dateD objectForKey:@"appuserId"]objectForKey:@"userName"];
                [_dataArr addObject:model];
            }
            [_tableview reloadData];
            
           
        }else{
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网速不佳"];
        [SVProgressHUD dismissWithDelay:2.0];
        
    }];
}
-(void)ug_creatBidSrecodUI{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [_tableview registerClass:[UGBidSrecordTableViewCell class] forCellReuseIdentifier:@"SrecordTableViewCell"];
    _tableview.separatorStyle=NO;
    [self.view addSubview:_tableview];
    
    
    //[_tableview reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30*KIphoneWH;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UGBidSrecordTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"SrecordTableViewCell" forIndexPath:indexPath];


    UGMarginModel *model=_dataArr[indexPath.row];
      cell.numberLable.text=model.userName;
    if (indexPath.row==0) {
        cell.priceLable.text=model.Price;
         cell.stateLable.text=model.staus;
        cell.timeLable.text=model.time;
    }else{
        NSString *stt=[NSString stringWithFormat:@"%@",model.seprice];
        cell.priceLable.text=stt;
        long retime=model.reTime.longValue/1000;
        NSString *timeStr=[Uikility DatetoTime:retime];
        cell.timeLable.text=timeStr;
        if (indexPath.row==1) {
            cell.stateLable.text=@"领先";
            cell.stateLable.textColor=UGColor(253, 106, 109);
             cell.numberLable.textColor=UGColor(253, 106, 109);
             cell.priceLable.textColor=UGColor(253, 106, 109);
            cell.timeLable.textColor=UGColor(253, 106, 109);
        }else{
             cell.stateLable.text=@"出局";
            //cell.stateLable.textColor=UGColor(253, 106, 109);
            cell.stateLable.textColor=UGColor(63, 63, 63);
            cell.priceLable.textColor=UGColor(63, 63, 63);
            cell.numberLable.textColor=UGColor(63, 63, 63);
            cell.timeLable.textColor=UGColor(63, 63, 63);
        }
    }
    
    
    return cell;
}
@end
