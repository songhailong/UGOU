//
//  DgFootview.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/18.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "DgFootview.h"
#import "Uikility.h"
@implementation DgFootview
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
    //UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, table1.frame.size.width, 100*KIphoneWH)];
    
  self.contentView.backgroundColor=[UIColor whiteColor];
    _brandname=[[UILabel alloc]initWithFrame:CGRectMake(20*KIphoneWH, 5*KIphoneWH, WIDTH-40*KIphoneWH, 30*KIphoneWH)];
        //brandname.text=[NSString stringWithFormat:@"共%d件商品,合计:￥%.2f ",gs,pic];
    _brandname.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_brandname];
    _imvs=[[UIImageView alloc]initWithFrame:CGRectMake(0, 42*KIphoneWH, WIDTH, 1*KIphoneWH)];
    _imvs.image=[UIImage imageNamed:@"我的资料-分割线"];
    [self.contentView addSubview:_imvs];
    
    //_but1=[UIButton buttonWithType:UIButtonTypeCustom];
    _but1=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-320*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH)];
    
    
    [self.contentView addSubview:_but1];
    
     //_but2=[UIButton buttonWithType:UIButtonTypeCustom];
    _but2=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-320*KIphoneWH+110*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH)];
    //_but2=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-320*KIphoneWH+110*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH)];
    
   
    [self.contentView addSubview:_but2];
     // _but3=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _but3=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-320*KIphoneWH+220*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH)];
//    //_but3=CGRectMake(WIDTH-320*KIphoneWH+220*KIphoneWH, 50*KIphoneWH, 90*KIphoneWH, 30*KIphoneWH);
   [_but2 setBackgroundImage:[UIImage imageNamed:@"线上支付"] forState:UIControlStateNormal];
//    //[view.but2 addTarget:self action:@selector(xszhifu:) forControlEvents:UIControlEventTouchUpInside];
    [ _but3 setBackgroundImage:[UIImage imageNamed:@"线下支付"] forState:UIControlStateNormal];
//   // [view.but3 addTarget:self action:@selector(xzhifu:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.contentView addSubview:_but3];


}

@end
