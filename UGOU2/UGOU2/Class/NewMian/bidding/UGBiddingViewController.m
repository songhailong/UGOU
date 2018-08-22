//
//  UGBiddingViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import "UGBiddingViewController.h"
#import "AppDelegate.h"
#import "HYSegmentedControl.h"
#import "UGHeader.h"
#import "UGBiddingTimer.h"
#import "MBProgressHUD.h"
#import "LPLabel.h"
#import "BassAPI.h"
#import "EvaluateTableViewCell.h"
#import "ProductTableViewCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "ShufflingTapGestureRecognizer.h"
#import "ImageTableViewCell.h"
#import "LoginViewController.h"
#import "UGShareView.h"
#import "UGofferViewController.h"
#import "UGOfferPresentationController.h"
#import "CountdownVidew.h"
#import "UGBidSrecordViewController.h"
#import "UGBidSePriceTableViewCell.h"
#import "UGMarginModel.h"
#import "SeckillIdOrderViewController.h"
#import "UGMSGoodModel.h"
@interface UGBiddingViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HYSegmentedControlDelegate,MBProgressHUDDelegate,UIWebViewDelegate,SDWebImageManagerDelegate,UGShareViewDelegate,UGBiddingTimerDlegate,UIViewControllerTransitioningDelegate>{
    UIScrollView *scroll;
    UIScrollView *headscroll;
    UIPageControl *page;
    UITableView *table1;
    UITableView *_table2;
    UITableView *table3;
    UITableView *table4;
    UIView *views;
    UIView *headview;
    NSDictionary *dic;
    UIView *headv2;
    UILabel *sllabel;
    NSArray *reslutFilteredArray;
    NSUserDefaults *de;
    NSInteger cgs;
    HYSegmentedControl *_segment;
    UIView *v2;
    LPLabel *lplabel;
    NSString *url;
    NSDictionary *dicstion;
    NSMutableArray *sparr;
    UIWebView *_webview;
    NSDictionary *dics;
    //评价数据
    NSMutableArray *_evdataarray;
    NSArray *toolbararr;
    UIImageView *titleimageview;
    UIButton *_butsc;
    NSMutableArray *arrays;
    UIView *toolbar;
    NSInteger _selectrow;
    BOOL _IsGet;
    NSArray  * _imarray;
    MJPhotoBrowser *_browser;
    NSMutableArray *_phtotsubviews;
    NSArray *_webimagearray;
    UGShareView *_shareView;
    NSData *_shareImageData;
    UILabel  * _maxPriceLable;
    UIButton *buthh;
    UILabel * _endlable;
    UIView *timeView;
}
@property(nonatomic,strong)UGBiddingTimer*biddingTimer;
@end

@implementation UGBiddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    views=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    views.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:views];
    _evdataarray=[[NSMutableArray alloc] init];
    _IsGet=NO;
    
    _dictionary =[[NSDictionary alloc]init];
    dic=[[NSDictionary alloc]init];
    de=[NSUserDefaults standardUserDefaults];
    sparr=[NSMutableArray array];
    _phtotsubviews=[[NSMutableArray alloc] init];
    _webimagearray=[[NSArray alloc] init];
    _biddingTimer=[[UGBiddingTimer alloc] init];
    _biddingTimer.seckillIds=self.seckillIds;
    _biddingTimer.delegate=self;
    [self addspxq];
    [self loadDate];
}
-(void)BinddingGetBestHeightPriceObjiect:(id)object{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSNumber *num=[object  objectForKey:@"maxSePrice"];
        _maxPriceLable.text=[NSString stringWithFormat:@"%.1f",num.floatValue];
        self.maxSePrice=[object objectForKey:@"maxSePrice"];
        _MarginModel.maxSePrice=self.maxSePrice;
        _MarginModel.userName=[[object objectForKey:@"appuserId"] objectForKey:@"userName"];
        NSString *deuserid= [de objectForKey:@"userId"];
        NSString *deuserStr=[NSString stringWithFormat:@"%@",deuserid];
        NSNumber *usetid=[[object objectForKey:@"appuserId"] objectForKey:@"userId"];
        NSString *useridStr=[NSString stringWithFormat:@"%@",usetid];
        if ([deuserStr isEqualToString:useridStr]) {
            //自己中标
            _IsGet=YES;
        }
        BOOL isauctionEnd=[[object objectForKey:@"auctionEnd"] boolValue];
        if (isauctionEnd) {
            timeView.alpha=0;
            _endlable.alpha=1;
            buthh.selected=YES;
            if (_IsGet) {
                [buthh setTitle:@"去结算" forState:UIControlStateNormal];
            }else{
                buthh.selected=YES;
                buthh.backgroundColor=UGColor(167, 167, 167);
                [buthh setTitle:@"竞拍结束" forState:UIControlStateNormal];
            }
        }
        [table1 reloadData];
    });
    
    //返回主线程UI显示
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    //self.navigationController.navigationBar.translucent=NO;
    //de=[NSUserDefaults standardUserDefaults];
    //view.alpha=0;
    //[self json];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
}
//#pragma mark 2015.10.23.10.30 底部
-(void)addtoolbar{

    toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-60*KIphoneWH, WIDTH, 60*KIphoneWH)];

        buthh=[[UIButton alloc]init];
        buthh.frame=CGRectMake(5*KIphoneWH, 5*KIphoneWH, WIDTH-10*KIphoneWH, 50*KIphoneWH);

        //if (i==3) {
        [buthh setBackgroundImage:[UIImage imageNamed:@"马上抢购"] forState:UIControlStateNormal];
        // }else{
    
        [buthh setTitle:@"出个价" forState:UIControlStateNormal];
        [buthh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buthh setBackgroundColor:[UIColor colorWithRed:233/255.0 green:54/255.0  blue:36/255.0  alpha:1]];
        buthh.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
        [buthh addTarget:self action:@selector(topush:) forControlEvents:UIControlEventTouchUpInside];
    NSString *deuserid= [de objectForKey:@"userId"];
    NSString *deuserStr=[NSString stringWithFormat:@"%@",deuserid];
     NSNumber *usetid=[_dictionary objectForKey:@"userId"];
    NSString *useridStr=[NSString stringWithFormat:@"%@",usetid];
    
    if ([deuserStr isEqualToString:useridStr]) {
        //自己中标
        _IsGet=YES;
    }
    BOOL isauctionEnd=[[_dictionary objectForKey:@"auctionEnd"] boolValue];
    if (isauctionEnd) {
        timeView.alpha=0;
        _endlable.alpha=1;
        buthh.selected=YES;
        if (_IsGet) {
            [buthh setTitle:@"去结算" forState:UIControlStateNormal];
        }else{
            
            buthh.backgroundColor=UGColor(167, 167, 167);
            [buthh setTitle:@"竞拍结束" forState:UIControlStateNormal];
        }
    }
        [toolbar addSubview:buthh];

   // }
    [views addSubview:toolbar];

    //[self addfootview];

}
//点击进入
#pragma mark **********点击出价或者购买
-(void)topush:(UIButton *)b{
    if (b.selected) {
        //
        if (_IsGet) {
        NSMutableArray   * ssssparr=[[NSMutableArray  alloc] init];
            UGMSGoodModel *d=[[UGMSGoodModel alloc]init];
            
            d.quantity=1;
            d.logopicSl=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"logopicSl"];
            d.id=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"id"];
            d.goodsName=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsName"];
            //d.seUid=attributModel.seUid;
            d.attribute=[_dictionary objectForKey:@"attribute"];
            d.seprice=[_dictionary objectForKey:@"maxSePrice"];
            
            [ssssparr addObject:d];
            SeckillIdOrderViewController *f=[[SeckillIdOrderViewController alloc]init];
            f.flag=2;
            
            f.array=ssssparr;
            NSNumber * danjia=[_dictionary objectForKey:@"maxSePrice"];
            //NSLog(@"总价格%@",danjia);
            f.allprice=danjia.floatValue*1;
            f.auctionrecordId=[_dictionary objectForKey:@"auctionrecordId"];
            f.gs=1;
            //f.StoresId=_storeId;
            [self.navigationController pushViewController:f animated:YES];
        }
    }else{
    UGofferViewController*offvc=[[UGofferViewController alloc] init];
   
    NSNumber *Increase=[_dictionary objectForKey:@"priceIncrease"];
    offvc.lowPrice=self.maxSePrice.floatValue+Increase.floatValue;
    offvc.offerPrice=Increase;
    offvc.auctionId=_seckillIds;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullbiddingNotice:) name:fullScreenbiddingNotice object:nil];
    offvc.transitioningDelegate=self;
    
    //设置转场动画样式 必须设置
    offvc.modalPresentationStyle=UIModalPresentationCustom;
    [self presentViewController:offvc animated:YES completion:nil];
    }
}
-(UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[UGOfferPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}
#pragma mark************监听通知
-(void)fullbiddingNotice:(NSNotification *)notifi{
    NSDictionary *notifiDic=notifi.object;
    
    NSNumber *num=[notifiDic objectForKey:@"maxSePrice"];
    _maxPriceLable.text=[NSString stringWithFormat:@"%.1f",num.floatValue];
    self.maxSePrice=[notifiDic objectForKey:@"maxSePrice"];
    _MarginModel.maxSePrice=self.maxSePrice;
    _MarginModel.userName=[[notifiDic objectForKey:@"appuserId"] objectForKey:@"userName"];
    [table1 reloadData];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark *********头视图 （商品价格 商品，名称）
-(void)addheadview{
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,WIDTH+ 150*KIphoneWH)];
    headview.backgroundColor=[UIColor whiteColor];

    NSString *str=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"images"];
    headscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    headscroll.pagingEnabled = YES;//整页
    headscroll.scrollEnabled = YES;
    headscroll.delegate = self;
    [headview addSubview:headscroll];
    headscroll.showsHorizontalScrollIndicator=false;
    page=[[UIPageControl alloc]initWithFrame:CGRectMake(WIDTH/2-50*KIphoneWH,WIDTH -20*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    [page addTarget:self action:@selector(sender:) forControlEvents:UIControlEventEditingChanged];
    // [self performSelector:@selector(video) withObject:nil afterDelay:1.5];
    [headview addSubview:page];
    _imarray= [str componentsSeparatedByString:@";"];

    if (_imarray.count>0) {


        for (int i=0; i<_imarray.count-1; i++) {

            page.numberOfPages=_imarray.count-1;
            headscroll.contentSize = CGSizeMake(WIDTH*(_imarray.count-1), 0);
            NSString *ims=[_imarray objectAtIndex:i];

            UIImageView *imageview = [[UIImageView alloc] init];
            [imageview sd_setImageWithURL:[Uikility URLWithString:ims] placeholderImage:[UIImage imageNamed:@"uuu"]];
            imageview.contentMode=UIViewContentModeScaleAspectFit;
            imageview.userInteractionEnabled=YES;

            ShufflingTapGestureRecognizer *tap1=[[ShufflingTapGestureRecognizer  alloc]
                                                 initWithTarget:self action:@selector(pictures:)];
            tap1.tag=i;
            [imageview  addGestureRecognizer:tap1];

            imageview.frame=CGRectMake(WIDTH*i, 0, WIDTH, WIDTH);
            [_phtotsubviews addObject:imageview];
            [headscroll addSubview:imageview];
//            if (i==0) {
//                imstr=[_imarray objectAtIndex:0];
//            }
        }

    }


    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, WIDTH+5*KIphoneWH, WIDTH-30*KIphoneWH, 50*KIphoneWH)];
    label1.numberOfLines=2;
    label1.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [headview addSubview:label1];
    label1.textColor=[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    label1.text=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsName"];

    _maxPriceLable=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, WIDTH+ 55*KIphoneWH, 200*KIphoneWH, 30*KIphoneWH)];
    _maxPriceLable.textColor=[UIColor colorWithRed:233/255.0 green:94/255.0 blue:75/255.0 alpha:1];
    [headview addSubview:_maxPriceLable];
    //打折后的价格
    _maxPriceLable.font=[UIFont systemFontOfSize:25*KIphoneWH];

    // NSString *s2=[[_dictionary objectForKey:@"goods"]objectForKey:@"promotionPrice"];
    NSNumber *maxSePrice=[_dictionary objectForKey:@"maxSePrice"];
    if(maxSePrice!=nil){
        CGFloat s3=maxSePrice.floatValue;
        _maxPriceLable.text=[NSString stringWithFormat:@"￥%.1f",s3];
    }else{
         NSNumber *seprice=[_dictionary objectForKey:@"seprice"];
        CGFloat s3=seprice.floatValue;
        _maxPriceLable.text=[NSString stringWithFormat:@"￥%.1f",s3];
    }
    
    //原价
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, WIDTH+ 90*KIphoneWH,60*KIphoneWH, 20*KIphoneWH)];
    label3.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [headview addSubview:label3];
    label3.font=[UIFont systemFontOfSize:15*KIphoneWH];
    label3.text=@"起拍价";

    NSString *s=(NSString *)[_dictionary objectForKey:@"seprice"];
    CGFloat ss=s.floatValue;
    if (ss) {
        lplabel=[[LPLabel alloc]initWithFrame:CGRectMake(60*KIphoneWH,WIDTH+ 90*KIphoneWH,100*KIphoneWH, 20*KIphoneWH)];
        lplabel.strikeThroughEnabled=NO;
        lplabel.text=[NSString stringWithFormat:@"￥%.1f",ss];
        lplabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];

        lplabel.font=[UIFont systemFontOfSize:15*KIphoneWH];

        [headview addSubview:lplabel];

    }
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH,WIDTH +120*KIphoneWH, 180*KIphoneWH, 20*KIphoneWH)];
    label4.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    label4.textColor=[UIColor blackColor];
    [headview addSubview:label4];
    label4.font=[UIFont systemFontOfSize:15*KIphoneWH];
    label4.text=[_dictionary objectForKey:@"attribute"];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+20*KIphoneWH, WIDTH +120*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    label5.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [headview addSubview:label5];
    label5.font=[UIFont systemFontOfSize:15*KIphoneWH];
    NSString * salezcount=[_dictionary objectForKey:@"total"] ;


    if(salezcount==nil){
        label5.text=@"商品已抢购完";

    }else{
        label5.text=[NSString stringWithFormat:@"商品仅剩%@件",salezcount];

     }
    NSNumber *priceIncrease=[_dictionary objectForKey:@"priceIncrease"];
    if (priceIncrease!=nil) {
        label5.text=[NSString stringWithFormat:@"加价幅度: ¥%zd",priceIncrease.integerValue];
    }
    [self creatCountdownView];
    [views addSubview:headview];
}
#pragma mark*********定时器
-(void)creatCountdownView{

    timeView=[[UIView alloc] initWithFrame:CGRectMake(WIDTH-140*KIphoneWH, WIDTH+55*KIphoneWH, 140*KIphoneWH, 30*KIphoneWH)];
    [headview addSubview:timeView];
    _countview=[[CountdownVidew alloc] initWithFrame:CGRectMake(30*KIphoneWH, 10*KIphoneWH, 80*KIphoneWH, 20*KIphoneWH)];
    //NSNumber *deadline=[_dictionary objectForKey:@"reTime"];
   // NSLog(@"============%@",deadline);
    _countview.time=self.time;
    _countview.timelableBackColor=[UIColor colorWithRed:233/255.0 green:75/255.0 blue:69/255.0 alpha:1];
    _countview.timeLableFont=[UIFont systemFontOfSize:10*KIphoneWH];
    [timeView addSubview:_countview];

    UILabel *endTitleLable=[[UILabel alloc] initWithFrame:CGRectMake(30*KIphoneWH, 0, 80*KIphoneWH, 10*KIphoneWH)];
    endTitleLable.text=@"距离结束还剩：";
    endTitleLable.textAlignment=NSTextAlignmentCenter;
    endTitleLable.font=[UIFont systemFontOfSize:10*KIphoneWH];
    endTitleLable.textColor=[UIColor colorWithRed:233/255.0 green:75/255.0 blue:69/255.0 alpha:1];
    _endlable=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-140*KIphoneWH, WIDTH+55*KIphoneWH, 140*KIphoneWH, 30*KIphoneWH)];
    _endlable.backgroundColor=[UIColor clearColor];
    _endlable.text=@"竞拍结束";
    _endlable.textColor=UGColor(167, 167, 167);
    _endlable.alpha=0;
    [headview addSubview:_endlable];
    [timeView addSubview:endTitleLable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SecondskillEndAction:) name:SecondskillEndNotifi object:nil];


}
#pragma mark***********结束通知
-(void)SecondskillEndAction:(NSNotification *)notifi{
    //buthh setTitle:@"" forState:<#(UIControlState)#>
   
    timeView.alpha=0;
    _endlable.alpha=1;
}
#pragma mark-------------图片轮播图
-(void)pictures:(ShufflingTapGestureRecognizer *)Recognize{

    NSMutableArray *selsctarray=[[NSMutableArray alloc] init];
    for (int i=0; i<_imarray.count-1; i++) {
        MJPhoto *photo=[[MJPhoto alloc] init];

        NSURL *imageurl=[Uikility URLWithString:_imarray[i]];
        photo.url=imageurl;
        photo.srcImageView=_phtotsubviews[i];
        [selsctarray addObject:photo];
    }
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    browser.photos=selsctarray;
    browser.currentPhotoIndex=Recognize.tag;
   // browser.delegate=self;

    //[self.view addSubview:browser.view];
    [browser show];

    //UIViewController *cvv=[[UIViewController alloc] init];
    //cvv.view.backgroundColor=[UIColor redColor];
    //[self.view addSubview:cvv.view];

}


#pragma mark 商品详情底层scollview

-(void)addspxq{

    UIButton *leftbut=[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 40*KIphoneWH, 70*KIphoneWH)];

    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
    UIImage *img=[UIImage imageNamed:@"返回p"];
    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
    [leftbut addSubview:imgv];
    imgv.frame=CGRectMake(15*KIphoneWH, 40*KIphoneWH, 10*KIphoneWH, 15*KIphoneWH);
    [leftbut addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    leftbut.tag=1;
    [views addSubview:leftbut];



    UIButton *rightbut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50*KIphoneWH, 0*KIphoneWH, 50*KIphoneWH, 60*KIphoneWH)];
    UIImageView *rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 35*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    rightImageView.image=[UIImage imageNamed:@"分享"];
    [views addSubview:rightImageView];

    [rightbut addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    rightbut.tag=2;
    [views addSubview:rightbut];
    _segment = [[HYSegmentedControl alloc] initWithOriginY:3 width:WIDTH-80*KIphoneWH color:[UIColor colorWithRed:246/255.0 green:186/255.0 blue:90/255.0 alpha:1]Titles:@[@"商品",@"详情",@"评价"] delegate:self] ;


    _segment.delegate=self;
    [views addSubview:_segment];
    if (iPhoneX) {
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70*KIphoneWH+20, WIDTH, HEIGHT-124*KIphoneWH-20)];
        _segment.frame=CGRectMake(40*KIphoneWH, 30*KIphoneWH+20, WIDTH-80*KIphoneWH-20, 40*KIphoneWH);
        leftbut.frame=CGRectMake(0, 20, 40*KIphoneWH, 70*KIphoneWH);
        rightbut.frame=CGRectMake(WIDTH-50*KIphoneWH, 20, 50*KIphoneWH, 60*KIphoneWH);
        rightImageView.frame=CGRectMake(WIDTH-40*KIphoneWH, 35*KIphoneWH+20, 20*KIphoneWH, 20*KIphoneWH);
    }else{
        scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
        _segment.frame=CGRectMake(40*KIphoneWH, 30*KIphoneWH, WIDTH-80*KIphoneWH, 40*KIphoneWH);
    }

    scroll.contentSize=CGSizeMake(WIDTH*3, 0);
    scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    scroll.delegate=self;
    [views addSubview:scroll];



}
#pragma mark*******创建tableview
-(void)addtableview{


    table1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-124*KIphoneWH)style:UITableViewStyleGrouped];
    table1.delegate=self;
    table1.dataSource=self;
    table1.tag=1;
    [table1 registerClass:[UGBidSePriceTableViewCell class] forCellReuseIdentifier:@"UGBidSePriceTableViewCell"];
    [scroll addSubview:table1];
    [self addheadview];
    table1.tableHeaderView=headview;
     //[self addfootviews];
    //table1.tableFooterView=footview;
    //*详情页------------
    UIView *detailsview=[[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-164*KIphoneWH)];

    //detailsview.backgroundColor=[UIColor grayColor];
    _webview=[[UIWebView alloc] initWithFrame:CGRectMake(12*KIphoneWH, 40*KIphoneWH, WIDTH-24*KIphoneWH,HEIGHT-164*KIphoneWH )];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(12*KIphoneWH, 0, WIDTH-24*KIphoneWH, 40*KIphoneWH)];
    lable.text=@"--------------  商品详情  --------------";
    lable.textColor=[UIColor colorWithRed:233.0/255.0 green:94.0/255.0 blue:75.0/255.0 alpha:1];
    lable.textAlignment=NSTextAlignmentCenter;
    [detailsview addSubview:lable];

    if ([[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsNewDetail"]) {


        _table2=[[UITableView alloc] initWithFrame:CGRectMake( 10*KIphoneWH, 40*KIphoneWH, WIDTH-20*KIphoneWH,HEIGHT-164*KIphoneWH )style:UITableViewStylePlain];
        _table2.delegate=self;
        _table2.dataSource=self;
        [detailsview addSubview:_table2];

    }else if ([[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsNewDetail"]){
        _webview=[[UIWebView alloc] initWithFrame:CGRectMake(12*KIphoneWH, 40*KIphoneWH, WIDTH-24*KIphoneWH,HEIGHT-164*KIphoneWH )];
        [detailsview addSubview:_webview];
        NSString *str=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsNewDetail"];
        NSRange rang=[str rangeOfString:@"src='"];
        NSRange rang1=[str rangeOfString:@"' width"];
        NSUInteger urllocation=rang.location+rang.length;
        NSUInteger urllength=rang1.location-urllocation;
        NSString *urlstr=[str substringWithRange:NSMakeRange(urllocation, urllength)];
        _webview.scalesPageToFit=YES;
        _webview.delegate=self;
        NSURLRequest *requust=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        [_webview loadRequest:requust];

    }



    //详情页 ----轮播图
    [scroll addSubview:detailsview];

    table3=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT-124*KIphoneWH)style:UITableViewStyleGrouped];
    table3.delegate=self;
    table3.dataSource=self;
    table3.tag=3;
    //table3.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 5*KIphoneWH)];
    view3.backgroundColor=[UIColor whiteColor];
    table3.tableHeaderView=view3;
    [scroll addSubview:table3];
    [self addtoolbar];
}
#pragma mark 导航栏 按钮 分享界面
-(void)change:(UIButton *)b{

    if (b.tag==1) {

        //[self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(b.tag==2){
        _shareView=[[UGShareView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        //_shareView.backgroundColor=[UIColor blueColor];
        _shareView.delegate=self;
        [self.view addSubview:_shareView];
        _shareView.alpha=1;
    }
}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{ if (index==2) {
    //[self evaluationreadtata];
}
    [scroll setContentOffset:CGPointMake(WIDTH*(int)index, 0) animated:YES];
}

-(void)sender:(UIPageControl *)p{
    int index = (int)p.currentPage;
    [headscroll setContentOffset:CGPointMake(WIDTH*index, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = headscroll.contentOffset.x/WIDTH;
    page.currentPage = index;
    int index1 = scroll.contentOffset.x/WIDTH;
    if (index==2) {
        //[self evaluationreadtata];
    }
    [_segment changeSegmentedControlWithIndex:index1];
}
#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==table3) {
        if (_evdataarray.count) {
            return _evdataarray.count;
        }else{
            return 0;
        }
    }else if (tableView==_table2){

        NSString *str=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsNewDetail"];

        _webimagearray= [str componentsSeparatedByString:@";"];

        if(_webimagearray.count){

            return _webimagearray.count-1;}else{

                return 0;
            }

    }else if (tableView==table1){

        return 1;


    }

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (table3==tableView) {
        if (_evdataarray.count) {
            CartModel *model=_evdataarray[indexPath.row];
            CGSize size=[model.content boundingRectWithSize:CGSizeMake(WIDTH-30*KIphoneWH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*KIphoneWH]forKey:NSFontAttributeName] context:nil].size;
            return 50*KIphoneWH+size.height*KIphoneWH;
        }
    }else if(table1==tableView){
        if (indexPath.row==0) {
            if(_selectrow==2){
                return 220*KIphoneWH;
            }
        }

        return 44*KIphoneWH;

    }else if (tableView==_table2){


        return WIDTH;

    }
    return 44*KIphoneWH;
}

#pragma mark**********返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    if (table1==tableView) {
        UGBidSePriceTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"UGBidSePriceTableViewCell" forIndexPath:indexPath];

        
        cell1.userNameLable.text=_MarginModel.userName;
        NSNumber *pricenum=_MarginModel.maxSePrice;
        cell1.maxSellable.text=[NSString stringWithFormat:@"最高出价:"];
        
        cell1.pricelable.text=[NSString stringWithFormat:@"¥%@",pricenum];
        if (pricenum==nil) {
             NSNumber *sepricenum=[_dictionary objectForKey:@"seprice"];
            cell1.pricelable.text=[NSString stringWithFormat:@"¥%@",sepricenum];
        }
        /**
         UITableViewCellAccessoryNone,                                                      // don't show any accessory view
         UITableViewCellAccessoryDisclosureIndicator,                                       //小箭头
         UITableViewCellAccessoryDetailDisclosureButton __TVOS_PROHIBITED,                 // info button w/ chevron. tracks
         UITableViewCellAccessoryCheckmark,                                                 // 对号
         UITableViewCellAccessoryDetailButton NS_ENUM_AVAILABLE_IOS(7_0)  __TVOS_PROHIBITED // 小图片*/
        //cell1.accessoryType=UITableViewCellAccessoryDetailButton;
        
        

            return cell1;

    }
    if (table3==tableView) {
        EvaluateTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qqq"];
        if (!cell) {
            cell=[[EvaluateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
        }
        if (_evdataarray.count) {
            CartModel *model=_evdataarray[indexPath.row];
            cell.namelable.text=model.userName;

            cell.titlelable.text=model.content;
            cell.attributelable.text=model.attribute;
            long long s=  model.reTime.longLongValue;
            NSString *sss=[NSString stringWithFormat:@"%lld",s/1000];

            long gg=sss.integerValue;

            NSString *timestr=[Uikility DatetoTime:gg];

            cell.timelable.text=timestr;
            CGSize size=[model.content boundingRectWithSize:CGSizeMake(WIDTH-30*KIphoneWH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:cell.titlelable.font forKey:NSFontAttributeName] context:nil].size;
            CGRect frame=cell.titlelable.frame;
            frame.size.width=WIDTH-30*KIphoneWH;
            frame.size.height=size.height;

            cell.titlelable.frame=frame;
            CGRect attframe=cell.attributelable.frame;
            attframe.origin.y=size.height+30*KIphoneWH;
            cell.attributelable.frame=attframe;
            CGRect timeframe=cell.timelable.frame;
            timeframe.origin.y=size.height+30*KIphoneWH;
            cell.timelable.frame=timeframe;
            //return cell;
        }
        return cell;
    }else if (tableView==_table2){


        ImageTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ugou2"];

        if (!cell) {
            cell=[[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ugou2"];
        }


        NSString *str=[[_dictionary objectForKey:@"appgoodsId"]objectForKey:@"goodsNewDetail"];

        _webimagearray= [str componentsSeparatedByString:@";"];

        NSString *ims=[_webimagearray objectAtIndex:indexPath.row];
        [ cell.imageview1   sd_setImageWithURL:[Uikility URLWithString:ims] placeholderImage:[UIImage imageNamed:@"uuu"]];

        return cell;
    }

    return cell;
}

#pragma mark 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==table1) {
//        if (indexPath.row==2) {
////
////            if (_selectrow==2) {
////                _selectrow=1;
////            }else{
////                _selectrow=2;
////            }
////
////            [tableView reloadData];
//
//        }else if (indexPath.row==0){
            if ([de objectForKey:@"userId"]) {


                UGBidSrecordViewController*u=[[UGBidSrecordViewController alloc]init];
                u.auctionId=self.seckillIds;
                [self.navigationController pushViewController:u animated:YES];
            }else{
                //[Uikility alert:@"请先登录！"];
                LoginViewController *log=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:log animated:YES];
           }

       
    }else if (tableView==_table2){
        NSString *str=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsNewDetail"];

        _imarray= [str componentsSeparatedByString:@";"];


        NSMutableArray *selsctarray=[[NSMutableArray alloc] init];
        for (int i=0; i<_imarray.count-1; i++) {
            MJPhoto *photo=[[MJPhoto alloc] init];

            NSURL *imageurl=[NSURL URLWithString:_imarray[i]];
            photo.url=imageurl;
            UIImage *image1=[UIImage imageNamed:@"uuu"];
            photo.image=image1;
            [selsctarray addObject:photo];
        }
        MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
        browser.photos=selsctarray;
        browser.currentPhotoIndex=indexPath.row;
        //browser.delegate=self;

        //[self.view addSubview:browser.view];
        [browser show];




    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 数据
-(void)loadDate{
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    //NSNumber * nums = @([_goodsId integerValue]);

    [mudic setObject:_seckillIds forKey:@"auctionId"];
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    if ([de objectForKey:@"userId"]) {
        [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
    }
    NSDictionary *json1=[Uikility initWithdatajson:mudic];


    NSString *urls=[BassAPI requestUrlWithPorType:portTypeGiveGetAuctionaGood];
    [AFManger postWithURLString:urls parameters:json1 success:^(id responseObject) {
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
      
        Boolean success=[[strs objectForKey:@"success"] boolValue];
        if (success) {
            _dictionary=[strs objectForKey:@"data"];
           
            NSNumber *maxSePrice=[_dictionary objectForKey:@"maxSePrice"];
            
            if (maxSePrice==nil) {
                NSNumber *seprice=[_dictionary objectForKey:@"seprice"];
                self.maxSePrice=seprice;
            }else{
                self.maxSePrice=maxSePrice;
            }
            
            
            _MarginModel=[[UGMarginModel alloc] init];
            _MarginModel.maxSePrice=[_dictionary objectForKey:@"maxSePrice"];
            _MarginModel.userName=[_dictionary objectForKey:@"userName"];
            [self addtableview];
            //[self evaluationreadtata];


        }else{
            [Uikility alert:[strs objectForKey:@"msg"]];
        }

    } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
    }];
}
#pragma mark----评价页面数据请求
-(void)evaluationreadtata{
    NSNumber * nums = @([_goodsId integerValue]);

    if ([de objectForKey:@"userId"]) {
        if ([de objectForKey:@"newUserId"]) {
            dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId" ],@"goodsId":nums,@"model":@1,@"ios_version":VERSION};
        }else{

            dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"goodsId":nums,@"model":@1,@"ios_version":VERSION};
        }

    }else{
        dic=@{@"goodsId":nums,@"model":@1,@"ios_version":VERSION};
    }
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeSelectEvaluate];
    NSDictionary *dicurl=[Uikility initWithdatajson:dic];
    [AFManger postWithURLString:urlstr parameters:dicurl success:^(id responseObject) {
        id json2=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        Boolean success=[[json2 objectForKey:@"success"] boolValue];

        if (success) {

            NSArray *array=[json2 objectForKey:@"data"];

            for (NSDictionary *dicda in array ) {
                CartModel *model=[CartModel initwithdic:dicda];
                model.userName=[[dicda objectForKey:@"appuserId"]objectForKey:@"userName"];
                [_evdataarray addObject:model];
            }
            [table3 reloadData];
        }else{
            [Uikility alert:[json2 objectForKey:@"msg"]];
        }

    } failure:^(NSError *error) {
        [Uikility alert:@"数据接受失败！"];
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str=  [[_dictionary objectForKey:@"goods"]objectForKey:@"goodsDetail"];

    [webView stringByEvaluatingJavaScriptFromString:str];

}
//创建分享页面
-(void)creatShareView{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *imagesStr=[[_dictionary objectForKey:@"goods"]objectForKey:@"logopicUrl"];
        NSData *imagedata;

        imagedata=[NSData dataWithContentsOfURL:[Uikility URLWithString:imagesStr]];
        _shareImageData=imagedata;

    });

}
-(void)UGShareViewHide{

    _shareView.alpha=0;
}
-(void)UGShareViewDidSelect:(shareType)shareType{
    //_shareView.alpha=0;
    NSString *goodsname=[[_dictionary objectForKey:@"goods"] objectForKey:@"goodsName"];

    NSString *shareURL=[NSString stringWithFormat:@"%@%@&ios_version=%@&area=%@&timestamp=%ld",ShareURL,_goodsId,VERSION,[de objectForKey:@"placename"],[Uikility readnowtime]];
    Uikility *kility=[[Uikility alloc] init];
    if (_shareImageData==nil) {

        return;
    }

    NSData *data=_shareImageData;

    UIImage *shareImage=[UIImage imageWithData:data];


    NSString   *shareText=@"U购--不一样的购物体验";
    //微信 微博小于32k
    switch (shareType) {

        case UGShareTypeSina:
        {

            _shareView.alpha=0;
            [kility shareYMWbsinaWithimage:_shareImageData title:goodsname description:shareText url:shareURL viewcontrol:self  ];
        }
            break;
        case UGShareTypeQQZone:
        {
            _shareView.alpha=0;
            [kility shareWithYmQQzone:goodsname Withurl:shareURL title:goodsname imagedata:shareImage imageurl:nil viewcontrol:self];
        }
            break;

        case UGShareTypeWX:

        {


            _shareView.alpha=0;

            [kility shareWithYMWXfrendtext:shareText Withurl:shareURL title:goodsname imagedata:data uiiamge:shareImage viewcontrol:self];


        }
            break;

        case UGShareTypeWeChat:
        {   _shareView.alpha=0;

            [kility shareWithYMWexintext:shareText Withurl:shareURL title:goodsname imagedata:data uiiamge:shareImage viewcontrol:self];

        }
            break;
        default:
            break;
    }
}

-(UIImage *)imageCompression:(UIImage *)imagedata{
    NSData * imageData = UIImageJPEGRepresentation(imagedata, 0.1);
    UIImage * newImage = [UIImage imageWithData:imageData];
    return newImage;
}

- (NSData *)zipImageWithUrl:(id)imageUrl
{
    NSData * imageData = [[NSData alloc]initWithContentsOfURL:[Uikility URLWithString:imageUrl]];
    //imageData = UIImagePNGRepresentation(imageUrl);
    CGFloat maxFileSize = 32*1024;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    UIImage *image = [UIImage imageWithData:imageData];
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        compressedData = UIImageJPEGRepresentation(image, compression);
    }
    //UIImage *compressedImage = [UIImage imageWithData:imageData];
    return imageData;
}


@end
