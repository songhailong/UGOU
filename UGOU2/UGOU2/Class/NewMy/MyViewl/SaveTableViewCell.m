//
//  SaveTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/19.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "SaveTableViewCell.h"
#import "Uikility.h"
@implementation SaveTableViewCell

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
    
  _logpicUrl=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 1*KIphoneWH, 100*KIphoneWH, 98*KIphoneWH)];
    [self.contentView addSubview:_logpicUrl];
    
    _goodsname=[[UILabel alloc]initWithFrame:CGRectMake(120*KIphoneWH, 5*KIphoneWH, WIDTH-120*KIphoneWH, 50*KIphoneWH)];
    _goodsname.numberOfLines=2;
    [self.contentView addSubview:_goodsname];
    
    
    _pirce=[[UILabel alloc]initWithFrame:CGRectMake(120*KIphoneWH, 50*KIphoneWH, 80*KIphoneWH, 40*KIphoneWH)];
    _pirce.font=[UIFont systemFontOfSize:16*KIphoneWH];
    
    _pirce.textColor=[UIColor redColor];
    [self.contentView  addSubview:_pirce];
    
    _orgpirce=[[UILabel alloc] initWithFrame:CGRectMake(220*KIphoneWH, 65*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH)];
    _orgpirce.font=[UIFont systemFontOfSize:12*KIphoneWH];
    _orgpirce.textAlignment=NSTextAlignmentCenter;
    _orgpirce.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    _lalable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 15*KIphoneWH, 40*KIphoneWH, 1*KIphoneWH)];
    _lalable.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [self.contentView addSubview:_orgpirce];
    [_orgpirce addSubview:_lalable];
    
    _savebut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 60*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    [_savebut setBackgroundImage:[UIImage imageNamed:@"分享@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:_savebut];

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
