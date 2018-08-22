//
//  LocateFailureView.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/7/8.
//
//

#import "LocateFailureView.h"
#import "Uikility.h"
@interface LocateFailureView ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIButton *ReloadBtn;
@property(nonatomic,strong)UIButton *LocatBtn;
@property(nonatomic,strong)UILabel *alterLable;
@property(nonatomic,strong)UILabel *textLable;


@end


@implementation LocateFailureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.ReloadBtn=[[UIButton alloc] init];
        [self.ReloadBtn setTitle:@"开启定位" forState:UIControlStateNormal];
        [self.ReloadBtn addTarget:self action:@selector(reloadLocation:) forControlEvents:UIControlEventTouchUpInside];
        [self.ReloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.ReloadBtn.backgroundColor=[UIColor colorWithRed:62/225.0 green:234/255.0 blue:117/255.0 alpha:1];
        self.ReloadBtn.layer.cornerRadius=5*KIphoneWH;
        self.LocatBtn=[[UIButton alloc] init];
        [self.LocatBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        self.LocatBtn.layer.cornerRadius=5*KIphoneWH;
        [self.LocatBtn addTarget:self action:@selector(Reload:) forControlEvents:UIControlEventTouchUpInside];
        self.LocatBtn.backgroundColor=[UIColor colorWithRed:62/225.0 green:234/255.0 blue:117/255.0 alpha:1];
        
        self.alterLable=[[UILabel alloc] init];
        self.alterLable.text=@"定位失败";
        self.alterLable.textAlignment=NSTextAlignmentCenter;
        
        
        self.textLable=[[UILabel alloc] init];
        self.textLable.text=@"必须定位成功后才可以展示商品，如没有允许定位请点击启动定位，请进入系统《设置》《隐私》《定位服务》中打开开关，并允许U购使用定位服务，如已经允许定位请点击重新加载";
        self.textLable.numberOfLines=6;
        [self addSubview:self.ReloadBtn];
        [self addSubview:self.LocatBtn];
        [self addSubview:self.alterLable];
        [self addSubview:self.textLable];
//        UIAlertView *alteview=[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请进入系统《设置》《隐私》《定位服务》中打开开关，并允许U购使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
//        
//        [alteview show];
    }
    return self;
}
-(void)layoutSubviews{
    self.ReloadBtn.frame=CGRectMake(40*KIphoneWH, 300*KIphoneWH, 120*KIphoneWH, 60*KIphoneWH);
    self.LocatBtn.frame=CGRectMake(WIDTH-160*KIphoneWH, 300*KIphoneWH, 120*KIphoneWH, 60*KIphoneWH);
    self.alterLable.frame=CGRectMake(50*KIphoneWH, 50*KIphoneWH, WIDTH-100*KIphoneWH, 50*KIphoneWH);
    
    self.textLable.frame=CGRectMake(40*KIphoneWH, 100*KIphoneWH, WIDTH-80*KIphoneWH, 150*KIphoneWH);

}
#pragma mark************开启定位
-(void)reloadLocation:(UIButton *)Btn{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
//重新加载
-(void)Reload:(UIButton *)btn{
    UIAlertView *alteview=[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请进入系统《设置》《隐私》《定位服务》中打开开关，并允许U购使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
    alteview.tag=10;
    [alteview show];



}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
    }else{
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }

}
@end
