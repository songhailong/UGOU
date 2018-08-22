//
//  PushMessageViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/18.
//

#import "PushMessageViewController.h"
#import "UGHeader.h"
#import "PushModle.h"
#import "BassAPI.h"
#import "MJRefresh.h"
#import "UITabBar+Category.h"
#import "PushMessageTableViewCell.h"
@interface PushMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UGCustomnNavViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView * _tableview;
    NSInteger _hang;
}
@end

@implementation PushMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc] init];
    _hang=0;
    [self creatUI];
    [self readDate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    UGCustomNavView *cutemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    cutemNav.Delegate=self;
    [cutemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    
        cutemNav.title=@"推送消息";
    
    [cutemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:cutemNav];
}
-(void)LeftItemAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatUI{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableview registerClass:[PushMessageTableViewCell class] forCellReuseIdentifier:@"pushCell"];
    _tableview.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _hang++;
        [self readDate];
    }];
}
-(void)readDate{
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    NSInteger  miNnum=_hang *20;
    NSInteger  max=(_hang +1)*20;
    NSNumber *mn=[NSNumber numberWithInteger:miNnum];
    NSNumber *maxnum=[NSNumber numberWithInteger:max];
    [dic setObject:mn forKey:@"min"];
    [dic setObject:maxnum forKey:@"max"];
    NSDictionary *postDic=[Uikility initWithdatajson:dic];
    NSString *urlstr=[BassAPI requestUrlWithPorType:portTypeGetPushMessage];
    if (urlstr==nil) {
        return;
    }
    [AFManger postWithURLString:urlstr parameters:postDic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL issucess=[[object objectForKey:@"success"] boolValue];
        
        if (issucess) {
            long nowtime=[Uikility readnowtime];
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            [def setInteger:nowtime forKey:unwrapTime];
            [self.tabBarController.tabBar hideBadgeOnItemIdex:3];
            NSArray * dataarr=[object objectForKey:@"data"];
            for (NSDictionary *dic in dataarr) {
                PushModle *model =[PushModle initWithDic:dic];
                [_dataArr addObject:model];
            }
            [_tableview reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArr.count) {
        return _dataArr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60*KIphoneWH;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PushMessageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"pushCell" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor redColor];
    if (_dataArr.count) {
        PushModle *model=[_dataArr objectAtIndex:indexPath.row];
        cell.titleLable.text=model.title;
        cell.textLable.text=model.content;
        //long time=model.reTime.longValue;
        
        long long vs=  model.reTime.longLongValue;
        NSString *vsss=[NSString stringWithFormat:@"%lld",vs/1000];
        
        long vgg=vsss.integerValue;
        cell.timeLable.text=[Uikility DatetoTime:vgg];
 
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
