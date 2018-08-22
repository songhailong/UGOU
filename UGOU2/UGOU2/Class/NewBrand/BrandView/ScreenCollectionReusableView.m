//
//  ScreenCollectionReusableView.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/6.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ScreenCollectionReusableView.h"

@implementation ScreenCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatui];
       
    }

    return self;


}
-(void)creatui{
   

    _titlelable=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_titlelable];



}
@end
