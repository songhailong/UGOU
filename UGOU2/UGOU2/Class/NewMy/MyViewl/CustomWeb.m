//
//  CustomWeb.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/5/19.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CustomWeb.h"
#import "Uikility.h"
@implementation CustomWeb
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super  initWithFrame:frame];
    if (self) {
        _view=[[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 50*KIphoneWH)];
        _view.backgroundColor=[UIColor colorWithRed:53.0/255.0 green:122.0/255.0 blue:196.0/255.0 alpha:1];
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(100*KIphoneWH, 0, WIDTH-200*KIphoneWH, 55*KIphoneWH)];
        lable.text=@"查询结果";
        lable.font=[UIFont systemFontOfSize:22*KIphoneWH];
        lable.textColor=[UIColor whiteColor];
        lable.textAlignment=NSTextAlignmentCenter;
//        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5*KIphoneWH, 10*KIphoneWH, 50*KIphoneWH, 30*KIphoneWH)];
//        [button setBackgroundImage:[UIImage imageNamed:@"webback_@2x.png"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchDown];
        [_view addSubview:lable];
       // [_view addSubview:button];
        [self addSubview:_view];
    }

    return self;
}
-(void)buttonclick{
    
    if (_WebBlock) {
       
        _WebBlock(1);
    }



}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
