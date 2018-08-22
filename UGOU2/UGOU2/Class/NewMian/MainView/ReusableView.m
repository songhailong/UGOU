//
//  ReusableView.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/6.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ReusableView.h"
#import "Uikility.h"
@implementation ReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
       // _view.backgroundColor=[UIColor blueColor];
        [self addSubview:_view];
    }
    return self;
}

@end
