//
//  CartTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CartTableViewCell.h"
#import "Uikility.h"

@implementation CartTableViewCell
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
    _imview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5*KIphoneWH, 80*KIphoneWH, 80*KIphoneWH)];
    // [imview sd_setImageWithURL:im placeholderImage:[UIImage imageNamed:@"uuu"]];
    [self.contentView addSubview:_imview];
    
    _imlabel=[[UILabel alloc]initWithFrame:CGRectMake(85*KIphoneWH, 5*KIphoneWH, WIDTH-180*KIphoneWH, 50*KIphoneWH)];
    _imlabel.numberOfLines=2;
    _imlabel.font=[UIFont systemFontOfSize:15*KIphoneWH];
    [self.contentView addSubview:_imlabel];
    
    _qtlabel=[[UILabel alloc]initWithFrame:CGRectMake(85*KIphoneWH, 50*KIphoneWH, WIDTH-170*KIphoneWH, 20*KIphoneWH)];
    
    _qtlabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _qtlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [self.contentView addSubview:_qtlabel];
    
    _jglabel=[[UILabel alloc]initWithFrame:CGRectMake(85*KIphoneWH, 60*KIphoneWH, 80*KIphoneWH, 40*KIphoneWH)];
    _jglabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    
    _jglabel.textColor=[UIColor redColor];
    [self.contentView  addSubview:_jglabel];
    
    _lplabel=[[UILabel alloc] initWithFrame:CGRectMake(160*KIphoneWH, 65*KIphoneWH, 60*KIphoneWH, 30*KIphoneWH)];
    _lplabel.font=[UIFont systemFontOfSize:12*KIphoneWH];
    _lplabel.textAlignment=NSTextAlignmentCenter;
    _lplabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 15*KIphoneWH, 40*KIphoneWH, 1*KIphoneWH)];
    lable.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    //[self.contentView addSubview:_lplabel];
    [_lplabel addSubview:lable];
    _gslabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-130*KIphoneWH, 60*KIphoneWH, 40*KIphoneWH, 40*KIphoneWH)];
    _gslabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView  addSubview:_gslabel];
    _deleteBut =[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-110*KIphoneWH, 29*KIphoneWH, 50*KIphoneWH, 22*KIphoneWH)];
    [_deleteBut setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBut.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    //_deleteBut.titleLabel.textColor=[UIColor blackColor];
    
    //_deleteBut.backgroundColor=[UIColor redColor];
    
    [_deleteBut setTitleColor:[UIColor colorWithRed:238/255.0 green:80/255.0 blue:55/255.0 alpha:1] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBut];
    [_deleteBut addTarget:self action:@selector(delectbut:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)delectbut:(UIButton *)bt{
   
   
    if (_block) {
        _block(@"jjj");
    }
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
