 //
//  SaveBrandTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/20.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "SaveBrandTableViewCell.h"
#import "Uikility.h"
@implementation SaveBrandTableViewCell

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
    
    _brandimv=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 1*KIphoneWH, 100*KIphoneWH, 98*KIphoneWH)];
    [self.contentView addSubview:_brandimv];
    
    _brandname=[[UILabel alloc]initWithFrame:CGRectMake(120*KIphoneWH, 5*KIphoneWH, WIDTH-120*KIphoneWH, 30*KIphoneWH)];
    
    [self.contentView addSubview:_brandname];
    
    
    _brandintro=[[UILabel alloc]initWithFrame:CGRectMake(120*KIphoneWH, 40*KIphoneWH, WIDTH-140*KIphoneWH, 60*KIphoneWH)];
    _brandintro.font=[UIFont systemFontOfSize:12*KIphoneWH];
    _brandintro.numberOfLines=0;
    
    _brandintro.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [self.contentView  addSubview:_brandintro];
    

    
    _fxbut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-30*KIphoneWH, 70*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    [_fxbut setBackgroundImage:[UIImage imageNamed:@"分享@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:_fxbut];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
