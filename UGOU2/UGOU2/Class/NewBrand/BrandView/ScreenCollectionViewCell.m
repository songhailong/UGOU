//
//  ScreenCollectionViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ScreenCollectionViewCell.h"
#import "Uikility.h"
@implementation ScreenCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
       // UIView *view=[[UIView alloc] init];
        //view.backgroundColor=[UIColor greenColor];
        //self.selectedBackgroundView=view;
        [self creatUI];
    }

    return self;
}
-(void)creatUI{
   // UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonclick:)];
    
    _titlelabla=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH/4, 30*KIphoneWH)];
    //_titlelabla.userInteractionEnabled=YES;
    _titlelabla.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _titlelabla.textColor=[UIColor blackColor];
    _titlelabla.textAlignment=NSTextAlignmentCenter;
   // [_titlelabla addGestureRecognizer:tap];
    [self.contentView addSubview:_titlelabla];
}
@end
