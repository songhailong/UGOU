//
//  TwobrandTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/20.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "TwobrandTableViewCell.h"
#import "Uikility.h"
@implementation TwobrandTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc]init];
        [self creteciews];
        //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
        //view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        self.selectedBackgroundView = view;
        
    }
    return self;
}
-(void)creteciews{
  
    _fistbutton=[[UIButton alloc] initWithFrame:CGRectMake(0, 5*KIphoneWH, WIDTH/3, 90*KIphoneWH)];
    [_fistbutton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    _fistbutton.tag=0;
    _secondbutton=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH/3, 5*KIphoneWH, WIDTH/3, 90*KIphoneWH)];
     [_secondbutton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    _secondbutton.tag=1;
    _threedbutton=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH/3*2, 5*KIphoneWH, WIDTH/3, 90*KIphoneWH)];
    _threedbutton.tag=2;
    [_threedbutton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_fistbutton];
    [self.contentView addSubview:_secondbutton];
    [self.contentView addSubview:_threedbutton];
}
-(void)buttonclick:(UIButton*)but{
    if (_myblock) {
        _myblock(but.tag);
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
