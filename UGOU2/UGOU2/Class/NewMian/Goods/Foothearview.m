    //
//  Foothearview.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "Foothearview.h"
#import "Uikility.h"
#import "DingdanViewController.h"
@implementation Foothearview

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithReuseIdentifier:reuseIdentifier];
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
    //[_uhbutton addTarget:self action:@selector(changeNumbertwo:) forControlEvents:UIControlEventTouchUpInside];
//    [_uhbutton setBackgroundImage:[UIImage imageNamed:@"使用优惠券-@2x"] forState:UIControlStateNormal];
//    [_uhbutton setBackgroundImage:[UIImage imageNamed:@"使用优惠券-选中@2x"] forState:UIControlStateSelected];
    [view addSubview:_uhbutton];
    [self.contentView addSubview:view];

//    void(^vcvblock)(NSInteger value)=^(NSInteger value){
//                        if(value)
//                        {
//                     _uhbutton.selected=YES;
//                            ////////////////////////NSLog(@"============%zd",_uhbutton.tag);
//                        }
//                    };
//    DingdanViewController *ding=[[DingdanViewController alloc] init];
//                  ding.  mysblock=vcvblock;
//        //
    

    
}
-(void)changeNumbertwo:(UIButton *)b{
    if (b.selected) {
        b.selected=NO;
    }else
    {
        b.selected=YES;
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
