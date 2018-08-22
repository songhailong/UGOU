//
//  DgHearderview.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/18.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "DgHearderview.h"
#import "Uikility.h"
@implementation DgHearderview

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        //self.view.backgroundColor=[UIColor whiteColor];
        self.contentView.backgroundColor=[UIColor whiteColor];
        //self.backgroundColor=[UIColor whiteColor];
        [self creatviewss];
    }
    
    return self;
    
}
-(void)creatviewss{

    //self.view.backgroundColor=[UIColor whiteColor];
   _imvs=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2*KIphoneWH, WIDTH, 1*KIphoneWH)];
    _imvs.image=[UIImage imageNamed:@"我的资料-分割线"];
    [self.contentView addSubview:_imvs];
    _imv=[[UIImageView alloc]initWithFrame:CGRectMake(15*KIphoneWH, 15*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    _imv.image=[UIImage imageNamed:@"shop@2x"];
    [self.contentView addSubview:_imv];
  _brandname=[[UILabel alloc]initWithFrame:CGRectMake(50*KIphoneWH, 5*KIphoneWH, WIDTH-100*KIphoneWH, 40*KIphoneWH)];
    //CartModel *m=[muarr[section]objectAtIndex:0];
    
   // brandname.text=[NSString stringWithFormat:@"%@ >",m.orderNo];
    [self.contentView addSubview:_brandname];
    _zlabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-100*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 40*KIphoneWH)];
    _zlabel.textColor=[UIColor colorWithRed:238/255.0 green:80/255.0 blue:55/255.0 alpha:1];
    _zlabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_zlabel];




}
@end
