


/*!
 @header WMPlayer.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/24
 
 @version 1.00 16/1/24 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "WMPlayer.h"
#define WMVideoSrcName(file) [@"WMPlayer.bundle" stringByAppendingPathComponent:file]
#define WMVideoFrameworkSrcName(file) [@"Frameworks/WMPlayer.framework/WMPlayer.bundle" stringByAppendingPathComponent:file]


static void *PlayViewCMTimeValue = &PlayViewCMTimeValue;

static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;

@interface WMPlayer ()
@property (nonatomic,assign)CGPoint firstPoint;
@property (nonatomic,assign)CGPoint secondPoint;
@property (nonatomic, retain) NSTimer *durationTimer;
@property (nonatomic, retain) NSTimer *autoDismissTimer;
@property (nonatomic, retain)NSDateFormatter *dateFormatter;

@end


@implementation WMPlayer{
    UISlider *systemSlider;
    
}

-(AVPlayerItem *)getPlayItemWithURLString:(NSString *)urlString{
    if ([urlString containsString:@"http"]) {
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return playerItem;
    }else{
        AVAsset *movieAsset  = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:urlString] options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        return playerItem;
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        
        
        
        // 1创建playItem
        self.currentItem = [self getPlayItemWithURLString:videoURLStr];
        //2创建AVPlayer
        if (self.currentItem==nil) {
           
        }
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
        //AVPlayerLayer创建方式  把
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.layer.bounds;
        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        //3用 AVPlayer 时需要注意，AVPlayer 本身并不能显示视频， 显示视频的是 AVPlayerLayer。 AVPlayerLayer 继承自 CALayer，添加到 view.layer 上就可以使用了。
        [self.layer addSublayer:_playerLayer];
        
        //bottomView
        self.bottomView = [[UIView alloc]init];
        [self addSubview:self.bottomView];
        //autoLayout bottomView
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self).with.offset(0);
            
        }];
        [self setAutoresizesSubviews:NO];
        //_playOrPauseBtn   播放暂停按钮
        self.playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playOrPauseBtn.showsTouchWhenHighlighted = YES;
        [self.playOrPauseBtn addTarget:self action:@selector(PlayOrPause:) forControlEvents:UIControlEventTouchUpInside];
        [self.playOrPauseBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"pause")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"pause")] forState:UIControlStateNormal];
        [self.playOrPauseBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"play")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"play")] forState:UIControlStateSelected];
        [self.bottomView addSubview:self.playOrPauseBtn];
        //autoLayout _playOrPauseBtn
        [self.playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.bottomView).with.offset(0);
            make.width.mas_equalTo(40);
            
        }];
        
        
        
//        MPVolumeView *volumeView = [[MPVolumeView alloc]init];
//        [self addSubview:volumeView];
//        [volumeView sizeToFit];
//        
//        
//        systemSlider = [[UISlider alloc]init];
//        systemSlider.backgroundColor = [UIColor clearColor];
//        for (UIControl *view in volumeView.subviews) {
//            if ([view.superclass isSubclassOfClass:[UISlider class]]) {
//                NSLog(@"1");
//                systemSlider = (UISlider *)view;
//            }
//        }
//        systemSlider.autoresizesSubviews = NO;
//        systemSlider.autoresizingMask = UIViewAutoresizingNone;
//        [self addSubview:systemSlider];
//        systemSlider.hidden = YES;
//        
//        
//        
//        self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        self.volumeSlider.tag = 1000;
//        self.volumeSlider.hidden = YES;
//        self.volumeSlider.minimumValue = systemSlider.minimumValue;
//        self.volumeSlider.maximumValue = systemSlider.maximumValue;
//        self.volumeSlider.value = systemSlider.value;
//        [self.volumeSlider addTarget:self action:@selector(updateSystemVolumeValue:) forControlEvents:UIControlEventValueChanged];
//        [self addSubview:self.volumeSlider];
//        
        
        //slider
        self.progressSlider = [[UISlider alloc]init];
        self.progressSlider.minimumValue = 0.0;
        [self.progressSlider setThumbImage:[UIImage imageNamed:WMVideoSrcName(@"dot")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"dot")]  forState:UIControlStateNormal];
        self.progressSlider.minimumTrackTintColor = [UIColor greenColor];
        self.progressSlider.value = 0.0;//指定初始值
        [self.progressSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.progressSlider];
        
        //autoLayout slider
        [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).with.offset(45);
            make.right.equalTo(self.bottomView).with.offset(-45);
            make.height.mas_equalTo(40);
            make.top.equalTo(self.bottomView).with.offset(0);
        }];
        
        //_fullScreenBtn  控制全屏按钮
        self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fullScreenBtn.showsTouchWhenHighlighted = YES;
        [self.fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fullScreenBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"fullscreen")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"fullscreen")] forState:UIControlStateNormal];
        [self.fullScreenBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"nonfullscreen")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"nonfullscreen")] forState:UIControlStateSelected];
        [self.bottomView addSubview:self.fullScreenBtn];
        //autoLayout fullScreenBtn
        [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomView).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.bottomView).with.offset(0);
            make.width.mas_equalTo(40);
            
        }];
        
        
        //timeLabel  显示播放时间
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        [self.bottomView addSubview:self.timeLabel];
        //autoLayout timeLabel
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).with.offset(45);
            make.right.equalTo(self.bottomView).with.offset(-45);
            make.height.mas_equalTo(20);
            make.bottom.equalTo(self.bottomView).with.offset(0);
        }];
        
        [self bringSubviewToFront:self.bottomView];
        
        
        
        
        //关闭按钮 (小差号)
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.showsTouchWhenHighlighted = YES;
        [_closeBtn addTarget:self action:@selector(colseTheVideo:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"close")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"close")] forState:UIControlStateNormal];
        [_closeBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"close")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"close")] forState:UIControlStateSelected];
        _closeBtn.layer.cornerRadius = 30/2;
        [self addSubview:_closeBtn];
        
        
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).with.offset(5);
            make.height.mas_equalTo(30);
            make.top.equalTo(self).with.offset(5);
            make.width.mas_equalTo(30);
            
            
        }];
        // 单击的 Recognizer
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        singleTap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleTap];
        
        // 双击的 Recognizer
        UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap)];
        doubleTap.numberOfTapsRequired = 2; // 双击
        [self addGestureRecognizer:doubleTap];
          /*
           注册或取消注册作为观察者的价值相对于接收机的关键路径。选项决定什么是包含在观察者通知和发送时,如上所述,上下文是在观察者通过通知如上所述。您应该使用removeobserver:forKeyPath:背景:代替removeobserver:forKeyPath:只要有可能,因为它允许您更精确地指定您的意图。当同一观察者注册多次相同的关键路径,但在不同的上下文指针每次removeobserver:forKeyPath:必须猜测上下文指针在决定到底删除,也可以猜错了。
           观察status（播放状态）属性 观察者
           */
        [self.currentItem addObserver:self
                          forKeyPath:@"status"
                             options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                             context:PlayViewStatusObservationContext];
        [self initTimer];
        
        
    }
    return self;
}
- (void)updateSystemVolumeValue:(UISlider *)slider{
    systemSlider.value = slider.value;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}
#pragma mark
#pragma mark - fullScreenAction
-(void)fullScreenAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    //用通知的形式把点击全屏的时间发送到app的任何地方，方便处理其他逻辑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fullScreenBtnClickNotice" object:sender];
}
#pragma mark******** 关闭播放器
-(void)colseTheVideo:(UIButton *)sender{
    //播放器停止
    [self.player pause];
    //发送停止播放的通知 进行处理逻辑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeTheVideo" object:sender];
}
- (double)duration{
    AVPlayerItem *playerItem = self.player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else{
        return 0.f;
    }
}

- (double)currentTime{
    return CMTimeGetSeconds([[self player] currentTime]);
}

- (void)setCurrentTime:(double)time{
    [[self player] seekToTime:CMTimeMakeWithSeconds(time, 1)];
}
#pragma mark
#pragma mark - PlayOrPause 暂停或者开始
- (void)PlayOrPause:(UIButton *)sender{
    if (self.durationTimer==nil) {
        self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
    }
    sender.selected = !sender.selected;
    //@abstract显示所需的回放速度;0.0意味着“暂停”,1.0表示希望在当前项的自然率。
    
    /*
     率的值设置为0.0暂停播放,引起AVPlayerTimeControlStatusPaused timeControlStatus改变的价值。
     设置为非零值导致的价值timeControlStatus成为AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate或者AVPlayerTimeControlStatusPlaying,取决于足够的媒体数据缓冲播放发生和等待的玩家的默认行为是否为了减少拖延是允许的。看到的AVPlayerTimeControlStatus讨论更多的细节。
     AVPlayer可以重置所需的利率0.0在整体状态变化时需要停止播放,比如当一个中断发生在iOS,AVAudioSession宣布,或者当播放缓冲区为空和回放摊位automaticallyWaitsToMinimizeStalling是否定的。
     回放的有效利率可能不同于理想的速度即使timeControlStatus AVPlayerTimeControlStatusPlaying,如果使用的处理算法来管理音频音调需要量化的回放速度。率音频处理的量化信息,看到AVAudioProcessingSettings.h。你总是可以获得有效的回放currentItem的时基,看到AVPlayerItem的时基财产。
     */
    if (self.player.rate != 1.f) {
        if ([self currentTime] == [self duration])
            [self setCurrentTime:0.f];
        [self.player play];
    } else {
        [self.player pause];
        
        
        
    }
    
    //    CMTime time = [self.player currentTime];
}
#pragma mark
#pragma mark - 单击手势方法
- (void)handleSingleTap{
    [UIView animateWithDuration:0.5 animations:^{
        if (self.bottomView.alpha == 0.0) {
            self.bottomView.alpha = 1.0;
            self.closeBtn.alpha = 1.0;

        }else{
            self.bottomView.alpha = 0.0;
            self.closeBtn.alpha = 0.0;

        }
    } completion:^(BOOL finish){
        
    }];
}
#pragma mark
#pragma mark - 双击手势方法
- (void)handleDoubleTap{
    self.playOrPauseBtn.selected = !self.playOrPauseBtn.selected;
    if (self.player.rate != 1.f) {
        if ([self currentTime] == self.duration)
            [self setCurrentTime:0.f];
        [self.player play];
    } else {
        [self.player pause];
    }
}
#pragma mark - 设置播放的视频
- (void)setVideoURLStr:(NSString *)videoURLStr
{
    _videoURLStr = videoURLStr;
    
    if (self.currentItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
        [self.currentItem removeObserver:self forKeyPath:@"status"];

//        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
        self.currentItem = [self getPlayItemWithURLString:videoURLStr];
    
      
        
        
        [self.currentItem addObserver:self
                           forKeyPath:@"status"
                              options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                              context:PlayViewStatusObservationContext];
    [self.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:PlayViewStatusObservationContext];
    
    [self.currentItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:PlayViewStatusObservationContext];
    [self.currentItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:PlayViewStatusObservationContext];
        
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
    
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
    
}
#pragma mark******播放完成的监听
- (void)moviePlayDidEnd:(NSNotification *)notification {
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
       
        [weakSelf.progressSlider setValue:0.0 animated:YES];
        weakSelf.playOrPauseBtn.selected = NO;
    }];
}
#pragma mark - 播放进度
- (void)updateProgress:(UISlider *)slider{
    
    //使用此方法来寻求一个指定的时间为当前的球员。  seekToTime
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, 1)];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    /* AVPlayerItem "status" property value observer. */
    if (context == PlayViewStatusObservationContext)
    {
        if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (status)
        {
            case AVPlayerStatusUnknown:
            {
                
            }
                break;
                
            case AVPlayerStatusReadyToPlay:
            {
                
                /* 准备完毕 */
                if (CMTimeGetSeconds(self.player.currentItem.duration)) {
                    self.progressSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
                }
                
                [self initTimer];
                if (self.durationTimer==nil) {
                    self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
                }
                
                //5s dismiss bottomView
                if (self.autoDismissTimer==nil) {
                    self.autoDismissTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoDismissBottomView:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
                }
                
                
            }
                break;
                
            case AVPlayerStatusFailed:
            {
                
            }
                break;
        }
        }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
            //监听播放器的下载进度
            NSArray *loadedTimeRanges = [self.currentItem loadedTimeRanges];
            CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
            float startSeconds = CMTimeGetSeconds(timeRange.start);
            float durationSeconds = CMTimeGetSeconds(timeRange.duration);
            NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
            CMTime duration = self.currentItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            
        
        
        }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
        
            //监听播放器在缓冲数据的状态
            
            //NSLog(@"缓冲不足暂停了");
        
        }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
           // NSLog(@"缓冲达到可播放程度了");
            
            //由于 AVPlayer 缓存不足就会自动暂停，所以缓存充足了需要手动播放，才能继续播放
        
        }
            
            
    }
    
}
#pragma mark
#pragma mark finishedPlay
- (void)finishedPlay:(NSTimer *)timer{
    if (self.currentTime == self.duration&&self.player.rate==.0f) {
        self.playOrPauseBtn.selected = YES;
        //播放完成后的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedPlay" object:self.durationTimer];
        [self.durationTimer invalidate];
        self.durationTimer = nil;
    }
}
#pragma mark
#pragma mark autoDismissBottomView
-(void)autoDismissBottomView:(NSTimer *)timer{
    
    if (self.player.rate==.0f&&self.currentTime != self.duration) {//暂停状态
        //        if (self.bottomView.alpha == 0.0) {
        //
        //        }else{
        //            self.bottomView.alpha = 1.0;
        //        }
    }else if(self.player.rate==1.0f){
        if (self.bottomView.alpha==1.0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomView.alpha = 0.0;
                self.closeBtn.alpha = 0.0;

            } completion:^(BOOL finish){
                
            }];
        }
    }
}
#pragma  maik - 定时器
-(void)initTimer{
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        CGFloat width = CGRectGetWidth([self.progressSlider bounds]);
        interval = 0.5f * duration / width;
    }
   // NSLog(@"interva === %f",interval);
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)  queue:NULL /* If you pass NULL, the main queue is used. */ usingBlock:^(CMTime time){
        [self syncScrubber];
    }];
    
}
- (void)syncScrubber{
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)){
        self.progressSlider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)){
        float minValue = [self.progressSlider minimumValue];
        float maxValue = [self.progressSlider maximumValue];
        double time = CMTimeGetSeconds([self.player currentTime]);
        _timeLabel.text = [NSString stringWithFormat:@"%@/%@",[self convertTime:time],[self convertTime:duration]];
        
      
        [self.progressSlider setValue:(maxValue - minValue) * time / duration + minValue];
    }
}

- (CMTime)playerItemDuration{
    AVPlayerItem *playerItem = [self.player currentItem];
//    NSLog(@"%ld",playerItem.status);
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return([playerItem duration]);
    }
    
    return(kCMTimeInvalid);
}
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *newTime = [[self dateFormatter] stringFromDate:d];
    return newTime;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        self.firstPoint = [touch locationInView:self];
        
    }
    UISlider *volumeSlider = (UISlider *)[self viewWithTag:1000];
    volumeSlider.value = systemSlider.value;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        self.secondPoint = [touch locationInView:self];
    }
    systemSlider.value += (self.firstPoint.y - self.secondPoint.y)/500.0;
    UISlider *volumeSlider = (UISlider *)[self viewWithTag:1000];
    volumeSlider.value = systemSlider.value;
    self.firstPoint = self.secondPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.firstPoint = self.secondPoint = CGPointZero;
}
-(void)dealloc{
    [self.player pause];
    self.autoDismissTimer = nil;
    self.durationTimer = nil;
    self.player = nil;
    [self.currentItem removeObserver:self forKeyPath:@"status"];
}
#pragma mark********AVplayer 的方法
/*
 1.
 摘要创建一个AVPlayer,扮演一个视听产品。
 @param项
 @result AVPlayer的实例
 @discussion有用为了玩一个AVAsset曾被创建的项目。看到-[AVPlayerItem initWithAsset:]。
 
 + (instancetype)playerWithPlayerItem:(nullable AVPlayerItem *)item;
 2.
 @method initwithurl:
 @abstract初始化一个AVPlayer扮演一个视听资源引用的URL。
 @param url
 @result AVPlayer的实例
 @discussion隐式地创建一个AVPlayerItem。客户可以获得AVPlayerItem成为玩家的当前项目。
 * /
 -(instancetype)initWithURL:URL(NSURL *);
 
 3
 method initwithplayeritem:
 @abstract创建一个AVPlayer,扮演一个视听产品。
 @param项
 @result AVPlayer的实例
 @discussion有用为了玩一个AVAsset曾被创建的项目。看到-[AVPlayerItem initWithAsset:]。
 * /
 -(instancetype)initWithPlayerItem:(nullable AVPlayerItem *)项目;
 
 4
 @method playerwithurl:
 @abstract返回一个实例的AVPlayer扮演一个视听资源引用的URL。
 @param url
 @result AVPlayer的实例
 @discussion隐式地创建一个AVPlayerItem。客户可以获得AVPlayerItem成为玩家的当前项目。
 * /
 +(instancetype)playerWithURL:URL(NSURL *);
 
 5
 
 */


@end
