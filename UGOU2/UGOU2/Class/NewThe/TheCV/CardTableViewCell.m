//
//  CardTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/2/26.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CardTableViewCell.h"
#import "Uikility.h"

@implementation CardTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
        //self.backgroundColor=UGColor(231, 231, 231);
        [self creatviews];
        
    }
   return  self;

}
-(void)creatviews{

    //_view=[[UIView alloc] initWithFrame:self.frame];
    //_view.backgroundColor=[UIColor colorWithRed:143.0/255.0 green:235.0/255.0 blue:123.0/255.0 alpha:1];
    //[self.contentView addSubview:_view];
    _iocnimageviedw=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-20*KIphoneWH, 98*KIphoneWH)];
    /*UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     UIViewContentModeCenter,   */
    _iocnimageviedw.contentMode=UIViewContentModeScaleAspectFill;
    _iocnimageviedw.clipsToBounds=YES;
//    UIImage *iamhcc=[UIImage imageNamed:@"couponsS@2x"];
//    if (iamhcc==nil) {
//        NSLog(@"图片控");
//    }
//    [_iocnimageviedw setImage:[UIImage imageNamed:@"couponsS@2x"]];
    //_iocnimageviedw.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:_iocnimageviedw];
    
    _pricelable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/6-20*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 35*KIphoneWH)];
    _pricelable.font=[UIFont systemFontOfSize:30*KIphoneWH];
    _pricelable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_pricelable];
    _propolable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/6-20*KIphoneWH, 45*KIphoneWH, 80*KIphoneWH, 20*KIphoneWH)];
    _propolable.font=[UIFont systemFontOfSize:12*KIphoneWH];
    [self.contentView addSubview:_propolable];
    _namelable=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-20*KIphoneWH, 10*KIphoneWH, WIDTH/2, 30*KIphoneWH)];
    _namelable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    //_namelable.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_namelable];
    _timelable=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-20*KIphoneWH, 40*KIphoneWH, WIDTH/2, 20*KIphoneWH)];
    _timelable.font=[UIFont systemFontOfSize:12*KIphoneWH];
    [self.contentView addSubview:_timelable];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 98*KIphoneWH, WIDTH-20*KIphoneWH, 2*KIphoneWH)];
   
    view.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    [self.contentView addSubview:view];
    _tovidew=[[UIView alloc] initWithFrame:CGRectMake(0, 100*KIphoneWH, WIDTH-20*KIphoneWH, 10*KIphoneWH)];
    _tovidew.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    [self.contentView addSubview:_tovidew];

    _but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-80*KIphoneWH, 5*KIphoneWH, 55*KIphoneWH, 30*KIphoneWH)];
    _but.titleLabel.textAlignment=NSTextAlignmentRight;
    _but.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    _but.titleLabel.textColor=UGColor(152, 152, 152);
    [_but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_but];
    
   // _shareBt=[[UIButton alloc ] initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 5*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
    
    //[_shareBt addSubview:_shareImageview];
    _shareBt=[[UIButton alloc ] initWithFrame:CGRectMake(WIDTH-80*KIphoneWH, 60*KIphoneWH, 55*KIphoneWH, 30*KIphoneWH)];
    
    //[_shareBt setImage:[UIImage imageNamed:@"ic_share_variant"] forState:UIControlStateNormal];
    //_shareBt.backgroundColor=[UIColor blueColor];
    [_shareBt addTarget:self action:@selector(ug_shareAction:) forControlEvents:UIControlEventTouchUpInside];
    _shareImageview=[[UIImageView alloc] initWithFrame:CGRectMake(25*KIphoneWH, 0, 30*KIphoneWH, 30*KIphoneWH)];
//    UIImage *iamsss=[UIImage imageNamed:@"ic_share_variant"];
//    NSLog(@"图片%@",iamsss);
    [_shareImageview setImage:[UIImage imageNamed:@"ic_share_variant"]];
    [_shareBt addSubview:_shareImageview];
    [self.contentView addSubview:_shareBt];
    
    
    
    
}
-(void)ug_shareAction:(UIButton *)bt{
    
    if (_shareClickBlock) {
        _shareClickBlock(@"1");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
