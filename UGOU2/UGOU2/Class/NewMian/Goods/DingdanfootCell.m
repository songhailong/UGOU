//
//  DingdanfootCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/7.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "DingdanfootCell.h"
#import "Uikility.h"
@implementation DingdanfootCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatviewss];
    }

    return self;
}
-(void)creatviewss{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50*KIphoneWH)];
    view.backgroundColor=[UIColor whiteColor];
    _lables=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH,5*KIphoneWH, 120*KIphoneWH , 40*KIphoneWH)];
    _lables.text=@"使用优惠券";
    _lables.textAlignment=NSTextAlignmentLeft;
    [view addSubview:_lables];
   _uhbutton=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 5*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
    //优惠券
//    [_uhbutton addTarget:self action:@selector(changeNumbertwo:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uhbutton setBackgroundImage:[UIImage imageNamed:@"使用优惠券-@2x"] forState:UIControlStateNormal];
    [_uhbutton setBackgroundImage:[UIImage imageNamed:@"使用优惠券-选中@2x"] forState:UIControlStateSelected];
    [view addSubview:_uhbutton];
    [self.contentView addSubview:view];


}
//-(void)changeNumbertwo:(UIButton *)b{
//    if (_mycellbloick) {
//        _mycellbloick(1);
//    }
//
//
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
