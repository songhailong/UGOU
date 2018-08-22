//
//  BrandReusableView.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/11.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "BrandReusableView.h"

@implementation BrandReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _view=[[UIView alloc] initWithFrame:frame];
        [self addSubview:_view];

    }
    return self;

}
@end
