//
//  CouponsViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 16/11/23.
//
//

#import "CouponsViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "CouponsModel.h"
#import "CardTableViewCell.h"
#import "GkViewController.h"
#import "Singonarray.h"
#import "UGHeader.h"
static const CGFloat titleHeight= 40;
@interface CouponsViewController ()<UITableViewDataSource,UITableViewDelegate,UGCustomnNavViewDelegate>{

    UITableView *_table;
    NSMutableArray *_dataarray;
    NSMutableArray *_array;
    
    NSUserDefaults *dc;
    // NSString *strurl;
    UIImageView *  _imageview;
}

@end

@implementation CouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dc=[NSUserDefaults standardUserDefaults];
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;
    
    self.view.backgroundColor=[UIColor greenColor];
    [self.view setBackgroundColor:[UIColor colorWithRed: 231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1]];
    _dataarray=[NSMutableArray array];
    _array=[NSMutableArray array];

    [self addtable];
    //[self jsonkj];
    [self screebrand];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    UILabel *custemNav=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, titleHeight)];
//    custemNav.Delegate=self;
//    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    //[custemNav setLeftImage:[UIImage imageNamed:@"返回p"]];
    custemNav.text=@"我的卡券";
    custemNav.textAlignment=NSTextAlignmentCenter;
    custemNav.backgroundColor=UGColor(231, 231, 231);
    custemNav.textColor=[UIColor blackColor];
    [self.view addSubview:custemNav];
    
    UIButton *closeBtn=[[UIButton alloc] initWithFrame:CGRectMake(10*KIphoneWH, 500*KIphoneWH-50*KIphoneWH, WIDTH-20*KIphoneWH, 40*KIphoneWH)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.layer.cornerRadius=20*KIphoneWH;
    closeBtn.backgroundColor=UGColor(218, 42, 46);
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}
-(void)closeAction{
     [self push];
}
-(void)LeftItemAction{
    [self push];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
-(void)push{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addtable{
//    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-110*KIphoneWH, NavHeight, 100*KIphoneWH, 30*KIphoneWH)];
//    [but setTitle:@"过期代金券" forState:UIControlStateNormal];
//    [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    but.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
//    [but addTarget:self action:@selector(pushold) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:but];
  //  NSLog(@"%@",_couponsarr);
    CGFloat frameH=self.view.frame.size.height;
    //NSLog(@"%@------%f",_couponsarr,frameH);
    //_table=[[UITableView alloc]initWithFrame:CGRectMake(10*KIphoneWH, titleHeight, WIDTH-20*KIphoneWH, 500*KIphoneWH-40*KIphoneWH-titleHeight) ];
    _table=  [[UITableView alloc] initWithFrame: CGRectMake(10*KIphoneWH, titleHeight, WIDTH-20*KIphoneWH, 500*KIphoneWH-40*KIphoneWH-titleHeight-20) style:UITableViewStylePlain];
    self.view.backgroundColor=[UIColor colorWithRed: 231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    [self.view addSubview:_table];
    _table.delegate=self;
    _table.dataSource=self;
    _table.rowHeight=110*KIphoneWH;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor colorWithRed: 231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    
    
}
-(void)pushold{
    
    GkViewController *g=[[GkViewController alloc]init];
    g.array=_array;
    [self.navigationController pushViewController:g animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_dataarray.count){
        return _dataarray.count;
        }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    
    CardTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[CardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.shareBt.alpha=0.0;
    }
    
    
    if (_dataarray.count) {
        CouponsModel *model=[_dataarray objectAtIndex:indexPath.row];
        NSString * moneystr=[NSString stringWithFormat:@"¥%@", model.money01  ];
        cell.pricelable.text=moneystr;
        cell.pricelable.textColor=[UIColor  colorWithRed:252.0/255.0 green:13.0/255.0 blue:59.0/255.0 alpha:1];
        NSString *money2=[NSString stringWithFormat:@"满%@元可用",model.money02];
        cell.propolable.text=money2;

        cell.namelable.text=model.name;
         cell.namelable.textColor=[UIColor colorWithRed:253.0/255.0 green:149.0/255.0 blue:43.0/255.0 alpha:1];
        long long s=  model.validity.longLongValue;
        NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];
        long gg=sss.integerValue;
        NSString *timestr=[Uikility Datetodatestyle:gg];
        long long vs=  model.days.longLongValue;
        NSString *vsss=[NSString stringWithFormat:@"%lld",vs/1000];
        
        long vgg=vsss.integerValue;
        NSString *vtimestr=[Uikility Datetodatestyle:vgg];
        cell.timelable.text=[NSString stringWithFormat:@"%@ 至 %@",  timestr,vtimestr];
        cell.timelable.textColor=[UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1];
        cell.but.tag=indexPath.row;
        
        if ([dc objectForKey:@"ids"]) {
            NSArray *arr=[dc objectForKey:@"ids"];
            for (NSData *d  in arr) {
                CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d];
                
                if ([dmol.id isEqualToNumber: model.id]) {
                    [cell.but setTitle:@"已选择" forState:UIControlStateNormal];
                    cell.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.1f];
                    //}
                }
            }
            
        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
          CouponsModel *model=_dataarray[indexPath.row];
        if ([dc objectForKey:@"ids"]) {
            NSArray *arr=[dc objectForKey:@"ids"];
            for (NSData *d  in arr) {
                CouponsModel *dmol=[NSKeyedUnarchiver unarchiveObjectWithData:d ];
                if ( [dmol.id isEqualToNumber: model.id]) {
                    [Uikility alert:@"已选择！"];
                    return;
                    
                }
            }
        }
        //如果是通用券
        NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
        NSString *s=[NSString stringWithFormat:@"%zd",_buttag];
        model.buttag=s;
        [d setValue:model.id forKey:s];
        
        //传过去  再传回来
        if ([dc objectForKey:@"ids"]) {
            NSMutableArray *arr=[NSMutableArray array];
            NSArray *array=[dc objectForKey:@"ids"];
            [arr addObjectsFromArray:array];
            NSData *data=[NSKeyedArchiver archivedDataWithRootObject:model];
            [arr addObject:data];
            [dc setObject:arr forKey:@"ids"];
        }else{
            
            NSMutableArray *arr=[NSMutableArray array];
            NSData * data=[NSKeyedArchiver archivedDataWithRootObject:model];
            [arr addObject:data];
            [dc setObject: arr forKey:@"ids"];
        }
        
        
#pragma mark---调用代理
        
       // [self.orderdeleget preferentialchangge:model.money01.integerValue page:_buttag];
        [self.orderdeleget selectCouponsId:model.id];
        [self  dismissViewControllerAnimated:YES completion:nil];
        //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)screebrand{
    [_dataarray removeAllObjects];
   
    for (CouponsModel *model in _couponsarr) {
        
        if (model.brandids) {
            if (model.brandids.integerValue==_brandid.integerValue) {
                [_dataarray addObject:model];
                }
        }else{
           [_dataarray addObject:model];
        }
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
