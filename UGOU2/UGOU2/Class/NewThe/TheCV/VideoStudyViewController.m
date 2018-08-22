//
//  VideoStudyViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/3/30.
//
//

#import "VideoStudyViewController.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "Uikility.h"
#import "UIImageView+WebCache.h"
#import "VideoModel.h"
#import "VideoTableViewCell.h"
#import "WMPlayer.h"
#import "PlayVideoViewController.h"
#import "CenterModel.h"
#import "ThemeModel.h"
#import "MJRefresh.h"
#import "TheViewController.h"
@interface VideoStudyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UITableView *_tableview;
    NSMutableArray *_dataArray;
    NSUserDefaults *def;
    WMPlayer *_wmplayer;
   BOOL isSmallScreen;
  NSIndexPath *  currentIndexPath ;

}

@property(nonatomic,strong)VideoTableViewCell *currentCell;
@end

@implementation VideoStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册播放完成通知
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoDidFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知（播放完成发过来通知）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    //关闭通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeTheVideo:) name:@"closeTheVideo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDeviceOrientationChange:) name:@"onDeviceOrientationChange" object:nil];
    [self creatUI];
    [self afReadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //屏幕旋转通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDeviceOrientationChange:) name:@"onDeviceOrientationChange" object:nil];

}
-(void)creatUI{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40*KIphoneWH-113) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"video"];
    [self.view addSubview:_tableview];
    _tableview.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self afReadData];
        [_tableview.header endRefreshing];
    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 180*KIphoneWH;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_dataArray.count) {
        
        return _dataArray.count;
    }
       return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.playBtn.tag=indexPath.row;
    [cell.playBtn addTarget:self action:@selector(playOrPase:) forControlEvents:UIControlEventTouchUpInside];
    if (_dataArray.count) {
        ThemeModel *model=[_dataArray objectAtIndex:indexPath.row];
        [cell.iamgeView sd_setImageWithURL:[Uikility URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"uuu"]];
        cell.descriptionLable.text=model.intro;
    }
    if (_wmplayer&&_wmplayer.superview) {
        if (indexPath==currentIndexPath) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        
        }
        //显示的indexpath
        NSArray *indexpaths=[tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]) {
           //复用
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmplayer]) {
                _wmplayer.hidden = NO;
                
            }else{
                _wmplayer.hidden = YES;
                
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }

            
        }else{
            if ([cell.iamgeView.subviews containsObject:_wmplayer]) {
                [cell.iamgeView addSubview:_wmplayer];
                [_wmplayer.player play];
                _wmplayer.playOrPauseBtn.selected=NO;
                _wmplayer.hidden=NO;
            }
        
        
        
        
        }
        
    }
    
    return cell;

}
#pragma mark**********选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count) {
    
//        ThemeModel *themeModel=[_dataArray objectAtIndex:indexPath.row];
//       CenterModel *model=[[CenterModel alloc] init];
//    model.VCtype=3;
//    model.URLString=[Uikility VideoWithURLString:themeModel.img];
//        model.intero=themeModel.intro;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushcenter" object:model];
        
        
        currentIndexPath= indexPath;
        ThemeModel *themeModel=[_dataArray objectAtIndex:indexPath.row];
        
        CenterModel *model=[[CenterModel alloc] init];
        model.VCtype=3;
        model.URLString=[Uikility VideoWithURLString:themeModel.img];
        self.currentCell=(VideoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]        ;
        if (_wmplayer) {
            [_wmplayer removeFromSuperview];
            [_wmplayer setVideoURLStr:[Uikility VideoWithURLString:themeModel.img]];
            [_wmplayer.player  play];
        }else{
            _wmplayer=[[WMPlayer alloc] initWithFrame:self.currentCell.iamgeView.frame videoURLStr:[Uikility VideoWithURLString:themeModel.img]];
            [_wmplayer.player play];
        }
        [self.currentCell.iamgeView addSubview:_wmplayer];
        [self.currentCell.iamgeView bringSubviewToFront:_wmplayer];
        [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
        [_tableview reloadData];
        
        
        
        
    }
  
}
#pragma mark************请求数据
-(void)afReadData{
    def=[NSUserDefaults standardUserDefaults];
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeVideoList];
    NSMutableDictionary *urldic=[Uikility creatSinGoMutableDictionary];
    if ([def objectForKey:@"placename"]) {
         [urldic setObject:[def objectForKey:@"placename"] forKey:@"area"];
    }
   
    NSDictionary *postDic=[Uikility initWithdatajson:urldic];
    [AFManger postWithURLString:urlstr parameters:postDic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL sucess=[[object objectForKey:@"success"] boolValue];
        //NSLog(@"%@",object);
        if (sucess) {
            
            _dataArray=[[NSMutableArray alloc] init];
            NSArray *data=[object objectForKey:@"data"];
            for (NSDictionary *dic in data) {
                [_dataArray addObject:[ThemeModel initWithModeldic:dic]];
            }
            [_tableview reloadData];
        }else{
        
        }
        
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网速不佳"];
    }];

}
#pragma mark*********点击播放视频
-(void)playOrPase:(UIButton *)playBtn{
    if (_dataArray.count) {
       currentIndexPath= [NSIndexPath indexPathForRow:playBtn.tag inSection:0];
        ThemeModel *themeModel=[_dataArray objectAtIndex:playBtn.tag];
        
        CenterModel *model=[[CenterModel alloc] init];
        model.VCtype=3;
        model.URLString=[Uikility VideoWithURLString:themeModel.img];
        self.currentCell=(VideoTableViewCell *)playBtn.superview.superview.superview
        ;
        if (_wmplayer) {
            [_wmplayer removeFromSuperview];
            [_wmplayer setVideoURLStr:[Uikility VideoWithURLString:themeModel.img]];
            [_wmplayer.player  play];
        }else{
            _wmplayer=[[WMPlayer alloc] initWithFrame:self.currentCell.iamgeView.frame videoURLStr:[Uikility VideoWithURLString:themeModel.img]];
            [_wmplayer.player play];
        }
        [self.currentCell.iamgeView addSubview:_wmplayer];
        [self.currentCell.iamgeView bringSubviewToFront:_wmplayer];
        [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
        [_tableview reloadData];
        
   // model.intero=themeModel.intro;
   //        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushcenter" object:model];
    }

}
#pragma mark********屏幕旋转通知
-(void)onDeviceOrientationChange:(NSNotification *)notifi{
    if (_wmplayer==nil||_wmplayer.superview==nil) {
        return;
    }
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    
    
        //NSLog(@"通知发过来了通知发过来");
    
    TheViewController *tvc=[notifi object];
    
    UIInterfaceOrientation interfaceOrientation=tvc.interfaceOrientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            //NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            //NSLog(@"第0个旋转方向---电池栏在上");
            if (_wmplayer.isFullscreen) {
//                if (isSmallScreen) {
//                    //放widow上,小屏显示
//                    [self toSmallScreen];
//                }else{
                    [self toCell];
                //}
                
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            //NSLog(@"第2个旋转方向---电池栏在左");
            if (_wmplayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            //NSLog(@"第1个旋转方向---电池栏在右");
            if (_wmplayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        default:
            break;
    }

}
#pragma mark********播放完成
-(void)videoDidFinish:(NSNotification *)notifi{
    VideoTableViewCell *currentCell = (VideoTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    //[self toCell];
    [_wmplayer removeFromSuperview];


}
#pragma mark********放在cell上面
-(void)toCell{
    VideoTableViewCell *currentCell = [self currentCell];
    
    [_wmplayer removeFromSuperview];
   
    [UIView animateWithDuration:0.5f animations:^{
        _wmplayer.transform = CGAffineTransformIdentity;
        _wmplayer.frame = currentCell.iamgeView.bounds;
        _wmplayer.playerLayer.frame =  _wmplayer.bounds;
        [currentCell.iamgeView addSubview:_wmplayer];
        [currentCell.iamgeView bringSubviewToFront:_wmplayer];
        [_wmplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(0);
            make.right.equalTo(_wmplayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmplayer).with.offset(0);
            
        }];
        
        [_wmplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_wmplayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmplayer).with.offset(5);
            
        }];
        
        
    }completion:^(BOOL finished) {
        _wmplayer.isFullscreen = NO;
        isSmallScreen = NO;
        _wmplayer.fullScreenBtn.selected = NO;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"isHideStaueBar" object:_wmplayer];
        [_Delegate prefersVideoStatusBarHidden:_wmplayer.isFullscreen];
    }];


}
#pragma mark*********恢复小屏
-(void)toSmallScreen{
    
    
    _currentCell = (VideoTableViewCell *)[_tableview   cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [_wmplayer removeFromSuperview];
    
    [UIView animateWithDuration:0.5f animations:^{
        _wmplayer.transform = CGAffineTransformIdentity;
        _wmplayer.frame = CGRectMake(0,0, WIDTH, 180*KIphoneWH);
        _wmplayer.playerLayer.frame =  _wmplayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:_wmplayer];
        
        [_wmplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(0);
            make.right.equalTo(_wmplayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmplayer).with.offset(0);
        }];
        
        [_wmplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(10);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmplayer).with.offset(10);
            
        }];

    } completion:^(BOOL finished) {
        _wmplayer.isFullscreen=NO;
        _wmplayer.fullScreenBtn.selected=NO;
        isSmallScreen = YES;
        //[[UIApplication sharedApplication].keyWindow bringSubviewToFront:_wmplayer];
        [_currentCell.iamgeView addSubview:_wmplayer];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"isHideStaueBar" object:_wmplayer];
    }];
}
#pragma mark********全屏通知
-(void)fullScreenBtnClick:(NSNotification*)notifi{
    UIButton *fullScreenBtn=(UIButton *)[notifi object];
    if (fullScreenBtn.selected) {
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
    
        [self toCell];
    }

}
#pragma mark*********全屏操作
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    _wmplayer.isFullscreen = YES;
    //[self prefersStatusBarHidden];
    [_wmplayer removeFromSuperview];
    //旋转
    _wmplayer.transform=CGAffineTransformIdentity;
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
    _wmplayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
            }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
            _wmplayer.transform = CGAffineTransformMakeRotation(M_PI_2);}
    _wmplayer.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    _wmplayer.playerLayer.frame =  CGRectMake(0,0, HEIGHT,WIDTH);
    
    [_wmplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(WIDTH-40);
        make.width.mas_equalTo(HEIGHT);
        make.bottom.mas_equalTo(0);
    }];
    
    [_wmplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wmplayer).with.offset((-HEIGHT/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_wmplayer).with.offset(10);
        
    }];
    
    _wmplayer.closeBtn.hidden=NO;
    
    //添加播放器
    [[UIApplication sharedApplication].keyWindow addSubview:_wmplayer];
    //已经是全屏
    _wmplayer.isFullscreen = YES;
    _wmplayer.fullScreenBtn.selected = YES;
    //调整到最上面
    [_wmplayer bringSubviewToFront:_wmplayer.bottomView];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"isHideStaueBar" object:_wmplayer];
    
    
    [_Delegate prefersVideoStatusBarHidden:_wmplayer.isFullscreen];
    //[_Delegate changeStatusBarHidden:_wmplayer.isFullscreen];
    
    //[self prefersStatusBarHidden];



}
#pragma mark*******关闭播放器
-(void)closeTheVideo:(NSNotification *)notifi{
    VideoTableViewCell *videocell=(VideoTableViewCell*)[_tableview cellForRowAtIndexPath:currentIndexPath];
    [videocell.playBtn.superview bringSubviewToFront:videocell.playBtn];
    [_Delegate prefersVideoStatusBarHidden:NO];
    [self releaseWMPlayer];


}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if(scrollView ==_tableview){
        if (_wmplayer==nil) {
            return;
        }

//        if (_wmplayer.superview) {
//            CGRect rectInTableView = [_tableview rectForRowAtIndexPath:currentIndexPath];
//            NSString *ssss=NSStringFromCGRect(rectInTableView);
//            
//            CGRect rectInSuperview = [_tableview convertRect:rectInTableView toView:[_tableview superview]];
//            NSLog(@"rectInSuperview = %@",NSStringFromCGRect(rectInSuperview));
//            
//            if (rectInSuperview.origin.y<-self.currentCell.iamgeView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height-HEIGHT-64) {//往上拖动
//                [self releaseWMPlayer];
//                [self.currentCell.playBtn.superview bringSubviewToFront:self.currentCell.playBtn];
//            }
//        }
//
        
        NSArray* indexpaths=[_tableview indexPathsForVisibleRows];
        VideoTableViewCell *cell=[_tableview cellForRowAtIndexPath:currentIndexPath];
        
        if (![indexpaths containsObject:currentIndexPath]) {
            //复用
//            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmplayer]) {
                [self releaseWMPlayer];
                
//            }else{
//                _wmplayer.hidden = YES;
//                
//                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
//            }
            
            
        }else{
            if ([cell.iamgeView.subviews containsObject:_wmplayer]) {
                [cell.iamgeView addSubview:_wmplayer];
                [_wmplayer.player play];
                _wmplayer.playOrPauseBtn.selected=NO;
                _wmplayer.hidden=NO;
            }
            
            
            
            
        }

        
    }



}


-(void)dealloc{
  _tableview=nil;
   _dataArray=nil;
    def=nil;
    _wmplayer=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];

}
-(void)releaseWMPlayer{
    [_wmplayer.player.currentItem cancelPendingSeeks];
    [_wmplayer.player.currentItem.asset cancelLoading];
    [_wmplayer.player pause];
    [_wmplayer removeFromSuperview];
    [_wmplayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmplayer.player=nil;
    //_wmplayer.currentItem=nil;
    _wmplayer.playOrPauseBtn=nil;
    _wmplayer.playerLayer=nil;
    _wmplayer=nil;
    currentIndexPath=nil;

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
