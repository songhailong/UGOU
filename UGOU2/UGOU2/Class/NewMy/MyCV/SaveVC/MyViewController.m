//
//  MyViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*xujing2015.10.22.3.20 我的
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "MyViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "XgViewController.h"
#import "SZViewController.h"
#import "SSViewController.h"
#import "DgViewController.h"
#import "TkViewController.h"
#import "BindMobileViewController.h"
#import "SFViewController.h"
#import "UIImageView+WebCache.h"
#import "UbViewController.h"
#import "Uikility.h"
#import "FootprintsViewController.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "MKjViewController.h"
#import "ShangmenViewController.h"
#import "LoginViewController.h"
#import "GTMBase64.h"
#import "VipselectViewController.h"
#import "LocateFailureView.h"
#import "UITabBar+Category.h"
#import "PushMessageViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>{
  
     UILabel*namelabel;
     NSUserDefaults *de;
    LocateFailureView *_locateFailreView;
    
}

@end

@implementation MyViewController
#pragma mark 2015.10.28.9.30 头像 昵称 可能更改
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"placename"]) {
        [self addtable];
    }else{
        [self creatfailView];
    }

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSucess:) name:@"locationSucess" object:nil];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
}
-(void)locationSucess:(NSNotification *)notifi{
    _locateFailreView.alpha=0;
    
    
    [self addtable];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    //[self.tabBarController.tabBar showBadgeOnItemIdex:3];
    de=[NSUserDefaults standardUserDefaults];
    if ([de objectForKey:@"placename"]) {
        [self addtable];
    }else{
        [self creatfailView];
    }
    
    
}
-(void)creatfailView{
    _locateFailreView=[[LocateFailureView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-40)];
    [self.view addSubview:_locateFailreView];

}
#pragma mark 加tableview
-(void)addtable{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _table.delegate=self;
    _table.dataSource=self;
    [self addhead];
    _table.tableHeaderView=_headview;
    [self.view addSubview:_table];
    
    UIView *viewsss=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    viewsss.backgroundColor=[UIColor redColor];
    //[self.view addSubview:viewsss];
    
}
#pragma mark 头部
-(void)addhead{
    _headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 220*KIphoneWH)];
   
    _headview.backgroundColor=[UIColor whiteColor];
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 170*KIphoneWH)];
    if (iPhoneX) {
        _headview.frame=CGRectMake(0, 0, WIDTH, 220*KIphoneWH+24);
        imv.frame=CGRectMake(0, 0, WIDTH, 170*KIphoneWH+24);
    }
    imv.image=[UIImage imageNamed:@"图层-15@2x"];
    //设置 uiimageview 响应用户交互
    imv.userInteractionEnabled = YES;
    [_headview addSubview:imv];
     de = [NSUserDefaults standardUserDefaults];
    #pragma mark 登录注册 界面
    if ([de objectForKey:@"userId"]==nil) {
    UIImageView *drimv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-60*KIphoneWH, 50*KIphoneWH, 120*KIphoneWH, 50*KIphoneWH)];
    drimv.image=[UIImage imageNamed:@"登录注册底框@2x"];
    drimv.userInteractionEnabled = YES;
    [imv addSubview:drimv];
    UIButton *logbut=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, 40*KIphoneWH, 40*KIphoneWH)];
    [logbut setTitle:@"登录" forState:UIControlStateNormal];
        logbut.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [logbut setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    logbut.tag=1;
    [logbut addTarget:self action:@selector(pushlog:) forControlEvents:UIControlEventTouchUpInside];
    [drimv addSubview:logbut];
    UIImageView *ximv=[[UIImageView alloc]initWithFrame:CGRectMake(60*KIphoneWH, 4*KIphoneWH, 1*KIphoneWH, 40*KIphoneWH)];
    ximv.image=[UIImage imageNamed:@"登陆注册中线@2x"];
    [drimv addSubview:ximv];
    UIButton *rebut=[[UIButton alloc]initWithFrame:CGRectMake(70*KIphoneWH, 5*KIphoneWH, 40*KIphoneWH, 40*KIphoneWH)];
    [rebut setTitle:@"注册" forState:UIControlStateNormal];
        rebut.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [rebut setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    rebut.tag=2;
    [rebut addTarget:self action:@selector(pushlog:) forControlEvents:UIControlEventTouchUpInside];
    [drimv addSubview:rebut];
//        if (iPhoneX) {
//            drimv.frame=CGRectMake(WIDTH/2-60*KIphoneWH, 50*KIphoneWH+24, 120*KIphoneWH, 50*KIphoneWH);
//        }
    }else{
        #pragma mark 头像 昵称界面
        _headimg=[[UIImageView alloc]initWithFrame:CGRectMake(20*KIphoneWH, 30*KIphoneWH, 80*KIphoneWH, 80*KIphoneWH)];
        _headimg.userInteractionEnabled=YES;
        UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushxg)];
        [_headimg addGestureRecognizer:imgtap];
        _headimg.layer.cornerRadius=40*KIphoneWH;
        _headimg.clipsToBounds=YES;
        [imv addSubview:_headimg];
        namelabel=[[UILabel alloc]initWithFrame:CGRectMake(110*KIphoneWH, 50*KIphoneWH, WIDTH-170*KIphoneWH, 40*KIphoneWH)];
        namelabel.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        
      //http://localhost:80/ugouApp/headImg/1683_1499506620531.jpg
      //http://localhost:80/ugouApp/headImg/1683_1499506620531.jpg
        [imv addSubview:namelabel];
      
        if ([de objectForKey:@"headimg"]==nil) {
            _headimg.image=[UIImage imageNamed:@"头像底圈"];
        }else{
          
            if ([[de objectForKey:@"headimgbase"] isEqual:@"base"]) {
                NSData *_decodedImageData =[GTMBase64 decodeString:[de objectForKey:@"headimg"]];
                UIImage *Image= [UIImage imageWithData:_decodedImageData];
                _headimg.image=Image;
            }else{
                NSLog(@"加载头像");
                [_headimg sd_setImageWithURL:[Uikility URLWithString:[de objectForKey:@"headimg"]]];
            }
        }

        if ([de objectForKey:@"username"]==nil) {
             //_headimg.image=[UIImage imageNamed:@"头像底圈"];
            namelabel.text=@"无";
        }else{
            namelabel.text=[de objectForKey:@"username"] ;
        }

   }
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 50*KIphoneWH, 50*KIphoneWH, 40*KIphoneWH)];
    [but setImage:[UIImage imageNamed:@"设置@2x"] forState:UIControlStateNormal];
    but.tag=3;
    [but addTarget:self action:@selector(pushlog:) forControlEvents:UIControlEventTouchUpInside];
    [imv addSubview:but];
    if (iPhoneX) {
        _headimg.frame=CGRectMake(20*KIphoneWH, 30*KIphoneWH+24, 80*KIphoneWH, 80*KIphoneWH);
        namelabel.frame=CGRectMake(110*KIphoneWH, 50*KIphoneWH+24, WIDTH-170*KIphoneWH, 40*KIphoneWH);
        but.frame=CGRectMake(WIDTH-60*KIphoneWH, 50*KIphoneWH+24, 50*KIphoneWH, 40*KIphoneWH);
    }
    NSArray *arr=@[@"收藏的商品",@"收藏的品牌",@"历史足迹"];
    for (int i=0; i<3; i++) {

        if (i<2) {
            UIImageView *ximvs=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*(WIDTH-20*KIphoneWH)/3-3*KIphoneWH+5*KIphoneWH, 115*KIphoneWH, 1*KIphoneWH, 40*KIphoneWH)];
            ximvs.image=[UIImage imageNamed:@"登陆注册中线@2x"];
            [imv addSubview:ximvs];
            if (iPhoneX) {
                ximvs.frame=CGRectMake((i+1)*(WIDTH-20*KIphoneWH)/3-3*KIphoneWH+5*KIphoneWH, 115*KIphoneWH+24, 1*KIphoneWH, 40*KIphoneWH);
            }
        }
        
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(i*(WIDTH-20*KIphoneWH)/3+5*KIphoneWH, 120*KIphoneWH, (WIDTH-20*KIphoneWH)/3, 40*KIphoneWH)];
        [but setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [but setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [imv addSubview:but];
        but.tag=i+1;
        [but addTarget:self action:@selector(pushss:) forControlEvents:UIControlEventTouchUpInside];
        if (iPhoneX) {
            but.frame=CGRectMake(i*(WIDTH-20*KIphoneWH)/3+5*KIphoneWH, 120*KIphoneWH+24, (WIDTH-20*KIphoneWH)/3, 40*KIphoneWH);
        }
    }
    NSArray *array=@[@"已付款",@"待收货",@"待评论",@"退款-售后"];
   
    for (int i=0; i<array.count; i++) {
        UIButton *buts1=[[UIButton alloc]initWithFrame:CGRectMake(i*(WIDTH-20*KIphoneWH)/4, 200*KIphoneWH, (WIDTH-20*KIphoneWH)/4, 20*KIphoneWH)];
        [buts1 setTitle:array[i] forState:UIControlStateNormal];
        buts1.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
        [buts1 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        
        [_headview addSubview:buts1];
        buts1.tag=i+1;
        [buts1 addTarget:self action:@selector(pushdai:) forControlEvents:UIControlEventTouchUpInside];

        UIButton *buts=[[UIButton alloc]initWithFrame:CGRectMake(i*(WIDTH-20*KIphoneWH)/4, 170*KIphoneWH, (WIDTH-20*KIphoneWH)/4, 30*KIphoneWH)];
        [buts setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@@2x",[array objectAtIndex:i]]] forState:UIControlStateNormal];
        [_headview addSubview:buts];
        buts.tag=i+1;
        [buts addTarget:self action:@selector(pushdai:) forControlEvents:UIControlEventTouchUpInside];
        //buts.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
        if (iPhoneX) {
            buts.frame=CGRectMake(i*(WIDTH-20*KIphoneWH)/4, 170*KIphoneWH+24, (WIDTH-20*KIphoneWH)/4, 30*KIphoneWH);
            buts1.frame=CGRectMake(i*(WIDTH-20*KIphoneWH)/4, 200*KIphoneWH+24, (WIDTH-20*KIphoneWH)/4, 20*KIphoneWH);
        }
    }
    
}

#pragma mark 登录 注册 设置
-(void)pushlog:(UIButton *)b{
    if (b.tag==1) {
        LoginViewController *log=[[LoginViewController alloc]init];
        //BindMobileViewController *log=[[BindMobileViewController alloc] init];
        [self.navigationController pushViewController:log animated:YES];
        //[self presentViewController:log animated:YES completion:nil];
        
    }else if (b.tag==2){
        RegisterViewController *re=[[RegisterViewController alloc]init];
        [self.navigationController pushViewController:re animated:YES];
    }else if (b.tag==3){
        //要改
        SZViewController *log=[[SZViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
     

    }
}
#pragma mark 收藏界面
-(void)pushss:(UIButton *)b{
    if ([de objectForKey:@"userId"]) {
        if (b.tag==3) {
        FootprintsViewController *st=[[FootprintsViewController alloc] init];
        [self.navigationController pushViewController:st animated:YES];
            
        }else{
            
            SSViewController *ss=[[SSViewController alloc]init];
            ss.flage=(int)b.tag;
            [self.navigationController pushViewController:ss animated:YES];
        }

    }else{
        LoginViewController *log=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:log animated:YES];
    }
}




#pragma mark 订单
-(void)pushdai:(UIButton *)b{
    
    if ([de objectForKey:@"userId"]) {
    if (b.tag==4) {
        TkViewController *tk=[[TkViewController alloc]init];
       [self.navigationController pushViewController:tk animated:YES];
    }else{
    DgViewController *dg=[[DgViewController alloc]init];
    dg.flags=(int)b.tag;
    dg.flag=1;
    dg.indexflag=1;
    [self.navigationController pushViewController:dg animated:YES];
    }
    }else{
        //[Uikility alert:@"请先登录"];
        LoginViewController *log=[[LoginViewController alloc] init];
        [self.navigationController pushViewController: log animated:YES];
        
    }
}
#pragma mark 修改资料
-(void)pushxg{
      if ([de objectForKey:@"userId"]) {
    
    XgViewController *xg=[[XgViewController alloc]init];
    [self.navigationController pushViewController:xg animated:YES];
}else{
    //[Uikility alert:@"请先登录"];
    LoginViewController *log=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
  }
}


#pragma mark 2015.10.23.9.5 tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else if(section==1){
        return 4;
    }else{
    
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenxtifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenxtifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenxtifier];
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"上门试衣订单";
            cell.imageView.image=[UIImage imageNamed:@"上门试衣1@2x"];
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"到店预订订单";
            cell.imageView.image=[UIImage imageNamed:@"到店预订@2x"];
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"普通订单";
            cell.imageView.image=[UIImage imageNamed:@"普通订单@2x"];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"我的U币";
            cell.imageView.image=[UIImage imageNamed:@"u@2x"];
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"我的卡券";
            cell.imageView.image=[UIImage imageNamed:@"我的卡券@2x"];
        }
        if(indexPath.row==2){
          cell.textLabel.text=@"会员中心";
        cell.imageView.image=[UIImage imageNamed:@"main_vip_p"];
        }
        if (indexPath.row==3) {
            cell.textLabel.text=@"推送消息";
            cell.imageView.image=[UIImage imageNamed:@"推送消息"];
            BOOL isshow=[de boolForKey:@"isshowredicon"];
            if (isshow) {
                UIView *bageView=[[UIView alloc] init];
                bageView.tag=1888;
                bageView.layer.cornerRadius=4;
                bageView.backgroundColor=[UIColor redColor];
                CGRect tabframe=cell.imageView.frame;
                float percentX = 0.8 ;
                CGFloat x = 18*KIphoneWH;
                CGFloat y = 0;
                bageView.frame = CGRectMake(x, y, 8, 8);
                [cell.imageView addSubview:bageView];
            
            }else{
                
            }
        }
        
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"使用帮助";
            cell.imageView.image=[UIImage imageNamed:@"使用帮助@2x"];
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"反馈信息";
            cell.imageView.image=[UIImage imageNamed:@"反馈信息@2x"];
        }
    }
    return cell;
}
#pragma mark 点击 订单 等
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    if ([de objectForKey:@"userId"]) {
    DgViewController *dg=[[DgViewController alloc]init];
        dg.view.backgroundColor=[UIColor whiteColor];
    if (indexPath.row==0) {
        //dg.flag=3;
        
        ShangmenViewController *shang=[[ShangmenViewController alloc] init];
        shang.flag=3;
        shang.flags=0;
        
        shang.indexflag=1;
        shang.view.backgroundColor=[UIColor whiteColor];
        [self.navigationController pushViewController:shang animated:YES];
        
        
    }else if (indexPath.row==1){
        dg.flag=2;
        dg.indexflag=1;
        dg.flags=0;
        [self.navigationController pushViewController:dg animated:YES];

    }else if (indexPath.row==2){
        dg.flag=1;
        dg.indexflag=1;
        dg.flags=0;
        [self.navigationController pushViewController:dg animated:YES];

        
    }
        }else{
       // [Uikility alert:@"请先登录！"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
    }
     
    }else if (indexPath.section==1){
        
        if ([de objectForKey:@"userId"]) {
        
        if (indexPath.row==0) {
            #pragma mark U币
    
            UbViewController *ub=[[UbViewController alloc]init];
            [self.navigationController pushViewController:ub animated:YES];
           
        }else if (indexPath.row==1){
            #pragma mark 卡券
         
                //新界面
            
                
                MKjViewController *kj=[[MKjViewController alloc]init];
                [self.navigationController pushViewController:kj animated:YES];
           
        }else if (indexPath.row==2){
        
            VipselectViewController *vipvc=[[VipselectViewController alloc] init];
            [self.navigationController pushViewController:vipvc animated:YES];
        
        
        }else if (indexPath.row==3){
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            for (UIView *subView in cell.imageView.subviews) {
                
                if (subView.tag == 1888) {
                  
                    [subView removeFromSuperview];
                    [de setBool:NO forKey:@"isshowredicon"];
                }
            }
            
            PushMessageViewController *pushvc=[[PushMessageViewController alloc] init];
            [self.navigationController pushViewController:pushvc animated:YES];
            
        }
        }else{
           // [Uikility alert:@"请先登录！"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
            
        }
    }else if (indexPath.section==2){
            #pragma mark 使用帮助
        
        if (indexPath.row==0) {
            
            SFViewController *sf=[[SFViewController alloc]init];
            sf.flag=1;
             [self.navigationController pushViewController:sf animated:YES];
        }else if (indexPath.row==1){
            #pragma mark 反馈内容
            if ([de objectForKey:@"userId"]) {
            SFViewController *sf=[[SFViewController alloc]init];
            
            sf.flag=2;
                 [self.navigationController pushViewController:sf animated:YES];
        }else{
            //[Uikility alert:@"请先登录！"];
            LoginViewController *log=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:log animated:YES];
        }
        }
       
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
