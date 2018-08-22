//
//  UGShareViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/5/10.
//

#import "UGShareViewController.h"
#import "UGHeader.h"
#import "BassAPI.h"
#import "UGShareButton.h"
#import "UIButton+UGBtnCategory.h"
@interface UGShareViewController ()
@property(nonatomic,strong)NSData *ShareData;
@property(nonatomic,strong)NSString *shareURL;
@end

@implementation UGShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UGColor(231, 231, 231);

    UILabel *titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30*KIphoneWH)];
    titleLable.text=@"分享给好友";
    titleLable.textAlignment=NSTextAlignmentCenter;
    titleLable.textColor=[UIColor blackColor];
    titleLable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:titleLable];
    NSArray *titleArr=@[ @"朋友圈",@"微信",@"QQ",@"微博"];
    NSArray*iamgearray=@[@"umsocial_wechat_timeline",@"umsocial_wechat.png",@"umsocial_qzone",@"umsocial_sina.png",];
    
    for (int i=0;i<titleArr.count;i++) {
        CGFloat imageW=self.view.frame.size.width;
        CGFloat btnw=(imageW-80*KIphoneWH)/4;
        //NSLog(@"高度%f",self.view.frame.size.height);
        
        UGShareButton *shreB=[[UGShareButton alloc] initWithFrame: CGRectMake(10*KIphoneWH+(btnw+20*KIphoneWH)*i, 60*KIphoneWH, btnw, btnw+20*KIphoneWH)];
        //shreB.backgroundColor=UGColor(231, 231, 231);
       // [shreB setTitle:titleArr[i] forState:UIControlStateNormal image:[UIImage imageNamed:THEMEShareSrcName([iamgearray objectAtIndex:i])]];
        shreB.tag=i;
        //[shreB.titleLabel setTitle:titleArr[i] forState:UIControlStateNormal];
        [shreB.titlelable setText:titleArr[i]];
        [shreB.iconView setImage:[UIImage imageNamed:THEMEShareSrcName([iamgearray objectAtIndex:i])]];
        [shreB addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shreB];
    }
    
    UIButton *closeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,HEIGHT-300*KIphoneWH-120*KIphoneWH, WIDTH, 40*KIphoneWH)];
    [closeBtn addTarget:self action:@selector(closeBclick) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.titleLabel.textColor=[UIColor blackColor];
    closeBtn.backgroundColor=[UIColor whiteColor];
    closeBtn.backgroundColor=UGColor(231, 231, 231);
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    closeBtn.titleLabel.textColor=[UIColor blackColor];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeGetShare];
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    NSDictionary *postdic=[Uikility initWithdatajson:dic];
    [AFManger postWithURLString:urlstr parameters:postdic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        Boolean sucess=[[object objectForKey:@"success"]boolValue];
        //NSLog(@"%@",object);
        if (sucess) {
            NSDictionary *datadic=[object objectForKey:@"data"];
            _shareURL =[datadic objectForKey:@"imgUrl"];
            NSString *  ImageUrl=[datadic objectForKey:@"img"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                _ShareData =[NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //NSLog(@"主线程");
                   // [self creatshareview];
                    //[self.navigationController popToRootViewControllerAnimated:YES];
                });
                //[self creatshareview];
            });
        }else{
            
        }
        
        
    } failure:^(NSError *error) {
       // NSLog(@"--------------");
    }];
}
-(void)shareClick:(UIButton *)bt{
//    if (_shareURL==nil) {
//        [SVProgressHUD showWithStatus:@"正在获取连接"];
//        [SVProgressHUD dismissWithDelay:1.0];
//    }
//    
//    
//    if (_ShareData==nil) {
//        [SVProgressHUD showWithStatus:@"正在获取图片"];
//        [SVProgressHUD dismissWithDelay:1.0];
//        return;
//    }else{
//         //[self.Delegate shareBtnClick:bt.tag shareImage:_ShareData shareUrl:_shareURL];
//        
//    }
    //NSString *urlstr=@"http://ugouchina.com//ugouApp/yhq.html";
    [self.Delegate shareBtnClick:bt.tag shareImage:nil shareUrl:nil];
  [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)closeBclick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
