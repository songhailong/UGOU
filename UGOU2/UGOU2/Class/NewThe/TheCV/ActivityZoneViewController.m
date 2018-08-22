//
//  ActivityZoneViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/3/30.
//
//

#import "ActivityZoneViewController.h"
#import "ThemeCell.h"
#import "AFManger.h"
#import "Uikility.h"
#import "UIImageView+WebCache.h"
#import "ThemeViewController.h"
#import "ActivityGoodViewController.h"
#import "CenterModel.h"
#import "BassAPI.h"
#import "ThemeModel.h"
@interface ActivityZoneViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableview;
    NSMutableArray *_dataASrray;
    NSUserDefaults *def;


}

@end

@implementation ActivityZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataASrray=[[NSMutableArray alloc] init];
    [self creatUI];
    [self afReadData];
}
-(void)creatUI{
    //NSLog(@"----------------%f----%f",self.view.frame.size.height,HEIGHT-40*KIphoneWH-113);
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40*KIphoneWH-113) style:UITableViewStylePlain];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [_tableview registerClass:[ThemeCell class] forCellReuseIdentifier:@"activity"];
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];

}
-(void)afReadData{
    def=[NSUserDefaults standardUserDefaults];
    NSString *activityURL=[BassAPI requestUrlWithPorType:PortTypeActivityZone];
 NSMutableDictionary *activityDic=[Uikility creatSinGoMutableDictionary];
    if ([def objectForKey:@"placename"]) {
        [activityDic setObject:[def objectForKey:@"placename"] forKey:@"area"];
    }
    
    NSDictionary *postDic=[Uikility initWithdatajson:activityDic];
    [AFManger postWithURLString:activityURL parameters:postDic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL suceess=[[objec objectForKey:@"success"] boolValue];
        if (suceess) {
            //NSLog(@"%@",objec);
            NSArray *dataArr=[objec objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                ThemeModel *model=[ThemeModel initWithModeldic:dic];
                model.brandId=[[dic objectForKey:@"appbrandId"] objectForKey:@"id"];
                [_dataASrray addObject:model];
            }
            [_tableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataASrray.count) {
       
        return _dataASrray.count;
    }
    return 0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150*KIphoneWH;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ThemeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"activity" forIndexPath:indexPath];
    cell.imageView.backgroundColor=[UIColor redColor];
    if (_dataASrray.count) {
        ThemeModel *model=[_dataASrray objectAtIndex:indexPath.row];
        [cell.titileimageview sd_setImageWithURL:[Uikility URLWithString:model.img]placeholderImage:[UIImage imageNamed:@"uuu"]];
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataASrray.count) {
        ThemeModel *themeModel=[_dataASrray objectAtIndex:indexPath.row];
    
    CenterModel *model=[[CenterModel alloc] init];
        model.VCtype=0;
        model.brandID=themeModel.brandId;
        model.flag=themeModel.flag.intValue;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushcenter" object:model];
}

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
