//
//  BrandDynamicViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/3/30.
//
//

#import "BrandDynamicViewController.h"
#import "BassAPI.h"
#import "Uikility.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "ThemeCell.h"
#import "CenterModel.h"
#import "ThemeModel.h"

@interface BrandDynamicViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dateArray;
    NSUserDefaults *def;
}

@end

@implementation BrandDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _dateArray=[[NSMutableArray alloc] init];
    [self creatUI];
    [self afReadDate];
    
}
-(void)creatUI{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40*KIphoneWH-113) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ThemeCell class] forCellReuseIdentifier:@"brandcell"];
    [self.view addSubview:_tableView];

}
-(void)afReadDate{
    def=[NSUserDefaults standardUserDefaults];
    NSString *brandURL=[BassAPI requestUrlWithPorType:PortTypeBrandDynamics];
    NSMutableDictionary *brandDic=[Uikility creatSinGoMutableDictionary];
    if ([def objectForKey:@"placename"]) {
        [brandDic setObject:[def objectForKey:@"placename"] forKey:@"area"];
    }
    
    NSDictionary *postDic=[Uikility initWithdatajson:brandDic];
    
    [AFManger postWithURLString:brandURL parameters:postDic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL sucess=[[objec objectForKey:@"success"] boolValue];
        
        if (sucess) {
           
            NSArray *data=[objec objectForKey:@"data"];
            for (NSDictionary *dic in data) {
                [_dateArray addObject:[ThemeModel initWithModeldic:dic]];
            }
            [_tableView reloadData];
        }else{
        
           // [Uikility alert:[objec objectForKey:@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网速不佳"];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dateArray.count) {
        return _dateArray.count;
    }
    return 0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150*KIphoneWH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"brandcell" forIndexPath:indexPath];
    if (_dateArray.count) {
        ThemeModel *model=[_dateArray objectAtIndex:indexPath.row];
        [cell.titileimageview sd_setImageWithURL:[Uikility URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"uuu"]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dateArray.count) {
        ThemeModel *themeModel=[_dateArray objectAtIndex: indexPath.row];
        CenterModel *model=[[CenterModel alloc] init];
        model.VCtype=1;
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
