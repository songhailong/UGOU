//
//  BrandCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "BrandCell.h"
#import "Uikility.h"

@implementation BrandCell
-(instancetype)initWithFrame:(CGRect)frame{
self = [super initWithFrame:frame];
if (self) {
    
    
    self.backgroundColor = [UIColor whiteColor];
    //UIView *view = [[UIView alloc]init];
    //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
    //view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    //self.selectedBackgroundView = view;
    [self createSubViews];
    
}
return self;
}
-(void)createSubViews{
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, (WIDTH-20*KIphoneWH)/2-10*KIphoneWH, 150*KIphoneWH)];
    // [imview sd_setImageWithURL:im placeholderImage:[UIImage imageNamed:@"uuu"]];
    [self addSubview:_imageview];
    
    _textlable=[[UILabel alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH+150*KIphoneWH, (WIDTH-20*KIphoneWH)/2-5*KIphoneWH, 70*KIphoneWH)];
    _textlable.numberOfLines=2;
    [self addSubview:_textlable];
    _pricelable=[[UILabel alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH+220*KIphoneWH, 100*KIphoneWH, 30*KIphoneWH)];
    
    _pricelable.font=[UIFont systemFontOfSize:20*KIphoneWH];
    _pricelable.textColor=[UIColor colorWithRed:233/255.0 green:94/255.0 blue:75/255.0 alpha:1];
    [self addSubview:_pricelable];
    
    _procelable=[[UILabel alloc]initWithFrame:CGRectMake(105*KIphoneWH, 235*KIphoneWH, 100*KIphoneWH, 20*KIphoneWH)];
    _procelable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _procelable.textAlignment=NSTextAlignmentCenter;
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(20*KIphoneWH, 9*KIphoneWH, 60*KIphoneWH, 1*KIphoneWH)];
   
    [_procelable addSubview:lable];
    [self  addSubview:_pricelable];

}
@end
