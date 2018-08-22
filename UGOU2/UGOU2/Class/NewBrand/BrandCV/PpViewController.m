//
//  PpViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/4.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*xujing2015.11.4.1.24 tableview
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "PpViewController.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "TableViewCell.h"
#import "LPLabel.h"
#import "HYSegmentedControl.h"
#import "SpViewController.h"
#import "Uikility.h"
#import "MainCollectionViewCell.h"
#import "CartModel.h"
#import "BrandReusableView.h"
#import "MJRefresh.h"
#import "FMDBSingleTon.h"
#import "ReusableView.h"
#import "BassAPI.h"
#import "ScreeningView.h"
#import "SmSeerchViewController.h"
#import "MBProgressHUD.h"
#import "UGHeader.h"
#import "SDWebImageManager.h"
@interface PpViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MBProgressHUDDelegate,UGCustomnNavViewDelegate>{
    UITextField *sfield;
    UIView *headview;
    UILabel *label;
    UIView *rightview;
    UIScrollView *headscroll;
    UIScrollView *titlescroll;
    UIScrollView *scroll;
    NSURL *im;
    NSDictionary *dics;
    NSString *url;
    NSMutableArray *muarr;
    LPLabel *lplabel;
    //HYSegmentedControl *_segment;
    UITableView *table1;
    UIView *view;
    int is;
    UICollectionView *_collectionview;
    NSMutableArray *_dataarray;
    NSInteger _hang;
    UIView *_xuanview;
    UIView *_priceview;
    UIImageView *_imgv;
    NSInteger _buttoninter;
    NSInteger _priceid;
    NSInteger _SaleCount;
    NSMutableArray *_pricedata;
    NSMutableArray *_salesdata;
    UIImageView *titleimageview;
    UIPageControl *page;
    UIScrollView *headescroll;
    NSString *brandstr;
    UILabel *labels;
    NSUserDefaults *de;
    UIScrollView *_selcetscrollview;
    
    UIView *_screenView;
    ScreeningView *_secondscreningviwe;
    
    NSMutableDictionary *_screendic;
    NSMutableDictionary *_mudic;
    MBProgressHUD *HUB;
}
@end

@implementation PpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    de=[NSUserDefaults standardUserDefaults];
     _mudic=[[NSMutableDictionary alloc] init];
    _screendic=[[NSMutableDictionary alloc] init];
    [self creatnagation];
  
    
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    
    //downloder.shouldDecompressImages = NO;
    

    _hang=1;
    _indexint=0;
    _dataarray=[NSMutableArray array];
    _pricedata=[[NSMutableArray alloc] init];
    _salesdata=[[NSMutableArray alloc] init];
      [self addheadview];
    [self addtableview];
    [self  screeningUI];
    #pragma mark
    [self json1:0];
   
    
    // Do any additional setup after loading the view.
}
-(void)creatnagation{
//    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-140*KIphoneWH, 20*KIphoneWH, 280*KIphoneWH, 40*KIphoneWH)];
//     UIImageView *   imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64*KIphoneWH)];
//    UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
//    imageview.image=image;
////    //_imageview.backgroundColor=[UIColor greenColor];
////
//    imageview.userInteractionEnabled=YES;
//    label1.textColor=[UIColor whiteColor];
//   // label1.text=@"我的卡券";
//    if (_flag==1) {
//
//        label1.text=[self.dic objectForKey:@"brandName"];
//    }else{
//        label1.text=self.model.shopName;
//    }
//    label1.font=[UIFont systemFontOfSize:20*KIphoneWH];
//    label1.textAlignment=NSTextAlignmentCenter;
//    [imageview addSubview:label1];
//
//    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 60*KIphoneWH, 64*KIphoneWH )];
//    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
//    UIImage *img=[UIImage imageNamed:@"返回p"];
//    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
//    [leftButton addSubview:imgv];
//    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
//
//    [leftButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchDown];
//
//    leftButton.tag=1;
//
//    UIButton *rightbt=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-80*KIphoneWH, 0, 80*KIphoneWH, 64*KIphoneWH)];
//    UIImageView *rightimage=[[UIImageView alloc] initWithFrame:CGRectMake(39*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH, 20*KIphoneWH)];
//    UIImage *rimage=[UIImage imageNamed:@"search"];
//    rightimage.image=rimage;
//
//    [rightbt addSubview:rightimage];
//    [rightbt addTarget:self action:@selector(rightbuttonclick) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:imageview];
//    [imageview addSubview:rightbt];
//    [imageview  addSubview:leftButton];
    
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [custemNav setrightImage:[UIImage imageNamed:@"search"]];
    [custemNav setLeftImage:[UIImage imageNamed:@"返回p"]];
       if (_flag==1) {
  
          //label1.text=[self.dic objectForKey:@"brandName"];
           custemNav.title=[self.dic objectForKey:@"brandName"];
     }else{
         //label1.text=self.model.shopName;
         custemNav.title=self.model.shopName;
    }
    custemNav.Delegate=self;
    [self.view addSubview:custemNav];


}
-(void)LeftItemAction{
    
    [self push];
}
-(void)rightItemAction{
    
    [self rightbuttonclick];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;


}
-(void)rightbuttonclick{
//    if (_flag==1) {
//        
//    }else{
    
        SmSeerchViewController *smseechvc=[[SmSeerchViewController alloc] init];
      smseechvc.flag=_flag;
      smseechvc.storeId=_appstoreId;
        [self.navigationController pushViewController:smseechvc animated:YES];
    
    //}


}
-(void)push{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = YES;

}
-(void)screeningUI{
    _screenView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _screenView.backgroundColor=[UIColor blackColor];
    _screenView.alpha=0;
    UITapGestureRecognizer *tapges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappear)];
    [_screenView addGestureRecognizer:tapges];
    _secondscreningviwe=[[ScreeningView alloc] initWithFrame:CGRectMake(40*KIphoneWH+WIDTH, 0, WIDTH-40*KIphoneWH, HEIGHT)];
    _secondscreningviwe.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_screenView];
    [self.view addSubview:_secondscreningviwe];
    
  
    
    void (^myblock)(NSMutableDictionary *dic)=^(NSMutableDictionary *dic){
        _secondscreningviwe.frame=CGRectMake(WIDTH, 0, WIDTH-40*KIphoneWH,  HEIGHT);
        _screenView.alpha=0;
        [dic setObject:_appbrandId forKey:@"appBranId"];
        _hang=1;
        [_dataarray removeAllObjects];
        
        _screendic=[[NSMutableDictionary alloc] init];
        _screendic=dic;
        
        [self screenjson];
    
    };
    _secondscreningviwe.secreeblock=myblock;
    
}
-(void)screenjson{
    
    if (_hang==1) {
        HUB=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUB.color=[UIColor blackColor];
        HUB.labelText=@"正在加载......";
        [_screendic setObject:@0 forKey:@"min"];
        [_screendic setObject:@10 forKey:@"max"];
    }else{
        
        [_screendic setObject:@10 forKey:@"max"];
        NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
        NSNumber * min = @([minstr integerValue]);
        [_screendic setObject:min forKey:@"min"];
    };
    
    
    
    
    
    NSString *url1=[BassAPI requestUrlWithPorType:PortTypeSearchGoods];
    if(_screendic!=nil){
    NSDictionary *jsondic=[Uikility initWithdatajson:_screendic];
       
    [AFManger postWithURLString:url1 parameters:jsondic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            [HUB hide:YES];
        
        Boolean suceess=[[object objectForKey:@"success"]boolValue];
        
        if (suceess) {
            NSArray *arr=[object objectForKey:@"data"];
            for (NSDictionary *dix in arr) {
                [_dataarray addObject:[CartModel initwithdic:dix]];
            }
            [HUB hide:YES];
            [_collectionview reloadData];
          
        }else{
           [_collectionview.footer endRefreshing];
         [Uikility alert:@"加载失败"];
        }
        [_collectionview.footer endRefreshing];

        
    } failure:^(NSError *error) {
        [_collectionview.footer endRefreshing];
         [HUB hide:YES];
    }];
    
    }

}
-(void)showMBProgressHUB{
    




}
-(void)disappear{
    _secondscreningviwe.frame=CGRectMake(WIDTH, 0, WIDTH-40*KIphoneWH, HEIGHT);
    _screenView.alpha=0;
    
    
    NSMutableDictionary *jsondic=[[NSMutableDictionary alloc] init];
        if ([de objectForKey:@"userId"]) {
        [jsondic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [jsondic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        }
    
    
    [jsondic setObject:@1 forKey:@"model"];
    [jsondic setObject:VERSION forKey:@"ios_version"];
    [jsondic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    [jsondic setObject:_appbrandId forKey:@"appBranId"];
    _hang=1;
    [_dataarray removeAllObjects];
    
    _screendic=[[NSMutableDictionary alloc] init];
    _screendic=jsondic;
    
    
    [self screenjson];
}
#pragma mark---------确定按钮后
-(void)surebuttonclick:(UIButton *)bt{
   
    _secondscreningviwe.frame=CGRectMake(WIDTH, 0, WIDTH-40*KIphoneWH, HEIGHT);
    _screenView.alpha=0;


}
#pragma mark-------重置按钮
-(void)chongzhi:(UIButton *)bt{
    



}
#pragma mark 头视图
-(void)addheadview{
    headview=[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, 330*KIphoneWH)];
    headview.backgroundColor=[UIColor whiteColor];
   
        
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 5*KIphoneWH,WIDTH, 80*KIphoneWH)];
    
    [headview addSubview:v2];
    if (_model.logopicUrl) {
        
        im=[Uikility URLWithString:_model.logopicUrl];
    }else{
    NSString *imgestr    =[_dic objectForKey:@"logopic"];
        im=[Uikility URLWithString:imgestr];
    }
  
    UIImageView *imgvs=[[UIImageView alloc]initWithFrame:CGRectMake(2*KIphoneWH, 2*KIphoneWH, 70*KIphoneWH, 70*KIphoneWH)];
    [v2 addSubview:imgvs];
    [imgvs sd_setImageWithURL:im placeholderImage:[UIImage imageNamed:@"uuu"]];
    imgvs.userInteractionEnabled=YES;

    UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(80*KIphoneWH, 2*KIphoneWH, WIDTH-80*KIphoneWH, 20*KIphoneWH)];
    if (_flag==1) {
        leftlabel.text=[_dic objectForKey:@"brandName"];
    }else{
       leftlabel.text=_model.shopName;
    }
    [v2 addSubview:leftlabel];
    if (_flag==1) {
        UILabel *dlabel=[[UILabel alloc]initWithFrame:CGRectMake(75*KIphoneWH, 20*KIphoneWH, WIDTH-110*KIphoneWH, 60*KIphoneWH)];
        dlabel.numberOfLines=0;
        dlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
        dlabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
        dlabel.text=[_dic objectForKey:@"detail"];
        [v2 addSubview:dlabel];
        
           titleimageview=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-35*KIphoneWH,40*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
        
        if ([[_dic objectForKey:@"flag"]integerValue]==1) {
            titleimageview.image=[UIImage imageNamed:@"34-33(1)"];
        }else{
            
            
            titleimageview.userInteractionEnabled=YES;
            UITapGestureRecognizer *imgtap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush)];
            titleimageview.image=[UIImage imageNamed:@"收藏"];
            [titleimageview addGestureRecognizer:imgtap1];
        }

        
            [v2 addSubview:titleimageview];
    }else{
    
     UILabel *dlabel=[[UILabel alloc]initWithFrame:CGRectMake(80*KIphoneWH, 20*KIphoneWH, WIDTH-80*KIphoneWH, 20*KIphoneWH)];
    dlabel.numberOfLines=0;
   dlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    dlabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
        NSString *addarr=_model.shopAddr;
    dlabel.text=[NSString stringWithFormat:@"地址 %@",addarr];
    [v2 addSubview:dlabel];
    UILabel  * rightlabel=[[UILabel alloc]initWithFrame:CGRectMake(80*KIphoneWH, 40*KIphoneWH,WIDTH-80*KIphoneWH, 20*KIphoneWH)];
        NSString *tele=_model.shopTele;
    rightlabel.text=[NSString stringWithFormat:@"电话 %@",tele];
    rightlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    rightlabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [v2 addSubview:rightlabel];
        UILabel  * rightlabel1=[[UILabel alloc]initWithFrame:CGRectMake(80*KIphoneWH, 60*KIphoneWH,WIDTH-80*KIphoneWH, 15*KIphoneWH)];
        
        if (_model.businessHours) {
            NSString *timestr=_model.businessHours;
           rightlabel1.text=[NSString stringWithFormat:@"营业时间 %@",timestr];
        }

        
        rightlabel1.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
        rightlabel1.font=[UIFont systemFontOfSize:15*KIphoneWH];
        [v2 addSubview:rightlabel1];
    }
    page=[[UIPageControl alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH, 150*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    [page addTarget:self action:@selector(sender:) forControlEvents:UIControlEventEditingChanged];
    
    [headview addSubview:page];
    if (_flag==1) {
        brandstr=[_dic objectForKey:@"showpic"];
    }else{
    brandstr=_model.showpic;
    }
    headscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 85*KIphoneWH, WIDTH-10*KIphoneWH , WIDTH/2)];
    headscroll.pagingEnabled = YES;//整页
    headscroll.scrollEnabled = YES;
    headscroll.delegate = self;
    [headview addSubview:headscroll];
    NSArray  * imarray= [brandstr componentsSeparatedByString:@";"];
    for (int i=0; i<imarray.count; i++) {
        page.numberOfPages=imarray.count;
        headscroll.contentSize = CGSizeMake(WIDTH*(imarray.count-1), 0);
        NSString *ims=[imarray objectAtIndex:i];
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview sd_setImageWithURL:[Uikility URLWithString:ims] placeholderImage:[UIImage imageNamed:@"uuu"]];
        
        imageview.frame=CGRectMake(WIDTH*i, 0, WIDTH, WIDTH/2);
        [headscroll addSubview:imageview];
        
    }
    
    
    
    
    
    UIView *v3=[[UIView alloc]initWithFrame:CGRectMake(0, 90*KIphoneWH+WIDTH/2, WIDTH, 42*KIphoneWH)];
    
    [headview addSubview:v3];
    _selcetscrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40*KIphoneWH)];
    _selcetscrollview.delegate=self;
    [v3 addSubview:_selcetscrollview];
    view=[[UIView alloc]init];
    view.frame=CGRectMake(15*KIphoneWH, 40*KIphoneWH, WIDTH/4-30*KIphoneWH, 1*KIphoneWH);
    view.backgroundColor=[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1];
    
    [v3 addSubview:view];
    NSArray *titlearr=@[@"新品",@"价格↑",@"销量↓",@"筛选"];
    _buttoninter=0;
    for (int i=0; i<4; i++) {
        if (i==0) {
            
        }
        
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(i*WIDTH/4, 0, WIDTH/4, 40*KIphoneWH)];
        [button setTitle:titlearr[i] forState:UIControlStateNormal];
        button.tag=100+i;
        [button setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18*KIphoneWH];
        [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateSelected];
       // [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [button setTitleColor:[UIColor colorWithRed:163.0/255.0 green:206.0/255.0 blue:117.0/255.0 alpha:1] forState:UIControlStateNormal];
        }
        [_selcetscrollview addSubview:button];
    }
    
  
}
#pragma 滑块按钮
-(void)segmentedControlChange:(UIButton *)b{

    
    view.frame=CGRectMake(15*KIphoneWH+(b.tag-100)*WIDTH/4, 40*KIphoneWH, WIDTH/4-30*KIphoneWH, 1*KIphoneWH);
    for (int i=0;i<3;i++) {
        UIButton *but=  (id) [self.view viewWithTag:100+i ];
        if (b!=but) {
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor colorWithRed:163/255.0 green:206/255.0 blue:117/255.0 alpha:1] forState:UIControlStateNormal];
            b.selected =NO;
        }
    }
    switch (b.tag) {
        case 100:
            _buttoninter=0;
            _hang=1;
            [_pricedata  removeAllObjects];
            [_dataarray removeAllObjects];
            [_salesdata removeAllObjects];
            [self showMBProgressHUB];
            [self json1:0];
            break;
            
        case 101:
            [_dataarray removeAllObjects];
            [_pricedata removeAllObjects];
            [_salesdata removeAllObjects];
            [self showMBProgressHUB];
            _buttoninter=1;
            _hang=1;
            [self json1:0];
            if(_priceid==1){
               
                _priceid=2;
                //_priceview.alpha=0;
                [b setTitle:@"价格↓" forState:UIControlStateNormal];
                if (_pricedata.count) {
                    
                    for (int i=0; i<_pricedata.count-1; i++) {
                        for (int j=0; j<_pricedata.count-1-i; j++) {
                            
                            CartModel *fistmodel=_pricedata[j];
                            CartModel *secodmodel=_pricedata[j+1];
                            if (fistmodel.promotionPrice.intValue>secodmodel.promotionPrice.intValue) {
                                _pricedata[j]=secodmodel;
                                _pricedata[j+1]=fistmodel;
                               
                            }
                            
                        }
                        
                    }
                   
                [_collectionview reloadData];
                }else{
                    
                    
                }
            }else{
               
               _priceid=1;
                [b setTitle:@"价格↑" forState:UIControlStateNormal];
                //[b setTitle:@"价格↓" forState:UIControlStateSelected];
                [self  toptoBottomlick];
            }

            
            break;
        case 102:
        
            [_dataarray removeAllObjects];
            [_pricedata removeAllObjects];
            [_salesdata removeAllObjects];
            [self showMBProgressHUB];
            _buttoninter=2;
            _hang=1;
            //[self json1:0];
            
            //[self salesHigetolow];
            
            if (_SaleCount==1) {
                _SaleCount=2;
                [b setTitle:@"销量↑" forState:UIControlStateNormal];
            }else{
            
                _SaleCount=1;
                [b setTitle:@"销量↓" forState:UIControlStateNormal];
            
            }
             [self json1:0];
           
            
            break;
        case 103:
            _buttoninter=3;
            
            
            _screenView.alpha=0.5;
            _secondscreningviwe.frame=CGRectMake(40*KIphoneWH, 0, WIDTH-40*KIphoneWH, HEIGHT);
            break;
        default:
            break;
    }


}
#pragma mark********按销量从高到底排序
-(void)salesHigetolow{

    if (_salesdata.count) {
        
        
        //_priceview.alpha=0;
        for (int i=0; i<_salesdata.count-1; i++) {
            for (int j=0; j<_salesdata.count-1-i; j++) {
                //CartModel*model=[[CartModel alloc] init];
                CartModel *fistmodel=_salesdata[j];
                CartModel *secodmodel=_salesdata[j+1];
                if (fistmodel.saleCount.intValue<secodmodel.saleCount.intValue) {
                    _salesdata[j]=secodmodel;
                    _salesdata[j+1]=fistmodel;
                
                }
                
            }
        }
        
        [_collectionview reloadData];
    }


}
#pragma mark*******销量从低到高排序
-(void)salesLowtoHigte{

    if (_salesdata.count) {
        
        
        //_priceview.alpha=0;
        for (int i=0; i<_salesdata.count-1; i++) {
            for (int j=0; j<_salesdata.count-1-i; j++) {
                //CartModel*model=[[CartModel alloc] init];
                CartModel *fistmodel=_salesdata[j];
                CartModel *secodmodel=_salesdata[j+1];
                if (fistmodel.saleCount.intValue>secodmodel.saleCount.intValue) {
                    _salesdata[j]=secodmodel;
                    _salesdata[j+1]=fistmodel;
                }
                
            }
        }
        [_collectionview reloadData];
    }




}
#pragma mark 绑定page 和 scroll
-(void)sender:(UIPageControl *)p{
    int index = (int)p.currentPage;
    [headscroll setContentOffset:CGPointMake(WIDTH*index, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = headscroll.contentOffset.x/WIDTH;
    page.currentPage = index;
}
-(void)SalesOrder{
    for (int i=0; i<_dataarray.count-1; i++) {
        for (int j=0; j<_dataarray.count-1-i; j++) {
            //CartModel*model=[[CartModel alloc] init];
            CartModel *fistmodel=_dataarray[j];
            CartModel *secodmodel=_dataarray[j+1];
            if (fistmodel.promotionPrice.intValue>secodmodel.promotionPrice.intValue) {
                _dataarray[j]=secodmodel;
                _dataarray[j+1]=fistmodel;
        }
            
        }
        [_collectionview reloadData];
    }


}
#pragma mark--价格从底到高
-(void)Bottomclick{
    //_priceid=1;
    //_priceview.alpha=0;
    if (_pricedata.count) {
        
    
    for (int i=0; i<_pricedata.count-1; i++) {
        for (int j=0; j<_pricedata.count-1-i; j++) {
           
            CartModel *fistmodel=_pricedata[j];
            CartModel *secodmodel=_pricedata[j+1];
            if (fistmodel.promotionPrice.intValue>secodmodel.promotionPrice.intValue) {
                _pricedata[j]=secodmodel;
                _pricedata[j+1]=fistmodel;
            }
            
        }
    
    }
        [_collectionview reloadData];
    }else{
    
    
    }
}
#pragma  mark--价格从高到底
-(void)toptoBottomlick{
    //_priceid=2;
    //_priceview.alpha=0;
    if (_pricedata.count) {
        
    
    _priceview.alpha=0;
    for (int i=0; i<_pricedata.count-1; i++) {
        for (int j=0; j<_pricedata.count-1-i; j++) {
            //CartModel*model=[[CartModel alloc] init];
            CartModel *fistmodel=_pricedata[j];
            CartModel *secodmodel=_pricedata[j+1];
            if (fistmodel.promotionPrice.intValue<secodmodel.promotionPrice.intValue) {
                _pricedata[j]=secodmodel;
                _pricedata[j+1]=fistmodel;
            }
            
        }
    }
        [_collectionview reloadData];
    }

}
#pragma mark--------收藏品牌
-(void)imvpush{
   // NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"userId"]) {
        NSDictionary *ds=nil;
        if ([de objectForKey:@"newUserId"]) {
            ds=@{@"userId":[de objectForKey:@"userId"]
                 };
        }else{
        ds=@{@"userId":[de objectForKey:@"userId"]
                           };
        }
        
        
        NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:ds options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
         
        NSDictionary *d1=@{
                           @"id":_appbrandId
                           
                           };
        NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary * dics4=[[NSMutableDictionary alloc] init];
        [dics4 setValue:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [dics4 setValue:jsond1 forKey:@"appbrandId"];
        [dics4 setValue:[de objectForKey:@"userId"] forKey:@"userId"];
        [dics4 setValue:jsond forKey:@"appuserId"];
        [dics4 setValue:@1 forKey:@"model"];
        
        if ([de objectForKey:@"newUserId"]) {
            [dics4 setValue:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        [dics4 setValue:VERSION forKey:@"ios_version"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dics4 options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *jsoncollection=@{@"param":json
                                };
        NSString *url3=[BassAPI requestUrlWithPorType:PortTypeSaveBrand];
    [AFManger postWithURLString:url3 parameters:jsoncollection success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            if (success) {
                
                titleimageview.image=[UIImage imageNamed:@"34-33(1)"];
                [Uikility alert:@"收藏成功！"];
            }else{
                [Uikility alert:[strs objectForKey:@"msg"]];
            }

            
        } failure:^(NSError *error) {
           
             [Uikility alert:@"数据接受失败！"];
        }];
    }else{
        [Uikility alert:@"请先登录"];
    }
}





#pragma mark tableview
-(void)addtableview{
 
    self.automaticallyAdjustsScrollViewInsets=YES;
    _collectionview.contentInset=UIEdgeInsetsMake(0,NavHeight, WIDTH, HEIGHT-NavHeight);
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) collectionViewLayout:flowlayout];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
     _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:_collectionview];
   [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"ppcell"];
      [_collectionview registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headers"];

    _collectionview.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         _hang++;
        if (_buttoninter==1||_buttoninter==0||_buttoninter==2) {
              [self json1:1];
        }else if (_buttoninter==3){
            [self screenjson];
        
        }
        //[_collectionview.footer endRefreshing];
    }];
 
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(WIDTH, 330*KIphoneWH);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString * headerID = @"headers";
    //collectionView通过复用标志到相应的复用池去找空闲的ReusableView，有就直接用，没有就创建
    ReusableView *regestview = [_collectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
    
   
    [regestview.view addSubview:headview];
    
    return regestview;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_buttoninter==0) {
        if (_dataarray.count) {
            return _dataarray.count;
        }
    }else if (_buttoninter==1){
    
        if (_pricedata.count) {
           return _pricedata.count;        }
   
    }else if (_buttoninter==3){
        if (_dataarray.count) {
            return _dataarray.count;
        }
       
    
    }else if (_buttoninter==2){
        if (_salesdata.count) {
            return _salesdata.count;
        }
    
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
    
   MainCollectionViewCell *cell=[collectionView  dequeueReusableCellWithReuseIdentifier:@"ppcell" forIndexPath:indexPath];
    CartModel *model=nil;
    
            switch (_buttoninter) {
            case 0:
                if (_dataarray.count) {
                    model=_dataarray[indexPath.row];
                }
                break;
            case 1:
                
                if (_pricedata.count) {
                model=_pricedata[indexPath.row];
            }

               
                break;
            case 2:
                    
                model=_salesdata[indexPath.row];
                break;
            case 3:
                model=_dataarray[indexPath.row];
                break;
            default:
                break;
        }

        
        NSURL *url1=[Uikility URLWithString:model.logopicUrl];
        
        [cell.imageview sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"uuu"]];
    cell.textlable.text=model.goodsName;
      CGFloat price=[Uikility priceToCompareVipprice:model.promotionPrice vipnumber:model.vipPrice];
   
    if (model.saleCount==nil) {
        cell.salesLable.text=@"0人付款";
    }else{
        NSNumber *sacunt=model.saleCount;
        cell.salesLable.text=[NSString stringWithFormat:@"%@人付款",sacunt];
    }

        cell.pricelable.text=[NSString stringWithFormat:@"%.1f",price];
        CGFloat pioprice=model.goodsPrice.floatValue;
        if (pioprice>price) {
            cell.procelable.text=[NSString stringWithFormat:@"￥%.1f",pioprice];
            cell.procelable.alpha=1;
        }else{
        cell.procelable.alpha=0;
        
        }
    
    //
    return cell;
    
}

#pragma mark 点击tableview
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SpViewController *sp=[[SpViewController alloc]init];
    CartModel *model=nil;
   
    switch (_buttoninter) {
         
        case 0:
            model=_dataarray[indexPath.row];
            break;
        case 1:
            model=_pricedata[indexPath.row];
            break;
        case 2:
            model=_salesdata[indexPath.row];
            
            break;
        case 3:
            model=_dataarray[indexPath.row];
            
            break;
        default:
            break;
    }
    NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
    
    sp.goodsId=sreid;
    sp.flag=_flag;
    sp.storeId=_appstoreId;
    sp.hidesBottomBarWhenPushed=YES;
    //[self.navigationController pushViewController:sp animated:YES];
    //存储
    FMDBSingleTon *singon=[FMDBSingleTon shareSinglotn];
    [singon addshop:model];
    [self.navigationController pushViewController:sp animated:YES];
}


#pragma mark 数据
-(void)json1:(int)ints{
    //  判断从那个界面进入   品牌  到店预订  上门试衣
    
    [_mudic setObject:@1 forKey:@"model"];
    [_mudic setObject:VERSION forKey:@"ios_version"];
    [_mudic setObject:_appbrandId forKey:@"appbrandId"];
    if ([de objectForKey:@"userId"]) {
        if (_flag==1) {
            if (_hang==1) {
                [_mudic setObject:@0 forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
                [_mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [_mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                    [_mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                
            }else{
                NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
                NSNumber * min = @([minstr integerValue]);
                [_mudic setObject:min forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
                [_mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [_mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                    [_mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
            }
        }else{
        
            if (_hang==1) {
                [_mudic setObject:@0 forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
                [_mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [_mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                [_mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                [_mudic setObject:_appstoreId forKey:@"appstoreId"];
            }else{
                NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
                NSNumber * min = @([minstr integerValue]);
                [_mudic setObject:min forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
                [_mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                if ([de objectForKey:@"newUserId"]) {
                  [_mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                
                [_mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                [_mudic setObject:_appstoreId forKey:@"appstoreId"];
                
            }
        }
    }else{
        if (_flag==1) {
            if (_hang==1) {
                
                [_mudic setObject:@0 forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
                
                
            }else{
                NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
                NSNumber * min = @([minstr integerValue]);
                [_mudic setObject:min forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
            }
        }else{    if (_hang==1) {
                            [_mudic setObject:@0 forKey:@"min"];
                            [_mudic setObject:@10 forKey:@"max"];
                            [_mudic setObject:_appstoreId forKey:@"appstoreId"];
     
            }else{
                NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
                NSNumber * min = @([minstr integerValue]);
                [_mudic setObject:min forKey:@"min"];
                [_mudic setObject:@10 forKey:@"max"];
                [_mudic setObject:_appstoreId forKey:@"appstoreId"];
                
            }
        }
    }
    if ([de objectForKey:@"placename"]) {
        [_mudic setObject:[de objectForKey:@"placename"]  forKey:@"area"];
    }
    
   
        NSDictionary *d=[Uikility initWithdatajson:_mudic];
    NSString *urlstr=[[NSString alloc] init];
        urlstr=[BassAPI requestUrlWithPorType:PortTypeStoregoods];
  
        [AFManger postWithURLString:urlstr parameters:d success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        Boolean success=[[obj objectForKey:@"success"] boolValue];
          
         [HUB hide:YES];
        if (success) {
            
            NSArray *array=[obj objectForKey:@"data"];
            
            for (NSDictionary *dic in array) {
                if (_buttoninter==0) {
                   
                    [_dataarray addObject:[CartModel initwithdic:dic]];
                }else if(_buttoninter==1){
                    [_pricedata addObject:[CartModel initwithdic:dic]];
                    
                }else if (_buttoninter==2){
                  
                  [_salesdata addObject:[CartModel initwithdic:dic]];
                }
                
               
            }
            
            
            if(_buttoninter==1){
                
            if (_priceid==1) {
                [self  Bottomclick];
            }
            if (_priceid==2) {
                [self toptoBottomlick];
            }
                
            }else if (_buttoninter==2){
            
                if (_SaleCount==1) {
                    [self salesHigetolow];
                }else if (_SaleCount==2){
                    [self salesLowtoHigte];
                
                }
            
            
            }
            [HUB hide:YES];
            [_collectionview reloadData];
            [_collectionview.footer endRefreshing];
        }else{
                        [Uikility alert: [obj objectForKey:@"msg"]];
        }

        
    } failure:^(NSError *error) {
        
        [HUB hide:YES];
        //[Uikility alert:@"数据接受失败！"];
    }];
       
}
#pragma mark---------筛选界面
-(void)screeningview{
    _screenView=[[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
    _screenView.alpha=0.5;
    _screenView.backgroundColor=[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
    
   // UIView *
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
