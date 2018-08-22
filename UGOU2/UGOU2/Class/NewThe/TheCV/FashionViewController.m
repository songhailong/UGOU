//
//  FashionViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/3/30.
//
//

#import "FashionViewController.h"
#import "AFManger.h"
#import "BassAPI.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"
#import "ThemeCell.h"
#import "ThemeViewController.h"
#import "CenterModel.h"
#import "ThemeModel.h"
@interface FashionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;


}

@end

@implementation FashionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray=[[NSMutableArray alloc] init];
    [self creatUI];
    [self afReadData];
    
}
-(void)creatUI{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40*KIphoneWH-113) style:UITableViewStylePlain];
    //_tableView.backgroundColor=[UIColor blueColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ThemeCell class] forCellReuseIdentifier:@"themcell"];
    [self.view addSubview:_tableView];


}
#pragma mark*******获取数据
-(void)afReadData{
    NSString *fashionURL=[BassAPI requestUrlWithPorType:PortTypeSelectTheme];
    NSMutableDictionary *fashionDic=[Uikility creatSinGoMutableDictionary];
    NSDictionary *postDic=[Uikility initWithdatajson:fashionDic];
    [AFManger postWithURLString:fashionURL parameters:postDic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL secuss=[[object objectForKey:@"success"] boolValue];
        if (secuss) {
            
            NSArray *data=[object objectForKey:@"data"];
            for (NSDictionary * dic in data) {
                [_dataArray addObject:[ThemeModel initWithModeldic:dic]];
            }
            [_tableView reloadData];
        }else{
            [Uikility alert:[object objectForKey:@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网速不佳"];
    }];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count) {
        return _dataArray.count;
    }
    return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"themcell" forIndexPath:indexPath];
    if (_dataArray.count) {
        ThemeModel *model=[_dataArray objectAtIndex:indexPath.row];
        [cell.titileimageview sd_setImageWithURL:[Uikility URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"uuu"]];
        
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150*KIphoneWH;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count) {
        ThemeModel *themeModel=[_dataArray objectAtIndex:indexPath.row];
    CenterModel *model=[[CenterModel alloc] init];
    model.VCtype=2;
        model.URLString=themeModel.imgUrl;
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
