//
//  UGCustomNavView.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/12.
//

#import "UGCustomNavView.h"
#import "Uikility.h"
@implementation UGCustomNavView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    if (iPhoneX) {
       
        
    }else{
        
        
        
    }
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat with=self.bounds.size.width;
    CGFloat height=self.bounds.size.height;
    self.backgroundView.frame=CGRectMake(0, 0, with, height);
    //self.titleView.backgroundColor=[UIColor redColor];
    if (iPhoneX) {
        self.titleView.frame=CGRectMake(70*KIphoneWH, 44, WIDTH-140*KIphoneWH,  44);
        self.leftButton.frame=CGRectMake(10, 44, 60, 44);
        self.RightButton.frame=CGRectMake(WIDTH-60, 44, 60, 44);
        
    
    }else{
       self.titleView.frame=CGRectMake(70*KIphoneWH, 20*KIphoneWH, WIDTH-140*KIphoneWH,  44*KIphoneWH);
        self.leftButton.frame=CGRectMake(0, 20*KIphoneWH, 60*KIphoneWH, 44*KIphoneWH);
        self.RightButton.frame=CGRectMake(WIDTH-60*KIphoneWH, 20*KIphoneWH, 60*KIphoneWH, 44*KIphoneWH);
        
    }
    
    
    
}
-(void)setTitle:(NSString *)title{
    _title=title;
    [self.backgroundView addSubview:self.titleView];
    self.titleView.text=title;
    
}

-(UIButton*)leftButton{
    if (!_leftButton) {
        _leftButton=[[UIButton alloc] init];
        _leftButton.titleLabel.textColor=[UIColor whiteColor];
        _leftButton.titleLabel.textAlignment=NSTextAlignmentLeft;
        _leftButton.titleLabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
        _leftButton.backgroundColor=[UIColor clearColor];
        [self.leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
    }
    return _leftButton;
    
}
-(UIButton *)RightButton{
    if (!_RightButton) {
        _RightButton=[[UIButton alloc] init];
        _RightButton.backgroundColor=[UIColor clearColor];
        _RightButton.titleLabel.textAlignment=NSTextAlignmentRight;
        self.RightButton.titleLabel.textColor=[UIColor whiteColor];
        [_RightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_RightButton];
    }
    
    return _RightButton;
}
-(UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIImageView alloc] init];
        _backgroundView.userInteractionEnabled=YES;
        [self addSubview:_backgroundView];
    }
    
    return _backgroundView;
}
-(UILabel *)titleView{
    if (!_titleView) {
        _titleView=[[UILabel alloc] init];
        _titleView.backgroundColor=[UIColor clearColor];
        _titleView.textAlignment=NSTextAlignmentCenter;
        _titleView.textColor=[UIColor whiteColor];
        _titleView.font=[UIFont systemFontOfSize:20*KIphoneWH];
        
    }
    return _titleView;
    
}
-(void)leftBtnClick{
    if (self.Delegate&&[self.Delegate respondsToSelector:@selector(LeftItemAction)]) {
        [self.Delegate LeftItemAction];
    }
    
    
}
-(void)rightBtnClick
{
    if (self.Delegate&&[self.Delegate respondsToSelector:@selector(rightItemAction)]) {
        [self.Delegate rightItemAction];
    }
    
}
-(void)setCustemView:(UIView *)custemView{
    _custemView=custemView;
    [self.backgroundView addSubview:custemView];
    
}
-(void)setLeftImage:(UIImage *)image{
    //15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH
    UIImageView *leftimageView=[[UIImageView alloc] init];
    if (iPhoneX) {
        leftimageView.frame=CGRectMake(10, 15, 10, 14);
    }else{
        
        leftimageView.frame=CGRectMake(15*KIphoneWH, 15*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
    }
    leftimageView.image=image;
    [self.leftButton addSubview:leftimageView];
    
}
-(void)setrightImage:(UIImage *)image{
    //20, 10, 20, 20
    UIImageView *rightImagev=[[UIImageView alloc] init];
  
    if (iPhoneX) {
        rightImagev.frame=CGRectMake(20, 10, 20, 20);
        
    }else{
         rightImagev.frame=CGRectMake(25*KIphoneWH, 10*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH);
        
    }
    rightImagev.image=image;
    [self.RightButton addSubview:rightImagev];
    
    
}

@end
