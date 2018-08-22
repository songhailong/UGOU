//
//  InsiderViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/29.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "InsiderViewController.h"
#import "Uikility.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "MainCollectionViewCell.h"
#import "CartModel.h"
#import "BassAPI.h"
#import "SpViewController.h"
#import "FMDBSingleTon.h"
#import "MJRefresh.h"
@interface InsiderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    NSMutableArray *_dataarray;
    UICollectionView *_collectionview;
    NSInteger _hang;
    NSDictionary * _dic;
}

@end

@implementation InsiderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataarray=[[NSMutableArray alloc] init];
    _hang=1;
    // Do any additional setup after loading the view.
    [self creatUI];
    [self readdata];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.navigationBar.hidden = NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=_InsiderName;
    label.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=label;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(popmain)];
    self.navigationItem.leftBarButtonItem=leftButton;
    //    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search1@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(pushsear)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    //self.navigationItem.rightBarButtonItem=rightButton;
    self.navigationController.navigationBar.translucent=NO;
    
}
-(void)popmain{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatUI{
    self.automaticallyAdjustsScrollViewInsets=YES;
    _collectionview.contentInset=UIEdgeInsetsMake(0,3*KIphoneWH, WIDTH, HEIGHT-64*KIphoneWH);
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
   _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 3*KIphoneWH, WIDTH, HEIGHT) collectionViewLayout:flowlayout];
   _collectionview.delegate=self;
    _collectionview.dataSource=self;
   _collectionview.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_collectionview];
    [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"ddd"];
    [self.view addSubview:_collectionview];
    _collectionview.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _hang++;
        [self readdata];
        [_collectionview.footer endRefreshing];
    }];}
#pragma mark 个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataarray.count) {
        return _dataarray.count;
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
}
//2015.10.19.3.50
#pragma mark 具体内容
-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCollectionViewCell *cell=[collectionView  dequeueReusableCellWithReuseIdentifier:@"ddd" forIndexPath:indexPath];
    if (_dataarray.count) {
        CartModel *model=[_dataarray objectAtIndex:indexPath.row];
        
        [cell.imageview sd_setImageWithURL:[Uikility URLWithString:model.logopicUrl]placeholderImage:[UIImage imageNamed:@"uuu"]];
        cell.textlable.text=model.goodsName;
       CGFloat s=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
        cell.pricelable.text=[NSString stringWithFormat:@"￥%.1f",s];
        CGFloat s1=model.goodsPrice.floatValue;
        NSNumber *salecount=model.saleCount;
        cell.salesLable.text=[NSString stringWithFormat:@"%@人付款",salecount];
        if (s1>s) {
            cell.procelable.text=[NSString stringWithFormat:@"￥%.1f",s1];
            cell.procelable.alpha=1;
        }else{
            cell.procelable.alpha=0;
        }
        
        
    }
    return cell;
    
}

#pragma mark 点击tableview
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SpViewController *sp=[[SpViewController alloc]init];
    CartModel *model=[_dataarray objectAtIndex:indexPath.row];
    NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
  
    sp.goodsId=sreid;
    sp.flag=1;
    sp.hidesBottomBarWhenPushed=YES;
    
    //存储
    FMDBSingleTon *singon=[FMDBSingleTon shareSinglotn];
    [singon addshop:model];
    [self.navigationController pushViewController:sp animated:YES];
    
}


-(void)readdata{
  
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    [mudic setObject:@10 forKey:@"max"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    if ([de objectForKey:@"userId"]) {
        if (_hang==1) {
            
            if (_Insiderid.integerValue==17) {
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                    [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                
                [mudic setObject:@0 forKey:@"min"];
                //_dic=@{@"min":@0,@"max":@10,@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"model":@1,@"ios_version":VERSION
                     //  };
            }else{
                [mudic setObject:_Insiderid forKey:@"appcategoryId"];
                [mudic setObject:@0 forKey:@"min"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                    [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
            }
            
        }else{
            NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
            NSNumber * min = @([minstr integerValue]);
            
            if (_Insiderid.integerValue==17) {
                [mudic setObject:min forKey:@"min"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                    [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                }else{
                [mudic setObject:_Insiderid forKey:@"appcategoryId"];
                [mudic setObject:min forKey:@"min"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                    }
            
            }
    }
        
    }else{
        if (_hang==1) {
            
            if (_Insiderid.integerValue==17) {
                
                [mudic setObject:@0 forKey:@"min"];
                
                    }else{
                [mudic setObject:_Insiderid forKey:@"appcategoryId"];
                [mudic setObject:@0 forKey:@"min"];
                
            }
            
            
        }else{
            NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
            NSNumber * min = @([minstr integerValue]);
            if (_Insiderid.integerValue==17) {
                [mudic setObject:min forKey:@"min"];
                
            }else{
             [mudic setObject:min forKey:@"min"];
                [mudic setObject:_Insiderid forKey:@"appcategoryId"];
               
            }
        }
    }
    
    
   
        NSString *url=[BassAPI requestUrlWithPorType:PortTypeSelectInsider];
        NSDictionary *json=[Uikility initWithdatajson:mudic];
    [AFManger postWithURLString:url parameters:json success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
       
        Boolean success=[[obj objectForKey:@"success"] boolValue];
        if (success) {
            NSDictionary *dicdata=[obj objectForKey:@"data"];
            for (NSDictionary *dicc in  dicdata) {
                [_dataarray addObject:[CartModel initwithdic: dicc]];
            }
            [_collectionview reloadData];
        }else{
            [Uikility alert:[obj objectForKey:@"msg"]];
            
            
        }

        
    } failure:^(NSError *error) {
        [Uikility alert:@"连接失败！"];
    }];

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
