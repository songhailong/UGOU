//
//  TimeViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/12/25.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//

#import "TimeViewController.h"
#import "UGHeader.h"

@interface TimeViewController ()<UIScrollViewDelegate,UGCustomnNavViewDelegate>{
    NSDateComponents *comps;
    UIImageView *imv;
    UIImageView *imgv;
    UIScrollView *butscroll;
    UIScrollView *scroll;
    NSInteger  monthday;
    NSString *a1;
    NSString *a2;
    NSInteger a3;
    NSString *string1;
    NSString *string2;
 
    int b1;
    int b2;
}
@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;
    [self addnavigation];
    [self addview];
    // Do any additional setup after loading the view.
}
#pragma mark 导航栏
-(void)addnavigation{
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
//    label.textColor=[UIColor whiteColor];
//
//    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
//    self.navigationItem.titleView=label;
//
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
//    self.navigationItem.leftBarButtonItem=leftButton;
//    self.navigationController.navigationBar.translucent=NO;
//    if (_flag==2) {
//       label.text=@"选择到店时间";
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"到店预订横条"] forBarMetrics:UIBarMetricsDefault];
//    }else if (_flag==3){
//    label.text=@"选择上门时间";
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"上门试衣横条"] forBarMetrics:UIBarMetricsDefault];
//    }
    
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    
    if (_flag==2) {

        [custemNav.backgroundView setImage:[UIImage imageNamed:@"上门试衣横条"]];
        custemNav.title=@"选择到店时间";
    }else if (_flag==3){

        [custemNav.backgroundView setImage:[UIImage imageNamed:@"上门试衣横条"]];
        custemNav.title=@"选择上门时间";
    }
    [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:custemNav];
    
}
-(void)LeftItemAction{
    
    [self pop];
}
#pragma mark 返回
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 时间
-(void)addtime{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
   
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    [comps1 setDay:1];
    [comps1 setMonth:comps.month];
    [comps1 setYear:comps.year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comps1];
    
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:today];
    monthday=days.length;
   
    
    
}
#pragma mark 头部日期
-(void)addview{
    [self addtime];
    butscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 69*KIphoneWH, WIDTH-10*KIphoneWH, 50*KIphoneWH)];
    butscroll.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    butscroll.scrollEnabled=YES;
    butscroll.showsHorizontalScrollIndicator=false;
//    int a=0;
//    a=3;
    butscroll.contentSize=CGSizeMake(WIDTH*2, 50*KIphoneWH);
    imv=[[UIImageView alloc]init];
    imv.image=[UIImage imageNamed:@"选中日期底框"];
    [butscroll addSubview:imv];

    NSArray *arr=@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i=0; i<7; i++) {
        
        a3=comps.weekday-1+i;
        if (comps.weekday-1+i>6) {
            a3=comps.weekday-1+i-7;
        }
        a2=[arr objectAtIndex:a3];
       
        
        if (comps.day+i==monthday) {
            if (i==0) {
              a1=[NSString stringWithFormat:@"今天\n%ld-%zd ",(long)comps.month,comps.day];
            }else{
                a1=[NSString stringWithFormat:@"周%@\n%zd-%zd ",a2,comps.month,comps.day+i];
               
            }
            
        }else if(comps.day+i<monthday) {
            if (i==0) {
              a1=[NSString stringWithFormat:@"今天\n%ld-%ld ",(long)comps.month,(long)comps.day+i];
                
              
            }else{
            a1=[NSString stringWithFormat:@"周%@\n%ld-%ld ",a2,(long)comps.month,(long)comps.day+i];
                
            }
            
        }else if(comps.day+i>monthday){
            if (i==0) {
                if (comps.month+1>12) {
                    a1=[NSString stringWithFormat:@"今天\n%d-%zd ",1,comps.day+i-monthday];
                }else{
                    a1=[NSString stringWithFormat:@"今天\n%ld-%zd ",(long)comps.month+1,comps.day+i-monthday];
                }
            }else{
                if (comps.month+1>12) {
                    a1=[NSString stringWithFormat:@"周%@\n%d-%zd ",a2,1,comps.day+i-monthday];
                 
                }else{
                    a1=[NSString stringWithFormat:@"周%@\n%zd-%zd ",a2,comps.month+1,comps.day+i-monthday];
                   
                }
            }

        }
        UIButton *but=[UIButton buttonWithType:UIButtonTypeSystem];
        but.tag=i;
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.frame=CGRectMake(20*KIphoneWH+((WIDTH-50*KIphoneWH)/4+10*KIphoneWH)*i, 0, (WIDTH-50*KIphoneWH)/4, 50*KIphoneWH);
        [but setTitle:a1 forState:UIControlStateNormal];
        but.titleLabel.numberOfLines=2;
        but.titleLabel.textAlignment=NSTextAlignmentCenter;
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but addTarget:self action:@selector(pushbut:) forControlEvents:UIControlEventTouchUpInside];
        [butscroll addSubview:but];
    }
    [self.view addSubview:butscroll];
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 124*KIphoneWH, WIDTH, 350*KIphoneWH)];
    scroll.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    scroll.delegate=self;
    scroll.showsHorizontalScrollIndicator=false;
    scroll.contentSize=CGSizeMake(WIDTH*8, 350*KIphoneWH);
    imgv=[[UIImageView alloc]init];
    imgv.image=[UIImage imageNamed:@"选中日期底框"];
    [scroll addSubview:imgv];
    NSArray *arrs=@[@"8:00",@"8:30",@"9:00",@"9:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00"];
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4, (int)i/4*40*KIphoneWH, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSMutableString *str=[[NSMutableString alloc] init];
        
      str=  arrs[i];
      NSRange rang=[str rangeOfString:@":"];
       NSString *timstr=[str substringToIndex:rang.location];
       NSString *afterstr=[str substringFromIndex:rang.location+1];
       NSInteger nowminut=comps.minute+30;
       if (nowminut>60) {
           if (timstr.integerValue<=(comps.hour+1)) {
                if (timstr.integerValue<(comps.hour+1)) {
                    but.backgroundColor=[UIColor whiteColor];
                    but.selected=YES;
                 
                }else{
                if (afterstr.integerValue!=30) {
                    but.backgroundColor=[UIColor whiteColor];
                    but.selected=YES;
                   
                }}
                           }
        }else{
            
            if (timstr.integerValue<=comps.hour) {
                but.backgroundColor=[UIColor whiteColor];
                but.selected=YES;
               
               
            }
        
        
        
        }
       but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH, (int)i/4*40*KIphoneWH, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH*2, (int)i/4*40*KIphoneWH, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH*3, (int)i/4*40*KIphoneWH, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH*4, (int)i/4*40, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH*5, (int)i/4*40, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i]forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH*6, (int)i/4*40, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }
    for (int i=0; i<21; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH+i%4*(WIDTH-20*KIphoneWH)/4+WIDTH*7, (int)i/4*40, (WIDTH-20*KIphoneWH)/4, 50*KIphoneWH)];
        [but setTitle:[arrs objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.tag=i;
        [but addTarget:self action:@selector(pushbuts:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
    }

    [self.view addSubview:scroll];
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(5*KIphoneWH, HEIGHT-120*KIphoneWH, WIDTH-10*KIphoneWH, 50*KIphoneWH)];
    [but setBackgroundImage:[UIImage imageNamed:@"确定选择"] forState:UIControlStateNormal];
     [but addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
}
#pragma mark 日期 滑动
-(void)pushbut:(UIButton *)b{
    
        
    
    string1=@" ";
    imv.frame=b.frame;
     [scroll setContentOffset:CGPointMake(WIDTH*b.tag, 0) animated:YES];
    string1=b.titleLabel.text;
        b1=1;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scroll.contentOffset.x/WIDTH;
    imv.frame=CGRectMake(20+((WIDTH-50*KIphoneWH)/4+10*KIphoneWH)*index, 0,((WIDTH-50*KIphoneWH)/4+10*KIphoneWH), 50*KIphoneWH);
   
}
#pragma mark 时间
-(void)pushbuts:(UIButton *)b{
    if (b.selected==NO) {
        
    
    string2=@" ";
    imgv.frame=b.frame;
    string2=b.titleLabel.text;
    b2=1;
    }
}
#pragma mark 确定
-(void)push{
    
    if (b1!=1) {
        [Uikility alert:@"请选择日期！"];
        return;
    }if (b2!=1) {
   [Uikility alert:@"请选择时间！"];
        return;
    }else{
    NSString *s=[NSString stringWithFormat:@"%@%@",string1,string2];
       
    if([s rangeOfString:@"\n"].location !=NSNotFound)//_roaldSearchText
    {
        
         NSArray  * imarray= [s componentsSeparatedByString:@"\n"];
        s=[imarray objectAtIndex:1];
    }
   
        s=[NSMutableString stringWithFormat:@"%ld-%@:%d%D",(long)comps.year,s,0,0];
        
        
        // NSString* timeStr = @"2016-02-10 17:30:00";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        
        
        //设置时区,这个对于时间的处理有时很重要
        //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
        //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
        //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
        
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        
        NSDate* date = [formatter dateFromString:s]; //------------将字符串按formatter转成nsdate
        
        //            时间转时间戳的方法:
        UInt64 recordTime = [date timeIntervalSince1970]*1000;
        
        NSString *timeSp = [NSString stringWithFormat:@"%llu", recordTime];
        
        
        [self.delegate passtime:timeSp];
       //NSString *strss= [Uikility DatetoTime:1453102798];
        
    [self.navigationController popViewControllerAnimated:YES];
    }
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
