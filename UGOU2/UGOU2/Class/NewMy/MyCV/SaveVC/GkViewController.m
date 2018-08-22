//
//  GkViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/2.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "GkViewController.h"
#import "Uikility.h"
#import "CardTableViewCell.h"
#import "CouponsModel.h"
@interface GkViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_table;
}

@end

@implementation GkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1"]forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回p"] style:UIBarButtonItemStyleDone target:self action:@selector(popkj)];
   self.navigationItem.leftBarButtonItem=leftButton;
    self.navigationController.navigationBar.translucent=NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=@"过期卡券";
    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
    self.navigationItem.titleView=label;
    self.view.backgroundColor=[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
     
    [self addtable];
   

    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.navigationController.navigationBar.hidden=YES;

}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
    
}
-(void)popkj{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addtable{
    
    _table=[[UITableView alloc]initWithFrame:CGRectMake(10*KIphoneWH, 30*KIphoneWH, WIDTH-20*KIphoneWH, HEIGHT-30*KIphoneWH) ];
    [self.view addSubview:_table];
    _table.delegate=self;
    _table.dataSource=self;
    _table.rowHeight=120*KIphoneWH;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor colorWithRed: 238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_array.count){
        return _array.count;
     
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    CardTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[CardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (_array.count) {
        CouponsModel *model=[_array objectAtIndex:indexPath.row];
        NSString * moneystr=[NSString stringWithFormat:@"¥%@", model.money01  ];
        cell.pricelable.text=moneystr;
        cell.pricelable.textColor=[UIColor blackColor];
        NSString *money2=[NSString stringWithFormat:@"满%@元可用",model.money02];
        cell.propolable.text=money2;
        if (model.brandName) {
            NSString *namestr=[NSString stringWithFormat:@"%@代金券",model.brandName];
            cell.namelable.text=namestr;
            cell.namelable.textColor=[UIColor colorWithRed:253.0/255.0 green:149.0/255.0 blue:43.0/255.0 alpha:1];
        }else{
            cell.namelable.text=@"通用代金券";
            cell.namelable.textColor=[UIColor colorWithRed:253.0/255.0 green:149.0/255.0 blue:43.0/255.0 alpha:1];
        }
        long long s=  model.days.longLongValue;
        NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];
        
        long gg=sss.integerValue;
        ////////////////////////NSLog(@"%zd",gg);
        NSString *timestr=[Uikility Datetodatestyle:gg];
        
        
      
        cell.timelable.text=[NSString stringWithFormat:@"已过期 有效日期至%@",  timestr];
        cell.timelable.textColor=[UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1];
        
        cell.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.1f];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
