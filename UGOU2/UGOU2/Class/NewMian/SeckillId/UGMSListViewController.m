//
//  UGMSListViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/15.
//

#import "UGMSListViewController.h"
#import "MBProgressHUD.h"
#import "BassAPI.h"
#import "MainCollectionViewCell.h"
#import "MJRefresh.h"
#import "UGMSGoodModel.h"
#import "SpViewController.h"
#import "XLPlainFlowLayout.h"
#import "UGHeader.h"
#import "MSdetailsViewController.h"
#import "UGBiddingViewController.h"
@interface UGMSListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UGCustomnNavViewDelegate>{
    UICollectionView *_collectionView;
    NSMutableArray * _dataArr;
    NSUserDefaults *def;
    NSInteger hang;
    NSInteger screenhang;
    MBProgressHUD *HUB;
    //UIScrollView *_scrollView;
    
    NSInteger _buttoninter;
    
    UIView* view;
    NSMutableArray * _screenArray;
    
    
    UIView *headView;
    UIView *_screenView;
    BOOL isSelect;
    NSMutableDictionary *_screenDic;
    
    UIImageView *   imageview;
    
    NSUInteger priceid;
    //导航栏
    UGCustomNavView *custemView;
}

@end

@implementation UGMSListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hang=1;
    screenhang=1;
    _buttoninter=0;
    priceid=1;
    _dataArr=[[NSMutableArray alloc] init];
    _screenArray=[[NSMutableArray alloc] init];
    //[self creatUI];
    [self afReadData];
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBar.translucent=NO;
    
}
-(void)push{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)afReadData{
    def=[NSUserDefaults standardUserDefaults];
    NSString *urlSTR=nil;
    if (_flag==1) {
         urlSTR=[BassAPI requestUrlWithPorType:portTypeGetSecondsKillGoodList];
    }else{
      urlSTR=[BassAPI requestUrlWithPorType:portTypeGiveGetAppAuction];
    }
    NSMutableDictionary *muDic=[Uikility creatSinGoMutableDictionary];
   
    [muDic setObject:[def objectForKey:@"placename"] forKey:@"area"];
    
    if (hang==1) {
        HUB=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUB.color=[UIColor blackColor];
        HUB.labelText=@"正在加载......";
        [muDic setObject:@0 forKey:@"min"];
        [muDic setObject:@20 forKey:@"max"];
        
    }else{
        
        
        NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",20*(hang-1)+1];
        NSNumber * min = @([minstr integerValue]);
        [muDic setObject:min forKey:@"min"];
        [muDic setObject:@20 forKey:@"max"];
    }
    
    
    NSDictionary *postDic=[Uikility initWithdatajson:muDic];
    
    [AFManger postWithURLString:urlSTR parameters:postDic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        BOOL issucess=[[objec objectForKey:@"success"] boolValue];
        [HUB hide:YES];
        [_collectionView.footer endRefreshing];
       if (issucess) {
           
            NSArray *data=[objec objectForKey:@"data"];
            for (NSDictionary *gooddic in data) {
            UGMSGoodModel *Model=[UGMSGoodModel initwithdic:gooddic];
                NSDictionary *goodnamedic=[gooddic objectForKey:@"appgoodsId"];
                [Model setValuesForKeysWithDictionary:goodnamedic];
                [_dataArr addObject:Model];
            }
           [_collectionView reloadData];
       }else{
        //[Uikility alert:@"当前网速不佳"];
       }
    } failure:^(NSError *error) {
        [HUB hide:YES];
        [_collectionView.footer endRefreshing];
        [Uikility alert:@"当前网速不佳"];
    }];
    
}
-(void)creatUI{
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBar.translucent=NO;
    
    custemView=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemView.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    custemView.Delegate=self;
    custemView.title=@"限时秒杀";
    if (_flag==2) {
        custemView.title=@"限时拍卖";
    }
    [custemView setLeftImage:[UIImage imageNamed:@"返回p"]];
    //[custemView.leftButton setImage:[UIImage imageNamed:@"返回p"] forState:UIControlStateNormal];
    [self.view addSubview:custemView];
    
    
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40*KIphoneWH)];
    
  
    
    view=[[UIView alloc]init];
    view.frame=CGRectMake(15*KIphoneWH, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);
    view.backgroundColor=[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1];
    
    [headView addSubview:view];
#pragma mark********创建
    
    _collectionView.contentInset=UIEdgeInsetsMake(0, NavHeight, WIDTH, HEIGHT-NavHeight);
    XLPlainFlowLayout *flowLayout= [[XLPlainFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.minimumInteritemSpacing=5*KIphoneWH;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.view addSubview:_collectionView];
   
    
    [_collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"goodcell"];
    
//    _collectionView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            hang++;
//            [self afReadData];
//        }];
}
-(void)LeftItemAction{
    
    [self push];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
   
        if (_dataArr.count) {
            return _dataArr.count;
       }
    
    return 0;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_flag==1) {
        MSdetailsViewController *spvc=[[MSdetailsViewController alloc] init];
        UGMSGoodModel *model=nil;
    if (_dataArr.count) {
            model=[_dataArr objectAtIndex:indexPath.row];
            
            
            // NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
            spvc.seckillId=model.id;
         
            spvc.hidesBottomBarWhenPushed=YES;
            //    FMDBSingleTon *singleTon=[FMDBSingleTon shareSinglotn];
            //    [singleTon addshop:model];
            [self.navigationController pushViewController:spvc animated:YES];}
        }else{
            UGBiddingViewController *spvc=[[UGBiddingViewController alloc] init];
            UGMSGoodModel *model=nil;
            
            
            
            
            if (_dataArr.count) {
                model=[_dataArr objectAtIndex:indexPath.row];
                
                
                // NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
                spvc.seckillIds=model.id;
                spvc.time=model.deadline.longValue;
                spvc.hidesBottomBarWhenPushed=YES;
                //    FMDBSingleTon *singleTon=[FMDBSingleTon shareSinglotn];
                //    [singleTon addshop:model];
                [self.navigationController pushViewController:spvc animated:YES];}
        }
   
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
    
}
-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"goodcell" forIndexPath:indexPath];
   UGMSGoodModel *model=nil;
 if (_dataArr.count) {
     model=[_dataArr objectAtIndex:indexPath.row];
    [cell.imageview sd_setImageWithURL:[Uikility URLWithString:model.logopicSl] placeholderImage:[UIImage imageNamed:@"uuu"]];
    cell.textlable.text=model.goodsName;
     NSNumber *maxSePrice=model.maxSePrice;
     if (maxSePrice==nil) {
          cell.pricelable.text=[NSString stringWithFormat:@"￥%.1f",model.seprice.floatValue];
     }else{
          cell.pricelable.text=[NSString stringWithFormat:@"￥%.1f",maxSePrice.floatValue];
     }
   
    NSNumber *salecount=model.total;
   
     if (_flag==1) {
         if (salecount==nil) {
             //cell.salesLable.text=@"0人付款";
         }else{
             cell.salesLable.text=[NSString stringWithFormat:@"仅剩%@件",salecount];
         }
     }else{
         long nowtime=[Uikility readnowtime];
          cell.salesLable.textAlignment=NSTextAlignmentCenter;
         if (model.deadline.longValue>nowtime) {
             cell.salesLable.text=@"正在竞拍";
            
         }else{
              cell.salesLable.text=@"竞拍结束";
         }
         
     }
 }
    
    return cell;
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
