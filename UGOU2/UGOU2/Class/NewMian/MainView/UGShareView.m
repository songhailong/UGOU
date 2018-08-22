//
//  UGShareView.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/6/28.
//
//

#import "UGShareView.h"
#import "BassAPI.h"
#import "Uikility.h"
#import "UGShareButton.h"
@interface UGShareView ()
@property(nonatomic,strong)UIView*bottomView;
@property(nonatomic,strong)UIButton *cancal;
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UILabel *themeViwe;
@end

@implementation UGShareView
//会默认执行init 所以封装完后 也可以用init创建 布局  （不建议在这里fram 布局）因为后面有可能修改fram
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self  creatUI];
        [self creatShareBtn];
    }
   return self;
}
//-(UIView *)topView{
//    if (!_topView) {
//        _topView =[[UIView alloc] init];
//        _topView.backgroundColor=[UIColor redColor];
//        //_topView.alpha=0.5;
//        
//       
//        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
//        [self.topView addGestureRecognizer:tapGes];
//        [self addSubview:_topView];
//    }
//
//    return self;
//}
-(UILabel *)themeViwe{
    if (!_themeViwe) {
        _themeViwe=[[UILabel alloc] init];
        _themeViwe.text=@"分享";
        _themeViwe.textAlignment=NSTextAlignmentCenter;
        _themeViwe.textColor=[UIColor blackColor];
        [self.bottomView addSubview:_themeViwe];
    }
    return _themeViwe;
}

//-(UIView *)bottomView{
//    if (!_bottomView) {
//        _bottomView=[[UIView alloc] init];
//        
//        [self addSubview:_bottomView];
//    }
//    return _bottomView;
//}
//-(UIButton *)cancal{
//    if (!_cancal) {
//        _cancal=[[UIButton alloc] init];
//        [_cancal setTitle:@"取消" forState:UIControlStateNormal];
//        _cancal.titleLabel.font=[UIFont systemFontOfSize:24*KIphoneWH];
//        [_cancal setTintColor:[UIColor redColor]];
//        //[_cancal setBackgroundImage:[UIImage imageNamed:@"搜索框"] forState:UIControlStateNormal];
//        [_cancal addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchDown];
//        _cancal.backgroundColor=[UIColor greenColor];
//        [self.bottomView addSubview:_cancal];
//    }
//
//    return _cancal;
//}
/*
    必须调用  [super layoutSubviews];
 
    当控件的fram 发生变化的时候调用
 
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat shareW=self.frame.size.width;
    CGFloat shareH=self.frame.size.height;
    self.topView.frame=CGRectMake(0, 0, shareW, shareH/2);
    self.bottomView.frame=CGRectMake(0, shareH/2, shareW, shareH/2);
    self.cancal.frame=CGRectMake(5*KIphoneWH, shareH/2-70*KIphoneWH,WIDTH-10*KIphoneWH, 60*KIphoneWH);
    
    self.cancal.layer.cornerRadius=5*KIphoneWH;
    self.themeViwe.frame=CGRectMake(0, 0, shareW, 50*KIphoneWH);
    //self.bottomView.frame=CGRectMake(0, shareH/2, shareW, shareH/2);
}
-(void)creatShareBtn{
    NSArray * imagesArr;
    NSArray *titleArr;
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
  imagesArr=@[@"umsocial_sina.png",@"umsocial_qzone",@"umsocial_wechat_timeline",@"umsocial_wechat.png"];
        titleArr=@[@"微博",@"QQ空间",@"朋友圈",@"微信"];
        
    }else{
      imagesArr=@[@"umsocial_sina.png",@"umsocial_qzone"];
        titleArr=@[@"微博",@"QQ空间"];
    }
    for (int i=0; i<imagesArr.count; i++) {
        
        CGFloat imageW=self.frame.size.width;
        CGFloat btnw=(imageW-80*KIphoneWH)/4;
        UGShareButton *sharebtn=[[UGShareButton alloc] initWithFrame:CGRectMake(10*KIphoneWH+(btnw+20*KIphoneWH)*i, 60*KIphoneWH, btnw, btnw+30*KIphoneWH)];
        sharebtn.iconView.image=[UIImage imageNamed:THEMEShareSrcName([imagesArr objectAtIndex:i])];
        sharebtn.titlelable.text=titleArr[i];
        sharebtn.tag=i;
        [sharebtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:sharebtn];
        
    }
    
    

}
-(void)hideView{
    
    [_delegate UGShareViewHide];

}
//分享按钮点击
-(void)shareBtnClick:(UIButton *)btn{
    
        switch (btn.tag) {
            case 0:{
                [_delegate UGShareViewDidSelect:UGShareTypeSina];
            }
            break;
            case 1:{
                [_delegate UGShareViewDidSelect:UGShareTypeQQZone];
            }
                
                break;
            case 2:{
                [_delegate UGShareViewDidSelect:UGShareTypeWeChat];
                
            }
                
                break;
            case 3:{
                [_delegate UGShareViewDidSelect:UGShareTypeWX];
            }
                
                break;
                
            default:
                break;
        }
   

}
-(void)creatUI{
    _bottomView=[[UIView alloc] init];
    _bottomView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_bottomView];
    _topView =[[UIView alloc] init];
    _topView.backgroundColor=[UIColor blackColor];
    _topView.alpha=0.5;
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [self.topView addGestureRecognizer:tapGes];
    [self addSubview:_topView];
    
    _cancal=[[UIButton alloc] init];
    [_cancal setTitle:@"取消" forState:UIControlStateNormal];
    
    _cancal.titleLabel.font=[UIFont systemFontOfSize:24*KIphoneWH];
    [_cancal setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_cancal setBackgroundImage:[UIImage imageNamed:@"搜索框"] forState:UIControlStateNormal];
    [_cancal addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchDown];
    
    [self.bottomView addSubview:_cancal];
}
@end
