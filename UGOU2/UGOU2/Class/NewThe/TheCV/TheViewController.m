//
//  TheViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.10.9.24 主题
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "TheViewController.h"
#import "SearchViewController.h"
#import "TableViewCell.h"
#import "HYSegmentedControl.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "ThemeCell.h"
#import "ThemeModel.h"
#import "CenterModel.h"
#import "ThemeViewController.h"
#import "LoginViewController.h"
#import "KjViewController.h"
#import "BrandDynamicViewController.h"
#import "ActivityZoneViewController.h"
#import "FashionViewController.h"
#import "VideoStudyViewController.h"
#import "CenterModel.h"
#import "PlayVideoViewController.h"
#import "ActivityGoodViewController.h"
#import "WMPlayer.h"
#import "LocateFailureView.h"
#import "UGHeader.h"
#import "UGMSListViewController.h"
@interface TheViewController ()<UITableViewDataSource,UITableViewDelegate,  UIScrollViewDelegate,HYSegmentedControlDelegate,VideoIsHideBarDelegate>{
    HYSegmentedControl *_segment;
    UIScrollView *scroll;
    UITableView *table1;
    // UITableView *table2;
    // UITableView *table3;
    NSMutableArray *_dataarray;
    NSUserDefaults *_dc;
    NSDictionary  * _postdic;
    
    NSUserDefaults *def;
    BOOL isHideStaueBar;
    LocateFailureView *_locatfailureView;
 }
@property(nonatomic,strong)BrandDynamicViewController*BrandDynamicVC;
@property(nonatomic,strong)ActivityZoneViewController *activityZoneVC;
@property(nonatomic,strong)FashionViewController *fashionVC;
@property(nonatomic,strong)VideoStudyViewController*videoVC;
@end

@implementation TheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataarray=[[NSMutableArray alloc] init];
    //[self searchAdress];
    [self addnavigation];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    
    if ([de objectForKey:@"placename"]) {
        
        [self  creatUI];
    }else{
    
    [self creatfailView];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSucess:) name:@"locationSucess" object:nil];
    
    //[self addview];
     //[self redjsondata];
    // Do any additional setup after loading the view.
}
-(void)locationSucess:(NSNotification *)noti{
    _locatfailureView.alpha=0;
    [self  creatUI];

}
-(void)creatfailView{
    _locatfailureView=[[LocateFailureView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight-20)];
    [self.view addSubview:_locatfailureView];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[_dataarray removeAllObjects];
    //self.navigationController.navigationBar.translucent=YES;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewContol:) name:@"pushcenter" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stausBarHide:) name:@"isHideStaueBar" object:nil];
    
    //[self redjsondata];
     //[self searchAdress];
    //[table1 reloadData];
    
}
 #pragma mark 导航栏
-(void)addnavigation{
    
    def=[NSUserDefaults standardUserDefaults];

    UGCustomNavView * custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [custemNav.RightButton setTitle:[def objectForKey:@"district"] forState:UIControlStateNormal];
    custemNav.title=@"主题";
    [self.view addSubview:custemNav];
}
#pragma mark-选择城市
-(void)selectdplace{
    
  
}

-(void)creatUI{
    _segment=[[HYSegmentedControl alloc] initWithOriginY:4 width:WIDTH color:[UIColor greenColor] Titles:@[@"活动专区",@"品牌动态",@"时尚搭配",@"视频"] delegate:self];
    _segment.frame=CGRectMake(0, NavHeight, WIDTH, 40*KIphoneWH);
    
    _segment.delegate=self;
    _segment.bottomLineView.hidden=YES;
    //_segment.btn.titleLabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    [self.view addSubview:_segment];
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40*KIphoneWH+NavHeight, WIDTH, HEIGHT-NavHeight-40*KIphoneWH)];
    scroll.contentSize=CGSizeMake(WIDTH*4, HEIGHT-NavHeight-40*KIphoneWH);
    scroll.delegate=self;
    //是否按页滚动
    scroll.pagingEnabled=YES;
    //是否滚动
    scroll.scrollEnabled=YES;

    scroll.backgroundColor=[UIColor whiteColor];
    self.BrandDynamicVC.view.frame=CGRectMake(WIDTH, 0, WIDTH, HEIGHT-NavHeight-40*KIphoneWH-49);
    self.activityZoneVC.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT-NavHeight-40*KIphoneWH-49);
    self.fashionVC.view.frame=CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT-NavHeight-40*KIphoneWH-49);
    self.videoVC.view.frame=CGRectMake(WIDTH*3, 0, WIDTH, HEIGHT-NavHeight-40*KIphoneWH-49);
    [scroll addSubview:self.BrandDynamicVC.view];
    [scroll addSubview:self.activityZoneVC.view];
    [scroll addSubview:self.fashionVC.view];
    [scroll addSubview:self.videoVC.view];
    [self.view addSubview:scroll];
    

}

#pragma mark 主题分类
-(void)addview{
    
    table1=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight)];
    table1.delegate=self;
    table1.dataSource=self;
    table1.tag=1;
    table1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table1];
    
    
    // [self redjsondata];
    
}
#pragma mark----请求
-(void)redjsondata{
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeSelectTheme];
    NSMutableDictionary *postdic=[[NSMutableDictionary alloc] init];
    _dc=[NSUserDefaults standardUserDefaults];
    if ([_dc objectForKey:@"userId"]) {
        [postdic setObject:[_dc objectForKey:@"userId"] forKey:@"userId"];
        [postdic setObject:[_dc objectForKey:@"sessionid"] forKey:@"sessionid"];
        if ([_dc objectForKey:@"newUserId"]) {
            [postdic setObject:[_dc objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        
        [postdic setObject:@1 forKey:@"model"];
        
                
        NSDictionary *dicurl=[Uikility initWithdatajson:postdic];
       
        [AFManger postWithURLString:urlstr parameters:dicurl success:^(id responseObject) {
            id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            Boolean successsss=[[objec objectForKey:@"success"] boolValue];
           
            if (successsss) {
                
                NSArray *array=[objec objectForKey:@"data"];
                
                [_dataarray removeAllObjects];
                for (NSDictionary *dic in array) {
                    [_dataarray addObject:[ThemeModel initWithModeldic:dic]];
                }
                [table1 reloadData];
            }else{
                [Uikility alert:[objec objectForKey:@"msg"]];
                
            }

            
        } failure:^(NSError *error) {
            [Uikility alert:@"连接失败！"];
        }];
        
    }else{
        
        
        _postdic=@{@"model":@1,@"ios_version":VERSION};
         NSDictionary *dicurl=[Uikility initWithdatajson:_postdic];
        [AFManger postWithURLString:urlstr parameters:dicurl success:^(id responseObject) {
            id objec=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            Boolean successsss=[[objec objectForKey:@"success"] boolValue];
            
            
            if (successsss) {
                
                NSArray *array=[objec objectForKey:@"data"];
                [_dataarray removeAllObjects];
                for (NSDictionary *dic in array) {
                    [_dataarray addObject:[ThemeModel initWithModeldic:dic]];
                }
                [table1 reloadData];
            }else{
                [Uikility alert:[objec objectForKey:@"msg"]];
                
            }

            
        } failure:^(NSError *error) {
            [Uikility alert:@"连接失败！"];
            [table1 reloadData];
        }];
    }
}
#pragma mark 滑动 效果
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    
    //scroll.contentOffset=CGPointMake(WIDTH*index, 0);
    
    
//    ActivityGoodViewController    *threm=[[ActivityGoodViewController  alloc] init];
//    threm.URLString=@"https://flv2.bn.netease.com/videolib3/1703/29/TtjqV8139/SD/TtjqV8139-mobile.mp4";
//    
//   
//    [self.navigationController pushViewController:threm animated:YES];
    

   
    
    
    [scroll setContentOffset:CGPointMake(WIDTH*(int)index, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scroll.contentOffset.x/WIDTH;
    [_segment changeSegmentedControlWithIndex:index];
}
#pragma mark tableview 代理 具体内容
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150*KIphoneWH;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    ThemeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[ThemeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_dataarray.count) {
       ThemeModel *model=[_dataarray objectAtIndex:indexPath.row];
    [cell.titileimageview sd_setImageWithURL:[Uikility URLWithString:model.img]placeholderImage:[UIImage imageNamed:@"uuu"]];
        
    
    }
   
    return cell;
}

#pragma mark 点击tableview
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    ThemeViewController *tvc=[[ThemeViewController alloc] init];
    
    
    ThemeModel *model=_dataarray[indexPath.row];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if (_dataarray.count) {
        
        if (model.imgUrl.integerValue==3) {
            if ([de objectForKey:@"userId"]) {
            KjViewController *k=[[KjViewController alloc]init];
            [self.navigationController pushViewController:k animated:YES];
            }else{
                
                LoginViewController *log=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:log animated:YES];
                
            }
        
        
        }else if (model.flag.integerValue==4){
           
        
        
        
        }else{
    
        ThemeModel *model=_dataarray[indexPath.row];
        tvc.imgurl=model.imgUrl;
        [self.navigationController pushViewController:tvc animated:YES];
        }
    }
}
-(BrandDynamicViewController *)BrandDynamicVC{
    
    if (!_BrandDynamicVC) {
        self.BrandDynamicVC=[[BrandDynamicViewController alloc] init];
        //self.BrandDynamicVC.view.frame=CGRectMake(0, 100, WIDTH, 200);
        self.BrandDynamicVC.view.frame=CGRectMake(WIDTH, 0, WIDTH, HEIGHT-NavHeight-40*KIphoneWH-49);
    }
    return _BrandDynamicVC;

}
#pragma mark*********懒加载
-(ActivityZoneViewController *)activityZoneVC{
    if (!_activityZoneVC) {
        _activityZoneVC=[[ActivityZoneViewController alloc] init];
        //_activityZoneVC.view.frame=CGRectMake(0, 100, WIDTH, 200);
    }

    return _activityZoneVC;

}
-(FashionViewController *)fashionVC{
    
    if (!_fashionVC) {
        self.fashionVC=[[FashionViewController alloc] init];
        //self.fashionVC.view.frame=CGRectMake(0, 100, WIDTH, 200);
     }
    return _fashionVC;
}
-(VideoStudyViewController *)videoVC{
    if (!_videoVC) {
        self.videoVC=[[VideoStudyViewController alloc] init];
        self.videoVC.Delegate=self;
    }
    return _videoVC;

}
#pragma mark****************跳转通知
-(void)pushViewContol:(NSNotification *)notifi{
    
    CenterModel *centeModel=(CenterModel *)[notifi object];
   
    switch (centeModel.VCtype) {
        case 0:
        {
            //flag   0:活动, 1:秒杀, 2:拍卖
            if (centeModel.flag==0) {
                ActivityGoodViewController *activiGood=[[ActivityGoodViewController alloc] init];
                 activiGood.brandID=centeModel.brandID;
                if(![self.navigationController.topViewController isKindOfClass:[ActivityGoodViewController class]]) {
                        [self.navigationController pushViewController:activiGood animated:YES];
                                }
            }else if (centeModel.flag==1){
                UGMSListViewController   *msvc=[[UGMSListViewController alloc] init];
                msvc.flag=1;
                
                if(![self.navigationController.topViewController isKindOfClass:[UGMSListViewController class]]) {
                    [self.navigationController pushViewController:msvc animated:YES];
                }
            }else if (centeModel.flag==2){
                UGMSListViewController   *msvc=[[UGMSListViewController alloc] init];
                msvc.flag=2;
                if(![self.navigationController.topViewController isKindOfClass:[UGMSListViewController class]]) {
                    [self.navigationController pushViewController:msvc animated:YES];
                }
            }
            
            
            
        
        }
            break;
        case 1:
        {
            ThemeViewController *threm=[[ThemeViewController alloc] init];
            threm.imgurl=centeModel.URLString;
            if(![self.navigationController.topViewController isKindOfClass:[ThemeViewController class]]) {
                [self.navigationController pushViewController:threm animated:YES];
            }

            
        
        
        }
            
            break;
        case 2:{
            ThemeViewController *threm=[[ThemeViewController alloc] init];
            threm.imgurl=centeModel.URLString;
            if(![self.navigationController.topViewController isKindOfClass:[ThemeViewController class]]) {
                [self.navigationController pushViewController:threm animated:YES];
            }

            

        
        }
            
            break;
        case 3:{
        
         PlayVideoViewController   *threm=[[PlayVideoViewController  alloc] init];
            threm.URLString=centeModel.URLString;
            threm.intro=centeModel.intero;
            if(![self.navigationController.topViewController isKindOfClass:[PlayVideoViewController class]]) {
                [self.navigationController pushViewController:threm animated:YES];
            }
//            UGMSListViewController   *msvc=[[UGMSListViewController alloc] init];
//            
//            if(![self.navigationController.topViewController isKindOfClass:[UGMSListViewController class]]) {
//                [self.navigationController pushViewController:msvc animated:YES];
//            }
            
        
        }
        
            
            break;
            
        default:
            break;
    }
    
    //[self.navigationController pushViewController:UIvc animated:YES];
}
#pragma mark***********屏幕旋转
-(void)onDeviceOrientationChange{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    self.interfaceOrientation=interfaceOrientation;
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
        {
           
        }
            break;
        case UIInterfaceOrientationPortrait:
        {
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            
        }
            break;
            
        default:
            break;
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"onDeviceOrientationChange" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onDeviceOrientationChange" object:self];
}

-(void)prefersVideoStatusBarHidden:(BOOL)ishiden{
    isHideStaueBar=ishiden;
     
    [self setNeedsStatusBarAppearanceUpdate];
    //[[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

}
//-(void)stausBarHide:(NSNotification *)notifi{
//    WMPlayer *palyer=(WMPlayer *)[notifi object];
//    isHideStaueBar=palyer.isFullscreen;
//    NSLog(@"hjvkgkvhjvhvhjvjhvjhvhjvj");
//    [self setNeedsStatusBarAppearanceUpdate]; 
//
//
//}
-(void)pushzx:(UIButton *)b{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    
    _segment=nil;
    scroll=nil;
    table1=nil;
    // UITableView *table2;
    // UITableView *table3;
    _dataarray=nil;
    _dc=nil;
    _postdic=nil;
    
    def=nil;

    self.BrandDynamicVC=nil;
    self.fashionVC=nil;
    self.videoVC=nil;
    self.activityZoneVC=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(BOOL)prefersStatusBarHidden{
    if (isHideStaueBar) {
        return YES;
    }else{
        return NO;
    }

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
