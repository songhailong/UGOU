//
//  ActivityGoodViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/4/7.
//
//

#import "ActivityGoodViewController.h"
#import "MBProgressHUD.h"
#import "BassAPI.h"
#import "WMPlayer.h"
#import "MainCollectionViewCell.h"
#import "MJRefresh.h"
#import "CartModel.h"
#import "SpViewController.h"
#import "FMDBSingleTon.h"
#import "ReusableView.h"
#import "ScreeningView.h"
#import "XLPlainFlowLayout.h"
#import "UGHeader.h"
@interface ActivityGoodViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UGCustomnNavViewDelegate>{
    UICollectionView *_collectionView;
    NSMutableArray * _dataArr;
    NSUserDefaults *def;
    NSInteger hang;
    NSInteger screenhang;
    MBProgressHUD *HUB;
    UIScrollView *_scrollView;
    
    NSInteger _buttoninter;
    
    UIView* view;
    NSMutableArray * _screenArray;
    
    
    UIView *headView;
    UIView *_screenView;
    ScreeningView *secondscreningviwe;
    BOOL isSelect;
    NSMutableDictionary *_screenDic;
    
    UIImageView *   imageview;
    
    NSUInteger priceid;
    //导航栏
    UGCustomNavView *custemView;
}
@property(nonatomic,strong)WMPlayer *wmplayer;
@end

@implementation ActivityGoodViewController

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
    NSString *urlSTR=[BassAPI requestUrlWithPorType:PortTypeActivityGoods];
    NSMutableDictionary *muDic=[Uikility creatSinGoMutableDictionary];
    [muDic setObject:_brandID forKey:@"brandId"];
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
        //NSNumber *nummin=[NSNumber numberWithInteger:(hang-1)*20+1];
        //NSNumber *nummax=[NSNumber numberWithInteger:hang*20];
        //[muDic setObject:nummin forKey:@"min"];
        //NSLog(@"kaishi %@",min);
        [muDic setObject:@20 forKey:@"max"];
    }
    
    
  
    
    NSDictionary *postDic=[Uikility initWithdatajson:muDic];
    
    [AFManger postWithURLString:urlSTR parameters:postDic success:^(id responseObject) {
        id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL issucess=[[objec objectForKey:@"success"] boolValue];
        [HUB hide:YES];
         [_collectionView.footer endRefreshing];
        if (issucess) {
           // NSLog(@"hghggh%@",objec);
            //[_dataArr removeAllObjects];
            NSArray *data=[objec objectForKey:@"data"];
            for (NSDictionary *gooddic in data) {
                [_dataArr addObject:[CartModel initwithdic:gooddic]];
            }
            
           // NSLog(@"个数gvgvgvgvg%zd------%zd",_dataArr.count,data.count);
           
            
            
            if (_buttoninter==0) {
                if (isSelect==NO) {
                    [self pricelowToHeight];
                }else{
                
                    [self priceHeightToLow];
                }
                
                
                
            }else if (_buttoninter==1){
                
                [self salesHigetolow];
                
            }

            

            [_collectionView reloadData];
        }else{
        
            //[Uikility alert:[objec objectForKey:@"msg"]];
        
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
    custemView.title=@"活动商品";
    [custemView setLeftImage:[UIImage imageNamed:@"返回p"]];
    [self.view addSubview:custemView];
    

    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40*KIphoneWH)];
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40*KIphoneWH)];
    _scrollView.delegate=self;
    [headView addSubview:_scrollView];
    
    view=[[UIView alloc]init];
    view.frame=CGRectMake(15*KIphoneWH, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);
    view.backgroundColor=[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1];
    
    [headView addSubview:view];
    
    
    
    
    NSArray *titlearr=@[@"价格↑",@"销量优先",@"筛选"];
    _buttoninter=0;
    for (int i=0; i<3; i++) {
        if (i==0) {
            
        }
        
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(i*WIDTH/3, 0, WIDTH/3, 40*KIphoneWH)];
        [button setTitle:titlearr[i] forState:UIControlStateNormal];
        button.tag=1000+i;
        [button setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18*KIphoneWH];
        [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateNormal];
        }
        [_scrollView addSubview:button];
    }

    
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
    [_collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"activityView"];
    
    [_collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"goodcell"];

    _collectionView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       // NSLog(@"%zd",_buttoninter);
        if (_buttoninter==2) {
            [self screenReadDataDic];
            screenhang++;
        }else if (_buttoninter==0||_buttoninter==1){
        
        
            hang++;
            [self afReadData];
        }
        
       
    }];
    
    
    [self creatScreenView];
    
    
    
}
-(void)LeftItemAction{
    
    [self push];
}
-(void)segmentedControlChange:(UIButton *)btn{
    if (btn.tag!=1002) {
        
    
    view.frame=CGRectMake(15*KIphoneWH+(btn.tag-1000)*WIDTH/3, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);
    for (int i=0;i<3;i++) {
        UIButton *but=  (id) [_scrollView viewWithTag:1000+i ];
        if (btn!=but) {
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1] forState:UIControlStateNormal];
            btn.selected =NO;
        }
    }
    }
    
    
    
    switch (btn.tag) {
        case 1000:
            _buttoninter=0;
            
            if (isSelect==NO) {
                
            [btn setTitle:@"价格↓" forState:UIControlStateNormal];
                [self priceHeightToLow];
            [_collectionView reloadData];
                
           isSelect=YES;
            }else{
                
               
            [btn setTitle:@"价格↑" forState:UIControlStateNormal];
                priceid=1;
                [self pricelowToHeight];
                [_collectionView reloadData];
                
    
                isSelect=NO;
            }
            break;
        case 1001:
            _buttoninter=1;
            [self salesHigetolow];
            break;
        case 1002:
            //_buttoninter=2;
            _screenView.alpha=0.5;
            secondscreningviwe.frame=CGRectMake(40*KIphoneWH, 0, WIDTH-40*KIphoneWH, HEIGHT);
            break;
            
        default:
            break;
    }


}

-(void)pricelowToHeight{
    if (_dataArr.count) {
        
        
        //_priceview.alpha=0;
        for (int i=0; i<_dataArr.count-1; i++) {
            for (int j=0; j<_dataArr.count-1-i; j++) {
                //CartModel*model=[[CartModel alloc] init];
                CartModel *fistmodel=_dataArr[j];
                CartModel *secodmodel=_dataArr[j+1];
                if (fistmodel.promotionPrice.intValue<secodmodel.promotionPrice.intValue) {
                    _dataArr[j]=secodmodel;
                    _dataArr[j+1]=fistmodel;
                }
                
            }
        }
    }

}

-(void)priceHeightToLow{

    if (_dataArr.count) {
        
        for (int i=0; i<_dataArr.count-1; i++) {
            for (int j=0; j<_dataArr.count-1-i; j++) {
                
                CartModel *fistmodel=_dataArr[j];
                CartModel *secodmodel=_dataArr[j+1];
                if (fistmodel.promotionPrice.intValue>secodmodel.promotionPrice.intValue) {
                    _dataArr[j]=secodmodel;
                    _dataArr[j+1]=fistmodel;
                }
            }
        }
    }
}

-(void)creatScreenView{
    _screenView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _screenView.backgroundColor=[UIColor blackColor];
    _screenView.alpha=0;
    UITapGestureRecognizer *tapges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearScreen)];
    [_screenView addGestureRecognizer:tapges];
    secondscreningviwe=[[ScreeningView alloc] initWithFrame:CGRectMake(40*KIphoneWH+WIDTH, 0, WIDTH-40*KIphoneWH, HEIGHT)];
    secondscreningviwe.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_screenView];
    [self.view addSubview:secondscreningviwe];
    
    
    
    void (^myblock)(NSMutableDictionary *dic)=^(NSMutableDictionary *dic){
        secondscreningviwe.frame=CGRectMake(WIDTH, 0, WIDTH-40*KIphoneWH, HEIGHT);
        _screenView.alpha=0;
        screenhang=1;
        _screenDic=[[NSMutableDictionary alloc] init];
        _screenDic=dic;
        _buttoninter=2;
        [self Screeningselected];
        [self screenReadDataDic];
        
    };
    secondscreningviwe.secreeblock=myblock;


}
-(void)Screeningselected{
    
    view.frame=CGRectMake(15*KIphoneWH+2*WIDTH/3, 40*KIphoneWH, WIDTH/3-30*KIphoneWH, 1*KIphoneWH);
    for (int i=0;i<3;i++) {
        UIButton *but=  (id) [_scrollView viewWithTag:1000+i ];
        if (but.tag!=1002) {
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1] forState:UIControlStateNormal];
            but.selected =NO;
        }
    }



}
#pragma mark*********筛选请求
-(void)screenReadDataDic{
    [_screenDic setObject:_brandID forKey:@"brandId"];
    if (screenhang==1) {
        HUB=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUB.color=[UIColor blackColor];
        HUB.labelText=@"正在加载......";
        [_screenArray removeAllObjects];
        [_screenDic setObject:@0 forKey:@"min"];
        [_screenDic setObject:@10 forKey:@"max"];
    }else{
    
        [_screenDic setObject:@10 forKey:@"max"];
        NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(screenhang-1)+1];
        NSNumber * min = @([minstr integerValue]);
        [_screenDic setObject:min forKey:@"min"];

    
    }
    [HUB hide:YES];
    
    if (_screenDic!=nil) {
        
        NSString *urlstr=[BassAPI requestUrlWithPorType:portTypeSearchActivityGood];
        NSDictionary *jsondic=[Uikility initWithdatajson:_screenDic];
        
        [AFManger postWithURLString:urlstr parameters:jsondic success:^(id responseObject) {
            
            [HUB hide:YES];
            [_collectionView.footer endRefreshing];
            id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            BOOL issucess=[[objec objectForKey:@"success"]boolValue];
           
            
            if (issucess) {
                //NSLog(@"%@",objec);
                
                
                NSArray *data=[objec objectForKey:@"data"];
                for (NSDictionary *gooddic in data) {
                    NSDictionary *appgoodsDic=[gooddic objectForKey:@"appgoodsId"];
                    [_screenArray addObject:[CartModel initwithdic:appgoodsDic]];
                }
                
                [_collectionView reloadData];

            }else{
            
                [Uikility alert:[objec objectForKey:@"msg"]];
            }
            
            
            //[HUB hide:YES];
            //[_collectionView.footer endRefreshing];
         
            
            
        } failure:^(NSError *error) {
            
            [HUB hide:YES];
            [_collectionView.footer endRefreshing];
        }];
        
    }
    


}
#pragma mark********消失筛选页面
-(void)disappearScreen{
    secondscreningviwe.frame=CGRectMake(WIDTH, 0, WIDTH-40*KIphoneWH, HEIGHT);
    _screenView.alpha=0;
    
    
    
    
    
    
    
    
    
    
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_buttoninter==2) {
        return _screenArray.count;
    }else{
        if (_dataArr.count) {
            return _dataArr.count;
        }

    }
    
    
    
    return 0;

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

  return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);

}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString * headerID = @"activityView";
    //collectionView通过复用标志到相应的复用池去找空闲的ReusableView，有就直接用，没有就创建
    ReusableView *regestview = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
    regestview.backgroundColor=[UIColor whiteColor];
    
    [regestview.view addSubview:headView];
    
    return regestview;


}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(WIDTH, 42*KIphoneWH);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);

}
-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"goodcell" forIndexPath:indexPath];
    CartModel *model=nil;
    switch (_buttoninter) {
        case 0:
            if (_dataArr.count) {
           model=[_dataArr objectAtIndex:indexPath.row];

            }
            break;
        case 1:
            if (_dataArr.count) {
             model=[_dataArr objectAtIndex:indexPath.row];
            }
            break;
        case 2:
            
            if (_screenArray.count) {
                 model=[_screenArray objectAtIndex:indexPath.row];
            }
            
            
            break;
            
        default:
            break;
    }
    
    
   
        
        
        
        [cell.imageview sd_setImageWithURL:[Uikility URLWithString:model.logopicUrl] placeholderImage:[UIImage imageNamed:@"uuu"]];
        cell.textlable.text=model.goodsName;
        
        CGFloat s=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
        cell.pricelable.text=[NSString stringWithFormat:@"￥%.1f",s];
        NSNumber *salecount=model.saleCount;
        if (salecount==nil) {
            //cell.salesLable.text=@"0人付款";
        }else{
            cell.salesLable.text=[NSString stringWithFormat:@"%@人付款",salecount];
        }

        CGFloat s1=model.goodsPrice.floatValue;
        if (s1>s) {
            cell.procelable.text=[NSString stringWithFormat:@"￥%.1f",s1];
            cell.procelable.alpha=1;
        }else{
            cell.procelable.alpha=0;
        }

    
   
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SpViewController *spvc=[[SpViewController alloc] init];
    
    
    CartModel *model=nil;
    switch (_buttoninter) {
        case 0:
            if (_dataArr.count) {
                model=[_dataArr objectAtIndex:indexPath.row];
                
            }
            break;
        case 1:
            if (_dataArr.count) {
                model=[_dataArr objectAtIndex:indexPath.row];
            }
            break;
        case 2:
            
            if (_screenArray.count) {
                model=[_screenArray objectAtIndex:indexPath.row];
            }
            
            
            break;
            
        default:
            break;
    }

    
    
    

    
        NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
        spvc.goodsId=sreid;
        spvc.flag=1;
        spvc.hidesBottomBarWhenPushed=YES;
        FMDBSingleTon *singleTon=[FMDBSingleTon shareSinglotn];
        [singleTon addshop:model];
        [self.navigationController pushViewController:spvc animated:YES];
        
        
    
    


}

#pragma mark********按销量从高到底排序
-(void)salesHigetolow{
    
    if (_dataArr.count) {
        
        
        //_priceview.alpha=0;
        for (int i=0; i<_dataArr.count-1; i++) {
            for (int j=0; j<_dataArr.count-1-i; j++) {
                //CartModel*model=[[CartModel alloc] init];
                CartModel *fistmodel=_dataArr[j];
                CartModel *secodmodel=_dataArr[j+1];
                if (fistmodel.saleCount.intValue<secodmodel.saleCount.intValue) {
                    _dataArr[j]=secodmodel;
                    _dataArr[j+1]=fistmodel;
                    
                }
                
            }
        }
        
        [_collectionView reloadData];
    }
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //移动的坐标点
    CGPoint point=[scrollView.panGestureRecognizer translationInView:self.view];
    
  CGPoint point1=scrollView.contentOffset;
    if (point1.y) {
        //NSLog(@"x:%f,y%f------%f,%f",point1.x,point1.y,point.x,point.y);
    }

   
        
    
    
    if (point.y>0) {
        //NSLog(@"下拉");
        if (point1.y<0) {
            
        
        
        }else{
            custemView.frame=CGRectMake(0, 0, WIDTH, NavHeight);
            _collectionView.frame=CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight);
        }
    }else if(point.y<-70){
      
        custemView.frame=CGRectMake(0, -NavHeight, WIDTH, NavHeight);
        if (iPhoneX) {
             _collectionView.frame=CGRectMake(0, 44, WIDTH, HEIGHT-44);
        }else{
            
             _collectionView.frame=CGRectMake(0, 20*KIphoneWH, WIDTH, HEIGHT-20*KIphoneWH);
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
