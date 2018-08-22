//
//  MainCollectionViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/6.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "Uikility.h"

@implementation MainCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
        if (self) {
            
            
            self.backgroundColor =[UIColor whiteColor];
            //UIView *view = [[UIView alloc]init];
            //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
            //view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            
            //self.selectedBackgroundView = view;
            [self createSubViews];
    
        }
        return self;



}

-(void)createSubViews{
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, (WIDTH-20*KIphoneWH)/2-10*KIphoneWH, (WIDTH-20*KIphoneWH)/2-10*KIphoneWH)];
    // [imview sd_setImageWithURL:im placeholderImage:[UIImage imageNamed:@"uuu"]];
    /*
     UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
     UIViewContentModeTop,
     UIViewContentModeBottom,
     */
    _imageview.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_imageview];
    
    _textlable=[[UILabel alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH+(WIDTH-20*KIphoneWH)/2-10*KIphoneWH, (WIDTH-20*KIphoneWH)/2-5*KIphoneWH, 50*KIphoneWH)];
    _textlable.numberOfLines=2;
    //[_textlable setVerticalAlignment:VerticalAlignmentTop];
    _textlable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [self addSubview:_textlable];
    _pricelable=[[UILabel alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH+70*KIphoneWH+(WIDTH-20*KIphoneWH)/2-10*KIphoneWH, 100*KIphoneWH, 30*KIphoneWH)];
     //_textlable=[]
    //_textlable.numberOfLines=0;
    
    //_pricelable.textAlignment=NSTextAlignmentJustified;
    _pricelable.font=[UIFont systemFontOfSize:15*KIphoneWH];
    _pricelable.textColor=[UIColor colorWithRed:233/255.0 green:94/255.0 blue:75/255.0 alpha:1];
    [self addSubview:_pricelable];
    
    _procelable=[[UILabel alloc]initWithFrame:CGRectMake(5*KIphoneWH, 55*KIphoneWH+(WIDTH-20*KIphoneWH)/2-10*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    _procelable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _procelable.textAlignment=NSTextAlignmentLeft;
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0*KIphoneWH, 9*KIphoneWH, 60*KIphoneWH, 1*KIphoneWH)];
    _procelable.textColor=[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    lable.backgroundColor=[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1];
   [_procelable addSubview:lable];
    _procelable.alpha=0;
    [self  addSubview:_procelable];
    
    _salesLable=[[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-100*KIphoneWH, 5*KIphoneWH+70*KIphoneWH+(WIDTH-20*KIphoneWH)/2-10*KIphoneWH,  100*KIphoneWH, 30*KIphoneWH)];
    _salesLable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _salesLable.textAlignment=NSTextAlignmentRight;
    _salesLable.textColor=[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1];
    [self.contentView addSubview:_salesLable];
    _imv=[[UIImageView alloc]init];
    [self addSubview:_imv];
    _Uprice=[[UILabel alloc]init];
    _Uprice.font=[UIFont systemFontOfSize:18*KIphoneWH];
    _Uprice.textColor=[UIColor colorWithRed:233/255.0 green:94/255.0 blue:75/255.0 alpha:1];

    [self addSubview:_Uprice];
    
}

@end
