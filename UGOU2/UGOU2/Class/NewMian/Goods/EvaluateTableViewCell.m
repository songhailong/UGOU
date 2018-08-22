//
//  EvaluateTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/22.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "EvaluateTableViewCell.h"
#import "Uikility.h"
@implementation EvaluateTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self creatUI];
    }

    return self;
}
-(void)creatUI{
    _namelable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH,20*KIphoneWH)];
    _namelable.textAlignment=NSTextAlignmentLeft ;
    _namelable.font=[UIFont systemFontOfSize:18*KIphoneWH];
   _titlelable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 30*KIphoneWH, WIDTH-50*KIphoneWH, 40*KIphoneWH)];
   _titlelable.numberOfLines=0;
   _titlelable.font=[UIFont systemFontOfSize:14*KIphoneWH];
   _timelable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _timelable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-110*KIphoneWH, 70*KIphoneWH, 110*KIphoneWH, 20*KIphoneWH)];
    _attributelable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 70*KIphoneWH, WIDTH-130*KIphoneWH, 20*KIphoneWH)];
    _attributelable.font=[UIFont systemFontOfSize:12*KIphoneWH];
    _timelable.font=[UIFont systemFontOfSize:10*KIphoneWH];
    [self.contentView addSubview:_namelable];
    [self.contentView addSubview:_timelable];
    [self.contentView addSubview:_titlelable];
    [self.contentView addSubview:_attributelable];
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
