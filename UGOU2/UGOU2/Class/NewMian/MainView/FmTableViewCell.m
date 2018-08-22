//
//  FmTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/20.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "FmTableViewCell.h"
#import "Uikility.h"
@implementation FmTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc]init];
        //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
        //view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.selectedBackgroundView = view;
        
    }
    return self;
}
-(void)createSubViews{
    _logopicUrl=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 118*KIphoneWH, 120*KIphoneWH)];
    [self.contentView addSubview:_logopicUrl];

    
    _shopName=[[UILabel alloc]initWithFrame: CGRectMake(130*KIphoneWH, 5*KIphoneWH, WIDTH-130*KIphoneWH, 30*KIphoneWH)];
    [self.contentView addSubview:_shopName];
    _shopAddr=[[UILabel alloc]initWithFrame: CGRectMake(130*KIphoneWH, 30*KIphoneWH, WIDTH-130*KIphoneWH, 60*KIphoneWH)];
    _shopAddr.numberOfLines=0;
    _shopAddr.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _shopAddr.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [self.contentView addSubview:_shopAddr];
    _Ydbut=[[UIButton alloc]initWithFrame: CGRectMake(WIDTH-70*KIphoneWH, 100*KIphoneWH, 60*KIphoneWH, 30*KIphoneWH)];
   
    [self.contentView addSubview:_Ydbut];
    _shopTele=[[UILabel alloc]initWithFrame: CGRectMake(130*KIphoneWH, 80*KIphoneWH,WIDTH-190*KIphoneWH, 20*KIphoneWH)];
    
    _shopTele.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _shopTele.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [self.contentView addSubview:_shopTele];
    _distancelable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-70*KIphoneWH, 70*KIphoneWH, 60*KIphoneWH, 30*KIphoneWH)];
    _distancelable.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _distancelable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    [self.contentView addSubview:_distancelable];
    
    _businessHours=[[UILabel alloc]initWithFrame: CGRectMake(130*KIphoneWH, 100*KIphoneWH,WIDTH-190*KIphoneWH, 30*KIphoneWH)];
    
    _businessHours.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _businessHours.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [self.contentView addSubview:_businessHours];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
