//
//  FootprintsViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/19.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "FootprintsViewController.h"
#import "FMDBSingleTon.h"
#import "CartModel.h"
#import "MainCollectionViewCell.h"
#import "Uikility.h"
#import "UIImageView+WebCache.h"
#import "SpViewController.h"
@interface FootprintsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionview;
    NSArray *_dataarray;

}

@end

@implementation FootprintsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cteatUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40, 50)];
    titlelabel.textColor=[UIColor whiteColor];
    
    titlelabel.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=titlelabel;
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(pushsearch)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(popfoot)];
    leftButton.tag=1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftButton;
    //self.navigationItem.rightBarButtonItem=rightButton;
    
        titlelabel.text=@"历史足迹";
}
-(void)popfoot{
 [self.navigationController popViewControllerAnimated:YES];
}
-(void)cteatUI{
    _dataarray=[[NSArray alloc] init];
    FMDBSingleTon *singon=[FMDBSingleTon shareSinglotn];
    _dataarray=[singon selectshop];
    self.automaticallyAdjustsScrollViewInsets=YES;
    _collectionview.contentInset=UIEdgeInsetsMake(0, 0, WIDTH, HEIGHT);
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    
     _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
   [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    //[_collectionview reloadData];
    [self.view addSubview:_collectionview];
     //[_collectionview reloadData];

}
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


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"qqq" forIndexPath:indexPath];
    CartModel *model=_dataarray[_dataarray.count-1- indexPath.row];
    [cell.imageview sd_setImageWithURL:[Uikility URLWithString:model.logopicUrl]placeholderImage:[UIImage imageNamed:@"uuu"]];
    cell.textlable.text=model.goodsName;
    CGFloat s=model.promotionPrice.floatValue;
    cell.pricelable.text=[NSString stringWithFormat:@"￥%.1f",s];
    CGFloat s1=model.goodsPrice.floatValue;
    if (s1) {
        cell.procelable.text=[NSString stringWithFormat:@"￥%.1f",s1];
    }
    
    



    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SpViewController *sp=[[SpViewController alloc]init];
    CartModel *model=[_dataarray objectAtIndex:_dataarray.count-1- indexPath.row];
    NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
    ////////////////////////NSLog(@"%@",sreid);
    sp.goodsId=sreid;
    sp.flag=1;
    sp.hidesBottomBarWhenPushed=YES;
    
 
    [self.navigationController pushViewController:sp animated:YES];
    
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
