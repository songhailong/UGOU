//
//  TableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/19.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.10.19.3.24 uitableviewcell
 */
//#define WIDTH [[UIScreen mainScreen] bounds].size.width
//#define HEIGHT [[UIScreen mainScreen] bounds].size.height

#import "TableViewCell.h"
#import "Uikility.h"
@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initview];
    }
    return self;
}
-(void)initview{
    _leftview=[[UIImageView alloc]init];
    [self addSubview:_leftview];
    _titlelabel=[[UILabel alloc]init];
    [self addSubview:_titlelabel];
    _but=[[UIButton alloc]init];
    [self addSubview:_but];
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _view.backgroundColor=[UIColor whiteColor];
    [self addSubview:_view];
    _butview=[[UIImageView alloc]init];
    [self addSubview:_butview];
    _imageview=[[UIImageView alloc]init];
    [self addSubview:_imageview];
    _dlabel=[[UILabel alloc]init];
    [self addSubview:_dlabel];
    _titleimageview=[[UIImageView alloc]init];
    [self addSubview:_titleimageview];
    _rightlabel=[[UILabel alloc]init];
    [self addSubview:_rightlabel];
    _leftlabel=[[UILabel alloc]init];
    [self addSubview:_leftlabel];
    _yzlabel=[[UILabel alloc]init];
    [self addSubview:_yzlabel];
  

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    ;
    // Configure the view for the selected state
}

@end
