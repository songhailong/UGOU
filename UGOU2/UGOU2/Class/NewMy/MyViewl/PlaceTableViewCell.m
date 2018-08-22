//
//  PlaceTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/16.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "PlaceTableViewCell.h"
#import "Uikility.h"
@implementation PlaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        
        //self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        UIView *view = [[UIView alloc]init];
        //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
        //view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.selectedBackgroundView = view;
        
    }
    return self;
    
}

-(void)createSubViews{
  
    _conslabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-170*KIphoneWH, 40*KIphoneWH)];
    _conslabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_conslabel];
   _mobilelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-160*KIphoneWH, 5*KIphoneWH,150*KIphoneWH, 40*KIphoneWH)];
    _mobilelabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_mobilelabel];
    _arealabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 45*KIphoneWH, WIDTH-60*KIphoneWH, 30*KIphoneWH)];
    _arealabel.textColor=[UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    _arealabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    _arealabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_arealabel];
    _deaddlabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 75*KIphoneWH, WIDTH-60*KIphoneWH, 30*KIphoneWH)];
   _deaddlabel.textAlignment=NSTextAlignmentLeft;
    _deaddlabel.textColor=[UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    [self.contentView addSubview:_deaddlabel];
    _deaddlabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
   
    _ziplabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 105*KIphoneWH, WIDTH-60*KIphoneWH, 30*KIphoneWH)];
    _ziplabel.textColor=[UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    _ziplabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    _ziplabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_ziplabel];
    
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 70*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    imv.image=[UIImage imageNamed:@"向前"];
    [self.contentView addSubview:imv];
    
    _button=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-200*KIphoneWH, 135*KIphoneWH, 80*KIphoneWH, 25*KIphoneWH)];
    _button.tag=1;
    [_button setTitle:@"修改" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [_button addTarget:self action:@selector(buttondefault:) forControlEvents:UIControlEventTouchUpInside];
    [_button setBackgroundColor:[UIColor colorWithRed:146.0/255.0 green:208.0/255.0 blue:76.0/255.0 alpha:1]];
 _button1=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-100*KIphoneWH, 135*KIphoneWH, 80*KIphoneWH, 25*KIphoneWH)];
    _button1.tag=2;
    [_button1 setTitle:@"默认" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(buttondefault:) forControlEvents:UIControlEventTouchUpInside];
    [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button1 setBackgroundColor:[UIColor colorWithRed:146.0/255.0 green:208.0/255.0 blue:76.0/255.0 alpha:1]];
    _button1.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [self.contentView addSubview:_button];
    [self.contentView addSubview:_button1];
    
//    imv.userInteractionEnabled=YES;
//    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushxg:)];
//    imv.tag=indexPath.row;
//    [imv addGestureRecognizer:imgtap];



}
-(void)buttondefault:(UIButton *)b{
    if (_myblock) {
        _myblock(b.tag);
    }


}
@end
