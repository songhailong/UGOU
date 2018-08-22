//
//  MainHearViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/2/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "MainHearViewController.h"
#import "MainHearCell.h"
#import "Uikility.h"
//#import "UIImageView+WebCache.h"
@interface MainHearViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    

}

@end

@implementation MainHearViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        CGRect rect=self.view.bounds;
        _tableview=[[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        
        [self.view addSubview:_tableview];
        
    }
    
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*KIphoneWH;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_array.count) {
        return _array.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainHearCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qqq"];
    if (!cell) {
        cell=[[MainHearCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
        
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  
}
-(void)readloaddata{
    [_tableview reloadData];

}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
