//
//  OrderstatusTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/25.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "OrderstatusTableViewCell.h"
#import "Uikility.h"
@implementation OrderstatusTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatviews];
        self.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:232.0/255.0 blue:238.0/255.0 alpha:1];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)creatviews{
    _leftimageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KIphoneWH, 20*KIphoneWH, 25*KIphoneWH, 25*KIphoneWH)];
    _backimageview=[[UIImageView alloc] initWithFrame:CGRectMake(45*KIphoneWH, 5*KIphoneWH, WIDTH-55*KIphoneWH, 90*KIphoneWH)];
    _backimageview.backgroundColor=[UIColor whiteColor];
    _namelable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 15*KIphoneWH, 220*KIphoneWH, 20*KIphoneWH)];
    _namelable.font=[UIFont systemFontOfSize:20*KIphoneWH];
    _namelable.textColor=[UIColor blackColor];
    _namelable.textAlignment=NSTextAlignmentLeft;
   _titlelable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 35*KIphoneWH, 280*KIphoneWH, 40*KIphoneWH)];
    _titlelable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    _titlelable.textColor=[UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1];
    _titlelable.numberOfLines=2;
    _timelable=[[UILabel alloc] initWithFrame:CGRectMake(250*KIphoneWH, 15*KIphoneWH, 50*KIphoneWH, 20*KIphoneWH)];
    _timelable.font=[UIFont systemFontOfSize:15*KIphoneWH];
    //_timelable.textColor=[UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1];
    _timelable.textColor=[UIColor blackColor];
    
    
    [self.contentView addSubview:_backimageview];
    [self.contentView addSubview:_leftimageview];
    [self.backimageview addSubview:_namelable];
    [_backimageview addSubview:_titlelable];
    [_backimageview addSubview:_timelable];
}

@end
