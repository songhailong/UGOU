//
//  PlayVideoViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/4/5.
//
//

#import "PlayVideoViewController.h"
#import "WMPlayer.h"
#import "Masonry.h"
#import "Uikility.h"
#import "TheViewController.h"
@interface PlayVideoViewController (){
    //WMPlayer *wmPlayer;
   CGRect playerFrame;
    UIImageView *_imageview;
}
@property(nonatomic,strong)WMPlayer *wmPlayer;
@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeTheVideo:) name:@"closeTheVideo" object:nil];
    playerFrame = CGRectMake(0, 64, self.view.frame.size.width, (self.view.frame.size.width)*3/5);
    self.wmPlayer=[[WMPlayer alloc] initWithFrame:playerFrame videoURLStr:self.URLString];
    _wmPlayer.closeBtn.hidden=YES;
    [self.view addSubview:self.wmPlayer];
   [self.wmPlayer.player play];
     [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
     [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self creatNaviget];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange)name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)creatNaviget{
     
    self.navigationController.navigationBar.hidden=YES;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40, 20, 100, 50)];
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
    _imageview.image=image;
    //_imageview.backgroundColor=[UIColor greenColor];
    
    _imageview.userInteractionEnabled=YES;
    label.textColor=[UIColor whiteColor];
    label.text=self.intro;
    label.font=[UIFont systemFontOfSize:20];
    [_imageview addSubview:label];
    
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 64 )];
    
    UIImage *img=[UIImage imageNamed:@"返回o"];
    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
    [leftButton addSubview:imgv];
    imgv.frame=CGRectMake(15, 35, 10, 14);
    
    [leftButton addTarget:self action:@selector(pushpop:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_imageview];
    [self.view addSubview:leftButton];



}
-(void)pushpop:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark***********全屏通知
-(void)fullScreenBtnClick:(NSNotification *)notifi{
    UIButton *fullSreenBtn=(UIButton *)[notifi object];
    if (fullSreenBtn.isSelected) {
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
    
        [self toNormal];
    
    }

}
#pragma mark*********恢复正常
-(void)toNormal{
    
     _wmPlayer.isFullscreen = NO;
    _wmPlayer.closeBtn.hidden=YES;
    [self prefersStatusBarHidden];
    [_wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        _wmPlayer.transform = CGAffineTransformIdentity;
        _wmPlayer.frame =CGRectMake(playerFrame.origin.x, playerFrame.origin.y, playerFrame.size.width, playerFrame.size.height);
        _wmPlayer.playerLayer.frame =  _wmPlayer.bounds;
        [self.view addSubview:_wmPlayer];
        [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(0);
            make.right.equalTo(_wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmPlayer).with.offset(0);
        }];
        [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmPlayer).with.offset(5);
        }];
        
    }completion:^(BOOL finished) {
        _wmPlayer.isFullscreen = NO;
        _wmPlayer.fullScreenBtn.selected = NO;
        [self prefersStatusBarHidden];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
    }];



}
#pragma mark******全屏
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
   
    _wmPlayer.isFullscreen = YES;
    //[self prefersStatusBarHidden];
    [_wmPlayer removeFromSuperview];
    //旋转
    _wmPlayer.transform=CGAffineTransformIdentity;
     [[UIApplication sharedApplication]setStatusBarHidden:YES];
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        _wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        _wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    _wmPlayer.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
    [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(self.view.frame.size.height);
    }];
    
    [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wmPlayer).with.offset((-self.view.frame.size.height/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_wmPlayer).with.offset(5);
        
    }];

    _wmPlayer.closeBtn.hidden=NO;
    
    //添加播放器
    [[UIApplication sharedApplication].keyWindow addSubview:_wmPlayer];
    //已经是全屏
    _wmPlayer.isFullscreen = YES;
    _wmPlayer.fullScreenBtn.selected = YES;
    //调整到最上面
    [_wmPlayer bringSubviewToFront:_wmPlayer.bottomView];
    //[self prefersStatusBarHidden];
}
#pragma mark******屏幕旋转
-(void)onDeviceOrientationChange{
    if (_wmPlayer==nil||_wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation=[UIDevice currentDevice].orientation;
   
   UIInterfaceOrientation interfaceOrientation=(UIInterfaceOrientation)orientation;
     //TheViewController *  theVc=[notofi object];
    //U//IInterfaceOrientation interfaceOrientation=theVc.interfaceOrientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
           // NSLog(@"第0个旋转方向---电池栏在上");
            if (_wmPlayer.isFullscreen) {
                [self toNormal];
            }
        
        }
        break;
        case UIInterfaceOrientationLandscapeLeft:{
            //NSLog(@"第0个旋转方向---电池栏在上");
            if (_wmPlayer.isFullscreen==NO) {
                 [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
           // NSLog(@"第1个旋转方向---电池栏在右");
            if (_wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
  
        default:
            break;
    }


}
#pragma mark**********关闭播放器
-(void)closeTheVideo:(NSNotification *)notifi{
    
    [_wmPlayer.player play];
    [self toNormal];
        
}
-(void)releaseWMPlayer{
    [_wmPlayer.player.currentItem cancelPendingSeeks];
    [_wmPlayer.player.currentItem.asset cancelLoading];
    
    [_wmPlayer.player pause];
    [_wmPlayer removeFromSuperview];
    [_wmPlayer.playerLayer removeFromSuperlayer];
    [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmPlayer = nil;
    _wmPlayer.player = nil;
    _wmPlayer.currentItem = nil;
    
    _wmPlayer.playOrPauseBtn = nil;
    _wmPlayer.playerLayer = nil;
}

-(void)dealloc{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(BOOL )prefersStatusBarHidden{
    if (_wmPlayer.isFullscreen) {
        return YES;
    }else{
        return NO;
    
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
