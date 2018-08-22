//
//  TheBrandTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/20.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "TheBrandTableViewCell.h"
#import "Uikility.h"
@implementation TheBrandTableViewCell

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
    
   _logopic=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 100*KIphoneWH, 90*KIphoneWH)];
    [self.contentView addSubview:_logopic];
    
    _brandname=[[UILabel alloc]initWithFrame:CGRectMake(110*KIphoneWH, 5*KIphoneWH, 150*KIphoneWH, 30*KIphoneWH)];
    
    [self.contentView addSubview:_brandname];
    _detail=[[UILabel alloc]initWithFrame:CGRectMake(110*KIphoneWH, 30*KIphoneWH, WIDTH-150*KIphoneWH, 60*KIphoneWH)];
    _detail.numberOfLines=0;
    _detail.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _detail.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [self.contentView addSubview:_detail];
    _savebut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 60*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
    [_savebut setBackgroundImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:_savebut];
    
    _lalable=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 70*KIphoneWH,40*KIphoneWH, 30*KIphoneWH)];
    _lalable.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _lalable.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [self.contentView addSubview:_lalable];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
