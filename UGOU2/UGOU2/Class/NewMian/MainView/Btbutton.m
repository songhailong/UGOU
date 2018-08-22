//
//  Btbutton.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/2/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "Btbutton.h"

@implementation Btbutton
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
      self.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        
        [self addSubview:_imageview];
        
    }
    return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
