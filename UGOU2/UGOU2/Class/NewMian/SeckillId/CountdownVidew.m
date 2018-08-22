//
//  CountdownVidew.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/14.
//

#import "CountdownVidew.h"
#import "UGHeader.h"
#import "NSTimer+UG_BlockSupport.h"
#import "HWWeakTimer.h"
@interface CountdownVidew()
///**时*/
//@property(nonatomic,strong)UILabel *WhenLable;
///**分*/
//@property(nonatomic,strong)UILabel *pointsLable;
///**秒*/


//@property(nonatomic,strong)UILabel *textOneLable;
//@property(nonatomic,strong)UILabel *textTwoLable;
@property(nonatomic,weak)NSTimer *timer;
@end
@implementation CountdownVidew

-(instancetype)initWithFrame:(CGRect)frame{
   self= [super initWithFrame:frame];
    if (self) {
        //[self creatUI];
    }
    return self;
}

-(void)setTime:(long)time{
    
    _time=time;
    long nowtime=[Uikility readnowtime];
  [[NSNotificationCenter defaultCenter] postNotificationName:SecondskillEndNotifi object:nil];
    if (time>nowtime) {
        
        NSDateComponents * datecom1=[self CalculationTimeDifferenceWithtime:time];
        //NSInteger allDay=datecom.month*
        NSInteger allhour=datecom1.day*24+datecom1.hour;
        if (allhour>99)
        {
            self.timeLableFont=[UIFont systemFontOfSize:10*KIphoneWH];
        }
        if (allhour<10)
        {
            self.WhenLable.text=[NSString stringWithFormat:@"0%zd",allhour];
        }else
        {
            self.WhenLable.text=[NSString stringWithFormat:@"%zd",allhour];
        }
        if (datecom1.minute<10)
        {
            self.pointsLable.text=[NSString stringWithFormat:@"0%zd",datecom1.minute];
        }else
        {
            self.pointsLable.text=[NSString stringWithFormat:@"%zd",datecom1.minute];
        }
        if (datecom1.second<10)
        {
            self.secondsLable.text=[NSString stringWithFormat:@"0%zd",datecom1.second];
        }else
        {
            self.secondsLable.text=[NSString stringWithFormat:@"%zd",datecom1.second];
        }

    }else{
        
        //停止计时
        [_timer invalidate];
        self.WhenLable.text=@"0";
        self.pointsLable.text=@"0";
        self.secondsLable.text=@"0";
        [[NSNotificationCenter defaultCenter] postNotificationName:SecondskillEndNotifi object:nil];
    }
    self.textTwoLable.text=@":";
    self.textOneLable.text=@":";
    __weak typeof(self) weakSelf=self;
 
      [_timer invalidate];
        
       _timer=[NSTimer bp_scheduledTimerWithTimeInterval:1.0 repeats:YES block:^{
       //[[NSNotificationCenter defaultCenter] postNotificationName:SecondskillEndNotifi object:nil];
        NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
        [formatter3 setDateStyle:NSDateFormatterMediumStyle];
        [formatter3 setTimeStyle:NSDateFormatterShortStyle];
        [formatter3 setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        //设置时区,这个对于时间的处理有时很重要
        //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
        //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
        //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了

        NSTimeZone* timeZone3 = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter3 setTimeZone:timeZone3];

        // NSDate* date = [formatter dateFromString:s]; //------------将字符串按formatter转成nsdate

        //            时间转时间戳的方法:
        long nowtime = [[NSDate date] timeIntervalSince1970]*1000;

        if (time>nowtime) {

            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateStyle:NSDateFormatterMediumStyle];
            [formatter1 setTimeStyle:NSDateFormatterShortStyle];
            [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeZone* timeZone1 = [NSTimeZone timeZoneWithName:@"Asia/shanghai"];
            [formatter1 setTimeZone:timeZone1 ];
            NSDate *nowdate =[NSDate dateWithTimeIntervalSince1970:nowtime/1000];
            //NSDate *enddate=[self DatetoTime:time];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/shanghai"];
            [formatter setTimeZone:timeZone];
            NSDate *enddate =[NSDate dateWithTimeIntervalSince1970:time/1000];
            NSCalendar *calendar=[NSCalendar currentCalendar];
            NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *datecom=[calendar components:unit fromDate:nowdate toDate:enddate options:0];
            // return dataCom;
        //NSLog(@"moth==%zd,day==%zd,hour=%zd,minute=%zd,second==%zd",datecom.month,datecom.day,datecom.hour,datecom.minute,datecom.second);
            //[weakSelf setLableTextWithDateComponents:datecom];
            // 回到主线程处理UI
            //dispatch_async(dispatch_get_main_queue(), ^{
                // 在主线程上添加图片
            
                [weakSelf setLableTextWithDateComponents:datecom];
            //});

        }else{
           /// dispatch_async(dispatch_get_main_queue(), ^{
                // 在主线程上添加图片
               [weakSelf setLableTextNotitle];
            [[NSNotificationCenter defaultCenter] postNotificationName:SecondskillEndNotifi object:nil];
            
           // });
            //[weakSelf setLableTextNotitle];

    }

    }];

    //[[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //});
}
#pragma mark********计算时间差
-(NSDateComponents *)CalculationTimeDifferenceWithtime:(long)time{
    long nowtime=[Uikility readnowtime];
    //NSString *nowstr=[self DatetoTime:nowtime];
    //NSString *endstr=[self DatetoTime:time];
   // NSLog(@"nowsss%@ ensvdshvdh%@",nowstr,endstr);
    NSDate *nowdate=[self DatetoTime:nowtime];
    NSDate *enddate=[self DatetoTime:time];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dataCom=[calendar components:unit fromDate:nowdate toDate:enddate options:0];
    return dataCom;
}
-(NSDate*)zoneChange:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return localeDate;
}
-(NSDate *)DatetoTime:(long)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp =[NSDate dateWithTimeIntervalSince1970:time/1000];
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    return confromTimespStr;
    return confromTimesp;
}
#pragma mark**********设置倒计时时间
-(void)setLableTextWithDateComponents:(NSDateComponents *)DateCom{
    
    NSInteger allhour=DateCom.day*24+DateCom.hour;
    if (allhour<10)
    {
        _WhenLable.text=[NSString stringWithFormat:@"0%zd",allhour];
    }else
    {
        _WhenLable.text=[NSString stringWithFormat:@"%zd",allhour];
    }
    if (DateCom.minute<10)
    {
        _pointsLable.text=[NSString stringWithFormat:@"0%zd",DateCom.minute];
    }else
    {
        _pointsLable.text=[NSString stringWithFormat:@"%zd",DateCom.minute];
    }
                if (DateCom.second<10)
                {
                   _secondsLable.text=[NSString stringWithFormat:@"0%zd",DateCom.second];
                }else
                {
                  _secondsLable.text=[NSString stringWithFormat:@"%zd",DateCom.second];
                }
  

   _textTwoLable.text=@":";
   _textOneLable.text=@":";

    
}
-(void)setLableTextNotitle{
    _WhenLable.text=@"00";
    _pointsLable.text=@"00";
    _secondsLable.text=@"00";
    _textTwoLable.text=@":";
    _textOneLable.text=@":";

}
-(void)setTimelableBackColor:(UIColor *)timelableBackColor{
    _timelableBackColor=timelableBackColor;
    self.WhenLable.layer.backgroundColor=timelableBackColor.CGColor;
    self.pointsLable.layer.backgroundColor=timelableBackColor.CGColor;
    self.secondsLable.layer.backgroundColor=timelableBackColor.CGColor;
    self.textTwoLable.textColor=timelableBackColor;
    self.textOneLable.textColor=timelableBackColor;
}
-(void)setTimeLableFont:(UIFont *)timeLableFont{
    _timeLableFont=timeLableFont;
    self.WhenLable.font=timeLableFont;
    self.pointsLable.font=timeLableFont;
    self.secondsLable.font=timeLableFont;
    self.textTwoLable.font=timeLableFont;
    self.textOneLable.font=timeLableFont;
}
-(void)setTimeTextColor:(UIColor *)timeTextColor{
    _timeTextColor=timeTextColor;
    self.WhenLable.textColor=timeTextColor;
    self.pointsLable.textColor=timeTextColor;
    self.secondsLable.textColor=timeTextColor;
    
}
-(void)setLableTextEndTime{
    [_timer invalidate];
      _WhenLable.text=@"0";
       _pointsLable.text=@"0";
        _secondsLable.text=@"0";
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size=self.frame.size;
    CGFloat With=size.width;
    CGFloat Height=size.height;
    CGFloat lableWith=With/4;
    _WhenLable.frame=CGRectMake(0, 0,lableWith , Height);
    _textOneLable.frame=CGRectMake(lableWith, 0, lableWith/2, Height);
    _pointsLable.frame=CGRectMake(lableWith/2+lableWith, 0, lableWith, Height);
    _textTwoLable.frame=CGRectMake(lableWith*2.5, 0, lableWith/2, Height);
    _secondsLable.frame=CGRectMake(lableWith*3, 0, lableWith, Height);
    _WhenLable.layer.cornerRadius=2*KIphoneWH;
    //_WhenLable.layer.masksToBounds=NO;
    _pointsLable.layer.cornerRadius=2*KIphoneWH;
    _secondsLable.layer.cornerRadius=2*KIphoneWH;
}
-(UILabel *)WhenLable{
    if (_WhenLable==nil) {
        _WhenLable=[[UILabel alloc] init];
        _WhenLable.textAlignment=NSTextAlignmentCenter;
        [self  addSubview:_WhenLable];
    }
    return _WhenLable;
}
-(UILabel *)pointsLable{
    if (_pointsLable==nil) {
        _pointsLable=[[UILabel alloc] init];
        _pointsLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_pointsLable];
    }
    return _pointsLable;
}
-(UILabel *)secondsLable{
    if (_secondsLable==nil) {
       _secondsLable =[[UILabel alloc] init];
     _secondsLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_secondsLable];
    }
    return _secondsLable;
}
-(UILabel *)textOneLable{
    if (_textOneLable==nil) {
        _textOneLable=[[UILabel alloc] init];
        _textOneLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_textOneLable];
    }
    return _textOneLable;
}
-(UILabel *)textTwoLable{
    if (_textTwoLable==nil) {
        _textTwoLable=[[UILabel alloc] init];
        _textTwoLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_textTwoLable];
    }
    return _textTwoLable;
}
-(void)dealloc{
    //NSLog(@"中文教程");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
        [_timer invalidate];
          _timer=nil;
    
}
@end
