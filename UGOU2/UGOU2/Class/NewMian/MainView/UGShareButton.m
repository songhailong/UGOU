//
//  UGShareButton.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/6/28.
//
//

#import "UGShareButton.h"
#import "Uikility.h"
@implementation UGShareButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView=[[UIImageView alloc] init];
        [self addSubview:_iconView];
    }
    return _iconView;

}
-(UILabel *)titlelable{
    if (!_titlelable) {
        _titlelable=[[UILabel alloc] init];
        _titlelable.font=[UIFont systemFontOfSize:15*KIphoneWH];
        _titlelable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titlelable];
    }
    return _titlelable;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat shareW=self.frame.size.width;
    CGFloat shareH=self.frame.size.height;
    _iconView.frame=CGRectMake(0, 0, shareW, shareW);
    _titlelable.frame=CGRectMake(0, shareW, shareW, shareH-shareW-5);
}
@end
