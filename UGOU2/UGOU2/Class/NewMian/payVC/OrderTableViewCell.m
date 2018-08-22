//
//  OrderTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/4.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "Uikility.h"
@implementation OrderTableViewCell
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


//    //头视图点击方法
    UIView *vs2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 90*KIphoneWH)];
    [self.contentView addSubview:vs2];
    vs2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
//    
   _titleimgview=[[UIImageView alloc] initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 80*KIphoneWH)];
//    // 头衣服视图图片

    [vs2 addSubview:_titleimgview];
_titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(90*KIphoneWH, 5*KIphoneWH, WIDTH-190*KIphoneWH, 50*KIphoneWH)];

    _titlelabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    _titlelabel.numberOfLines=2;
    [vs2 addSubview:_titlelabel];
    _attlabel=[[UILabel alloc]initWithFrame:CGRectMake(90*KIphoneWH, 55*KIphoneWH, WIDTH-180*KIphoneWH, 20*KIphoneWH)];

    _attlabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _attlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [vs2 addSubview:_attlabel];
//    //头视图价格
    _priclelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-100*KIphoneWH, 5*KIphoneWH, 95*KIphoneWH, 40*KIphoneWH)];
    _priclelabel.font=[UIFont systemFontOfSize:19*KIphoneWH];
  
    [vs2 addSubview:_priclelabel];
//    //头视图衣服数量
    _quartlabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-80*KIphoneWH, 50*KIphoneWH, 70*KIphoneWH, 30*KIphoneWH)];
    
    [vs2 addSubview:_quartlabel];

    
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH,100*KIphoneWH, 120*KIphoneWH , 30*KIphoneWH)];
        lable.text=@"购买数量";
        lable.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:lable];
    
    
        NSArray *array=@[@"加号@2x",@"减号@2x"];
        for (int i=0; i<2; i++) {
            UIButton *b=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH-60*KIphoneWH*i, 100*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
            [b setBackgroundImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
            b.tag=i+1000;
            //[b addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView  addSubview:b];
        }
        //_gs=sp.shuling;
        _slabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-70*KIphoneWH, 100*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
        _slabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_slabel];
         
    
}


//添加商品个数
-(void)changeNumber:(UIButton *)button{
    if (_orderblock) {
        _orderblock(button.tag);
    }


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
