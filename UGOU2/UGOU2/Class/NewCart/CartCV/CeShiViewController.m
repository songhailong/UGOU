//
//  CeShiViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰靓萌服饰 on 16/10/28.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CeShiViewController.h"
#import "BassAPI.h"
#import "Uikility.h"
#import "AFManger.h"
#import "VipOrCartTableViewCell.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"
#import "AllcardModel.h"
@interface CeShiViewController ()<UITableViewDelegate,UITableViewDataSource,VipCardDelegate>
{
    NSUserDefaults *de;
    NSInteger  _flag;
    NSMutableArray * _dataarray;
    NSMutableArray *  _ordinaarr;
    NSMutableArray * _viparr;
    NSString *url;
    NSDictionary *shopcartDiscountdic;
    UITableView *_tableview;
    

}

@end

@implementation CeShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    de=[NSUserDefaults standardUserDefaults];
    _flag=1;
    _dataarray=[[NSMutableArray alloc] init];
    _viparr=[[NSMutableArray alloc] init];
    _ordinaarr=[[NSMutableArray alloc] init];

    [self creatUI];
    [self readdata];
    
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [_tableview registerClass:[VipOrCartTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableview];

}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataarray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VipOrCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate=self;
    cell.celltag=indexPath.section;
    if(_dataarray.count){
        AllcardModel *model=_dataarray[indexPath.section];
        
       
    
        NSInteger sss=model.goods.count;
        
        [cell reloadtabview:model.goods isEidingAll:NO];
    }
    
    
        
    
    return cell;
}
#pragma mark    删除商品的代理
-(void)removecellindex:(NSNumber *)cardGoodsId indexPath:(NSIndexPath *)indexPath cellTag:(NSInteger)cellTag{
        if ([de objectForKey:@"sessionid"]) {
            // 购物车删除数据
    url=[BassAPI requestUrlWithPorType:PortTypeDeletpuCart];
            NSMutableDictionary *json1=[Uikility creatSinGoMutableDictionary];
            [json1 setObject:cardGoodsId forKey:@"shopcartId"];
            
//      NSDictionary*json1=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"shopcartId":cardGoodsId,@"model":@1,@"ios_version":VERSION};
        NSDictionary *dicss=[Uikility initWithdatajson:json1];
  [AFManger postWithURLString:url parameters:dicss success:^(id responseObject) {
    id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
    Boolean success=[[strs objectForKey:@"success"] boolValue];
    if (success) {
//        if (_dataarray.count) {
//        NSMutableArray *arrayse=[_dataarray objectAtIndex:indexPath.section];
//        [arrayse removeObjectAtIndex:indexPath.row];
//        if (arrayse.count==0) {
//            [_dataarray removeObjectAtIndex:indexPath.section];
//                        }
//                    }
                    //[_table reloadData];
//                    _price=0;
//                    _pricelable.text=[NSString stringWithFormat:@"￥%d",0];
//                    [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
//                    [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
//                    //_table.allowsMultipleSelectionDuringEditing=YES;
//                    // _table.editing=YES;
//                    [_table reloadData];
//                    // [self json];
    
                }else{
    
                [Uikility alert:[strs objectForKey:@"msg"]];
        }
                
            } failure:^(NSError *error) {
                [Uikility alert:@"数据接受失败！"];
            }];
            
        }else{
            [Uikility alert:@"请先登录！"];
            
        }



}
#pragma mark----cell选中和取消的代理
-(void)selectCellindexarr:(NSArray *)indexarr indexPath:(NSIndexPath *)indexPath cellTag:(NSInteger)cellTag IsSelect:(BOOL)IsSelect
{
    AllcardModel *allmodel=_dataarray[cellTag];
    NSMutableArray*goodarr=allmodel.goods[indexPath.section];
    CartModel *model=goodarr[indexPath.row];
    model.editing=!model.isediting;
  
    [goodarr replaceObjectAtIndex:indexPath.row withObject:model];
    [allmodel.goods replaceObjectAtIndex:indexPath.section withObject:goodarr];
    [_dataarray replaceObjectAtIndex:cellTag withObject:allmodel];

    
}
-(void)tablecellselectall{
    
    for (int i=0;i<_dataarray.count;i++)
    {
        AllcardModel *allmodel=_dataarray[i];
        
        
        for (int j=0;j<allmodel.goods.count;j++) {
            NSMutableArray *brandArr=allmodel.goods[j];
            for (int k;k<brandArr.count;k++) {
                CartModel *model=brandArr[k];
                model.editing=YES;
                [brandArr replaceObjectAtIndex:k withObject:model];
            }
            [allmodel.goods replaceObjectAtIndex:j withObject:brandArr];
            
        }
        [_dataarray replaceObjectAtIndex:i withObject:allmodel];
        
    }
    [_tableview reloadData];


}
-(void)cellcancelall{
    for (int i=0;i<_dataarray.count;i++)
    {
        AllcardModel *allmodel=_dataarray[i];
        
        
        for (int j=0;j<allmodel.goods.count;j++) {
            NSMutableArray *brandArr=allmodel.goods[j];
            for (int k;k<brandArr.count;k++) {
                CartModel *model=brandArr[k];
                model.editing=NO;
                [brandArr replaceObjectAtIndex:k withObject:model];
            }
            [allmodel.goods replaceObjectAtIndex:j withObject:brandArr];
            
        }
        [_dataarray replaceObjectAtIndex:i withObject:allmodel];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_dataarray.count){
        CGFloat all=0;
        AllcardModel *model=_dataarray[indexPath.section];
        for (NSArray *arr in model.goods ) {
            
         all=all+50*KIphoneWH;
         all=arr.count*100*KIphoneWH+all;
        
        }
        
        return all;
    }
    return  0;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor redColor];
    
    return view;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20*KIphoneWH;
}
-(void)readdata{
    if ([de objectForKey:@"sessionid"]) {
        //解析数据
       
        url=[BassAPI requestUrlWithPorType:PortTypeNewSelectCart];
        NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
        
//        NSDictionary *dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"], @"model":@true,@"ios_version":VERSION};
        
        NSString *dicss=[Uikility initWithdatajsonstring:dic];
        NSString  * userid=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        NSString *bassid=[GTMBase64 encodeBase64String:userid];
        NSString *jsonaes=[SecurityUtil encryptAESData:dicss passwordKey:[de objectForKey:COOKIE]];
        NSDictionary *dicurl=@{@"param":jsonaes};
        [AFManger headerFilePostWithURLString:url parameters:dicurl Hearfile:bassid success:^(id responseObject) {
              id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
           
        if (success) {
           
       
      shopcartDiscountdic=[strs objectForKey:@"shopcartDiscount"];
        [_dataarray removeAllObjects];
            //解析
            NSDictionary *dataDic=[strs objectForKey:@"data"];
            
            NSDictionary *ordinary=[dataDic objectForKey:@"ordinaryShopCart"];
            if (ordinary!=nil) {
                [ordinary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    NSMutableArray *farr=[[NSMutableArray alloc] init];
                    for (NSDictionary *goodsdic in obj) {
                        
                         CartModel *model=[CartModel initwithdic:goodsdic];
                        NSDictionary *dicc=[goodsdic objectForKey:@"appgoodsId"];
                        model.cardgoodid=[goodsdic objectForKey:@"id"];
                         model.goodsName=[[goodsdic objectForKey:@"appgoodsId" ] objectForKey:@"goodsName"];
                        model.id=[dicc objectForKey:@"id"];
                        model.logopicUrl=[dicc objectForKey:@"logopicUrl"];
                        model.goodsPrice=[dicc objectForKey:@"originalPrice"];
                        model.promotionPrice=[dicc objectForKey:@"promotionPrice"];
                        model.vipPrice=[dicc objectForKey:@"vipPrice"];
                        NSDictionary *dicc1=[dicc objectForKey:@"appbrandId"];
                        model.brandName=[dicc1 objectForKey:@"brandName"];
                        model.logopic=[dicc1 objectForKey:@"logopic"];
                        model.brandid=[dicc1 objectForKey:@"id"];
                        model.appStoresId=[[dic objectForKey:@"appStoresId"] objectForKey:@"id"];
                      [farr addObject:model];

                    }
                    
                    [_ordinaarr addObject:farr];
                   
                }];
                AllcardModel *model=[[AllcardModel alloc] init];
                model.vipFlag=NO;
                model.goods=_ordinaarr;
                [_dataarray addObject:model];
            }
            
            NSDictionary *vipShopCart=[dataDic objectForKey:@"vipShopCart"];
            if (vipShopCart!=nil) {
                
                
                
                [vipShopCart enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    NSMutableArray *farr=[[NSMutableArray alloc] init];
                    for (NSDictionary *goodsdic in obj) {
                        
                        CartModel *model=[CartModel initwithdic:goodsdic];
                        NSDictionary *dicc=[goodsdic objectForKey:@"appgoodsId"];
                        model.cardgoodid=[goodsdic objectForKey:@"id"];
                        model.goodsName=[[goodsdic objectForKey:@"appgoodsId" ] objectForKey:@"goodsName"];
                        model.id=[dicc objectForKey:@"id"];
                        model.logopicUrl=[dicc objectForKey:@"logopicUrl"];
                        model.goodsPrice=[dicc objectForKey:@"originalPrice"];
                        model.promotionPrice=[dicc objectForKey:@"promotionPrice"];
                        model.vipPrice=[dicc objectForKey:@"vipPrice"];
                        NSDictionary *dicc1=[dicc objectForKey:@"appbrandId"];
                        model.brandName=[dicc1 objectForKey:@"brandName"];
                        model.logopic=[dicc1 objectForKey:@"logopic"];
                        model.brandid=[dicc1 objectForKey:@"id"];
                        model.appStoresId=[[dic objectForKey:@"appStoresId"] objectForKey:@"id"];
                        [farr addObject:model];
                        
                    }
                    
                    [_viparr addObject:farr];
                  
               }];
                AllcardModel *model=[[AllcardModel alloc] init];
                model.vipFlag=NO;
                model.goods=_viparr;
                [_dataarray addObject:model];
            }
            [_tableview reloadData];
            
            }else{
            [_dataarray removeAllObjects];
            [_tableview reloadData];
        if ([[strs objectForKey:@"msg"] isEqual:@"您的购物车中没有商品！"])
        {
        }
            [Uikility alert:[strs objectForKey:@"msg"]];
                            
                        }

            
        } failure:^(NSError *error) {
            
        }];
        

    }else{
        // [Uikility alert:@"请先登录！"];
        //LoginViewController *log=[[LoginViewController alloc] init];
        //[self.navigationController pushViewController:log animated:YES];
        
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
