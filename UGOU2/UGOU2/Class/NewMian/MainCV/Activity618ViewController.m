//
//  Activity618ViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/3.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "Activity618ViewController.h"
#import "Uikility.h"
#import "CartModel.h"
#import "MainCollectionViewCell.h"
#import "ReusableView.h"
#import "MJRefresh.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "ActivityModel.h"
#import "SpViewController.h"
#import "FMDBSingleTon.h"
@interface Activity618ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    //导航栏的lable
    UIImageView *_navagetlable;
    //导航栏显示主题
    UILabel *_textlable;
    
    NSMutableArray *_dataarray;
    UICollectionView *_collectionview;
    
    UIView * _headview;
    NSInteger _page;
    NSInteger _taghang;
    NSInteger _sortingprice;
    NSInteger _salecount;
    NSUserDefaults *de;
    ActivityModel *_activitymodel;
    
    UIImageView *_headiamgeview1;
    UIImageView *_headimageview2;
    
}

@end

@implementation Activity618ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=1;
    _taghang=1;
    _taghang=1;
    _sortingprice=1;
    _salecount=2;
    _activitymodel=[[ActivityModel alloc] init];
    [self creatheadview];
    _dataarray=[[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _collectionview.contentInset=UIEdgeInsetsMake(0,64*KIphoneWH, WIDTH, HEIGHT-64*KIphoneWH);
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64*KIphoneWH, WIDTH, HEIGHT-64*KIphoneWH) collectionViewLayout:flowlayout];
    [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"activity"];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:_collectionview];
    
    [_collectionview registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headers"];
    
    _collectionview.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        
        [_collectionview.footer endRefreshing];
    }];

    
    [self.view addSubview:_collectionview];
    [self readjsondata];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;
    de=[NSUserDefaults standardUserDefaults];
   
    _navagetlable=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64*KIphoneWH)];
    //_navagetlable.backgroundColor=[UIColor blackColor];
    self.view.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    
    _navagetlable.userInteractionEnabled=YES;
    _textlable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-40*KIphoneWH, 20*KIphoneWH, 80*KIphoneWH, 40*KIphoneWH)];
    
    _textlable.font=[UIFont systemFontOfSize:20*KIphoneWH];
    _textlable.textColor=[UIColor whiteColor];
    
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 60*KIphoneWH, 64*KIphoneWH )];
    UIImage *img=[UIImage imageNamed:@"返回p"];
    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
    [leftButton addSubview:imgv];
    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
    
    [leftButton addTarget:self action:@selector(pushback) forControlEvents:UIControlEventTouchDown];
    
    leftButton.tag=1;

    UIButton *rightbut=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 0, 60*KIphoneWH, 64*KIphoneWH)];
    
    
    UIImage *img1=[UIImage imageNamed:@"share"];
    UIImageView *imgv1=[[UIImageView alloc]initWithImage:img1];
    [rightbut addSubview:imgv1];
    imgv1.frame=CGRectMake(20*KIphoneWH, 30*KIphoneWH, 20*KIphoneWH, 24*KIphoneWH);
    
    [rightbut addTarget:self action:@selector(pushshare) forControlEvents:UIControlEventTouchDown];
    
    rightbut.tag=2;
    [self.view addSubview:_navagetlable];
    [_navagetlable addSubview:rightbut];
    [_navagetlable addSubview:leftButton];
    [_navagetlable addSubview:_textlable];
    
    
}

-(void)readjsondata{
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeActivityRegular ];
    NSDictionary *dicc;
    
    if (_page==1) {
        dicc=@{@"min":@0,@"max":@10,@"model":@1,@"ios_version":VERSION};
    }else{
        NSString *nuberstr=[NSString  stringWithFormat:@"%zd",(_page-1)*10];
        NSNumber *nuber=@([nuberstr integerValue]);
        dicc=@{@"min":nuber,@"max":@10,@"model":@1,@"ios_version":VERSION};
    
    }
    
   
    NSDictionary *dic1=[Uikility initWithdatajson:dicc];
[AFManger postWithURLString:url parameters:dic1 success:^(id responseObject) {
    id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    
    BOOL sucess=[[object objectForKey:@"success"] boolValue];
    if (sucess) {
        NSDictionary *datadic=[object objectForKey:@"data"];
        
        NSDictionary *baranddic=[datadic objectForKey:@"appOnlineshopping"];
        
        _activitymodel.images=[baranddic objectForKey:@"images"];
        _activitymodel.brannerColor=[baranddic objectForKey:@"brannerColor"];
        _activitymodel.brannerFont=[baranddic objectForKey:@"brannerFont"];
        _activitymodel.reTime=[baranddic objectForKey:@"reTime"];
        [self  setcolorlable];
        NSArray *dataarr=[datadic objectForKey:@"appGoods"];
        for (NSDictionary *gooddic in dataarr) {
            [_dataarray addObject:[ActivityModel initWithModeldic:gooddic]];
        }
        
        
        if (_taghang==1) {
            
            if (_sortingprice==1) {
                
                [self sortingmodel];
                
            }else if (_sortingprice==2){
                [self topsorting];
                
            }
            
            
        }else if (_taghang==2){
            if (_salecount==1) {
                
                [self salecounttopsorting];
                
            }else if (_salecount==2){
                
                
                [self salecountbottomsorting];
                
            }
            
        }
        
        
    }else{
        
        
        [Uikility alert:@"请求失败"];
        
    }
    

  } failure:^(NSError *error) {
    
  }];
   
}
#pragma mark------价格从低到高排序
-(void)sortingmodel{
    
    if (_dataarray.count) {
        
        
        for (int i=0; i<_dataarray.count-1; i++) {
            for (int j=0; j<_dataarray.count-1-i; j++) {
                
                ActivityModel *fistmodel=_dataarray[j];
               ActivityModel *secodmodel=_dataarray[j+1];
                if (fistmodel.promotionPrice.intValue>secodmodel.promotionPrice.intValue) {
                    _dataarray[j]=secodmodel;
                    _dataarray[j+1]=fistmodel;
                }
                
            }
            
        }
                [_collectionview reloadData];
    }else{
        
        
    }



}

#pragma mark--------价格从高到低排序
-(void)topsorting{
   
    if (_dataarray.count) {
      
        for (int i=0; i<_dataarray.count-1; i++) {
            for (int j=0; j<_dataarray.count-1-i; j++) {
                ActivityModel *model1=_dataarray[j];
                ActivityModel*model2=_dataarray[j+1];
                if (model1.promotionPrice.integerValue<model2.promotionPrice.integerValue) {
                    _dataarray[j]=model2;
                    _dataarray[j+1]=model1;
                }
            }
        }
        
        
        [_collectionview reloadData];
    }else{
    
  }
    
  }

#pragma mark----------销量从高到底
-(void)salecounttopsorting{
    
    
    
    if (_dataarray.count) {
        
    
    
    for (int i=0; i<_dataarray.count-1; i++) {
        for (int j=0; j<_dataarray.count-1-i; j++) {
          
            ActivityModel *model1=_dataarray[j];
            ActivityModel *model2=_dataarray[j+1];
            if (model1.saleCount.integerValue >model2.saleCount.integerValue) {
                
                _dataarray[j]=model2;
                _dataarray[j+1]=model1;
                
                
            }
            
            
        }
    }
        
        [_collectionview reloadData];
    
    }else{
    
    
    }


}
#pragma mark-----------销量从低到高
-(void)salecountbottomsorting{
    
    
    
    if (_dataarray.count) {
        
        
        
        for (int i=0; i<_dataarray.count-1; i++) {
            for (int j=0; j<_dataarray.count-1-i; j++) {
                
                ActivityModel *model1=_dataarray[j];
                ActivityModel *model2=_dataarray[j+1];
                if (model1.saleCount.integerValue <model2.saleCount.integerValue) {
                    
                    _dataarray[j]=model2;
                    _dataarray[j+1]=model1;
                    
                    
                }
                
                
            }
        }
        
        [_collectionview reloadData];
        
    }else{
        
        
    }
    
    
}


#pragma mark------设置导航栏颜色
-(void)setcolorlable{
   
    _textlable.text=_activitymodel.brannerFont;
    
    
    
    NSMutableString *str=[[NSMutableString alloc] initWithString:_activitymodel.brannerColor];
    
    
    UIColor *bacolor=[Uikility colortoRGF:str];
    _navagetlable.backgroundColor=bacolor;
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = NO;

}
//页面返回
-(void)pushback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)pushshare{
   


}
#pragma mark-------创建头视图
-(void)creatheadview{
    _headview=[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, WIDTH+190*KIphoneWH)];
    _headview.backgroundColor=[UIColor whiteColor];
    
    
    _headiamgeview1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 150*KIphoneWH)];
    //_headiamgeview1.backgroundColor=[UIColor redColor];
    
    [_headview addSubview:_headiamgeview1];
    _headimageview2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 150*KIphoneWH,WIDTH, WIDTH)];
    
    [_headview addSubview:_headimageview2];
    
    
    NSArray *titlearr=@[@"价格↓",@"销量↑"];
    
    for (int i=0; i<2; i++) {
        if (i==0) {
            
        }
        
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(i*WIDTH/2, WIDTH+150*KIphoneWH, WIDTH/2, 40*KIphoneWH)];
        [button setTitle:titlearr[i] forState:UIControlStateNormal];
        button.tag=1000+i;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18*KIphoneWH];
        [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateSelected];
        // [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateNormal];
        }
        [_headview addSubview:button];
    }


}
#pragma mark------------价格 销量按钮
-(void)segmentedControlChange:(UIButton *)b{
    _taghang=b.tag-1000;
    
    
    for (int i=0;i<2;i++) {
        UIButton *but=  (id) [self.view viewWithTag:1000+i ];
        if (b!=but) {
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1] forState:UIControlStateNormal];
            b.selected =NO;
        }
    }

    switch (b.tag) {
        case 1000:
            if (_sortingprice==1) {
                _sortingprice=2;
                [b setTitle:@"价格↑" forState:UIControlStateNormal];
                [self topsorting];
                
            }else{
                _sortingprice=1;
                [b setTitle:@"价格↓" forState:UIControlStateNormal];
                [self sortingmodel];
                
            
            }
           
            
            
            break;
          case 1001:
            if (_salecount==1) {
                [b setTitle:@"销量↓" forState:UIControlStateNormal];
                _salecount=2;
                [self salecounttopsorting];
            }else{
                [b setTitle:@"销量↑" forState:UIControlStateNormal];
                _salecount=1;
                [self salecountbottomsorting];
            }
            
            
            break;
        default:
            break;
    }
    


}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataarray.count) {
        return _dataarray.count;
    }

    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{


    return 1;

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(WIDTH,WIDTH+190*KIphoneWH);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

   return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"activity" forIndexPath:indexPath];
    if (_dataarray.count) {
        ActivityModel *model=_dataarray[indexPath.row];
        cell.pricelable.text=[NSString stringWithFormat:@"%.1f",model.promotionPrice.floatValue];
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:model.logopicUrl]];
        cell.textlable.text=model.goodsName;
        NSInteger salecount=model.saleCount.integerValue;
        cell.salesLable.text=[NSString stringWithFormat:@"已%zd人付款",salecount];
    
    }

    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
    //collectionView通过复用标志到相应的复用池去找空闲的ReusableView，有就直接用，没有就创建
    ReusableView *regestview = [_collectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headers" forIndexPath:indexPath];
    
    NSArray *imagearr=[_activitymodel.images componentsSeparatedByString:@";"];
    if (imagearr.count) {
        [_headiamgeview1 sd_setImageWithURL:[NSURL URLWithString:imagearr[0]]];
        [_headimageview2 sd_setImageWithURL:[NSURL URLWithString:imagearr[1]]];
    }
   
    
    [regestview.view addSubview:_headview];


    return  regestview;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SpViewController *sp=[[SpViewController alloc]init];
    ActivityModel *model=[_dataarray objectAtIndex:indexPath.row];
    NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
   
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
