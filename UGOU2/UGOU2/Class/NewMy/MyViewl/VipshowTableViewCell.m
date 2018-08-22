//
//  VipshowTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/10/10.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "VipshowTableViewCell.h"
#import "Masonry.h"
@implementation VipshowTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        self.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
        //UIView *view=[[UIView alloc] init];
        //self.selectedBackgroundView=view;
        [self creatUI];
    
    }
    return self;
}

-(void)creatUI{

    _iconeimageview=[[UIImageView alloc] init];
    //self.contentView.backgroundColor=[UIColor redColor];
    _namelable=[[UILabel alloc] init];
    _titlelable=[[UILabel alloc] init];
    _iconeimageview.translatesAutoresizingMaskIntoConstraints=NO;
    _namelable.translatesAutoresizingMaskIntoConstraints=NO;
    _titlelable.translatesAutoresizingMaskIntoConstraints=NO;
    //self.contentView.translatesAutoresizingMaskIntoConstraints=NO;
    _namelable.font=[UIFont systemFontOfSize:18];
    _namelable.textColor=[UIColor colorWithRed:35/255.0 green:35/255.0 blue:35/255.0 alpha:1];
    //_titlelable.textColor=[UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163/255.0 alpha:1];
    _titlelable.textColor=[UIColor blackColor];
    _titlelable.font=[UIFont systemFontOfSize:14];
    _iconeimageview.layer.cornerRadius=25;
    //self.contentView.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [self.contentView  addSubview:_namelable];
    [self.contentView  addSubview:_iconeimageview];
    [self.contentView addSubview:_titlelable];
    [_iconeimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@5);
        make.left.mas_equalTo(@5);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
        
    }];
    [_namelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
        make.left.mas_equalTo(_iconeimageview.mas_right).with.offset(10);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_namelable.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_iconeimageview.mas_right).with.offset(10);
        make.right.mas_equalTo(@5);
        make.bottom.mas_equalTo(0);
    }];
    _iconeimageview.layer.cornerRadius=25;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
