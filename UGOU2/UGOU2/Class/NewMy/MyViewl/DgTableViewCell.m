//
//  DgTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/15.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "DgTableViewCell.h"
#import "Uikility.h"
@implementation DgTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
       
        UIView *view = [[UIView alloc]init];
        //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
        view.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = view;
        
    }
    return self;

}

-(void)createSubViews{

    
    _goodsimv=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 90*KIphoneWH, 90*KIphoneWH)];
    [self.contentView addSubview:_goodsimv];
    _goodsname=[[UILabel alloc]initWithFrame:CGRectMake(100*KIphoneWH, 5*KIphoneWH, WIDTH-180*KIphoneWH, 50*KIphoneWH)];
    _goodsname.font=[UIFont systemFontOfSize:18*KIphoneWH];
    _goodsname.numberOfLines=2;
    [self.contentView addSubview:_goodsname];
    
    _attlabel=[[UILabel alloc]initWithFrame:CGRectMake(95*KIphoneWH, 70*KIphoneWH, WIDTH-190*KIphoneWH, 20*KIphoneWH)];
    _attlabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _attlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [self.contentView addSubview:_attlabel];
    _pircelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-85*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH)];
    _pircelabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
   
    
    [self.contentView addSubview:_pircelabel];
    _qulable=[[UILabel alloc]initWithFrame: CGRectMake(WIDTH-70*KIphoneWH,35*KIphoneWH, 70*KIphoneWH, 30*KIphoneWH)];
    _qulable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [self.contentView addSubview:_qulable];
    _deletebut=[[UIButton alloc]init];
    _deletebut.frame=CGRectMake(WIDTH-90*KIphoneWH, 65*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH);
    //[_deletebut setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_deletebut addTarget:self action:@selector(delcttbuttlick:) forControlEvents:UIControlEventTouchUpInside];
    _deletebut.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [_deletebut setTitleColor:[UIColor colorWithRed:238/255.0 green:80/255.0 blue:55/255.0 alpha:1] forState:UIControlStateNormal];
    _deletebut.alpha=0;
    
    _pjbut=[[UIButton alloc]init];
    _pjbut.frame=CGRectMake(WIDTH-180*KIphoneWH, 100*KIphoneWH, 80*KIphoneWH, 25*KIphoneWH);
    //[_deletebut setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_pjbut addTarget:self action:@selector(delcttbuttlick:) forControlEvents:UIControlEventTouchUpInside];
    _pjbut.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [_pjbut setTitleColor:[UIColor colorWithRed:238/255.0 green:80/255.0 blue:55/255.0 alpha:1] forState:UIControlStateNormal];
    _pjbut.alpha=0;
    _pjbut.tag=2;
    
    _thbut=[[UIButton alloc]init];
    _thbut.frame=CGRectMake(WIDTH-90*KIphoneWH, 100*KIphoneWH, 80*KIphoneWH, 25*KIphoneWH);
    //[_deletebut setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_thbut addTarget:self action:@selector(delcttbuttlick:) forControlEvents:UIControlEventTouchUpInside];
    _thbut.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [_thbut setTitleColor:[UIColor colorWithRed:238/255.0 green:80/255.0 blue:55/255.0 alpha:1] forState:UIControlStateNormal];
    _thbut.tag=3;
    _thbut.alpha=0;
    
    
    [self.contentView addSubview:_deletebut];
    [self.contentView addSubview:_pjbut];
    [self.contentView addSubview:_thbut];
    
   
}
-(void)delcttbuttlick:(UIButton *)bt{
    if (_block) {
        _block(bt.tag);
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
