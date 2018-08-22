//
//  UGColorCollectionViewCell.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/19.
//

#import "UGColorCollectionViewCell.h"

@implementation UGColorCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:178/255.0 green:205/255.0 blue:126/255.0 alpha:1];
        self.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _textLable.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _maskView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(UILabel *)textLable{
    if (!_textLable) {
        _textLable=[[UILabel alloc] init];
        _textLable.textColor=[UIColor blackColor];
       
        [self.contentView addSubview:_textLable];
    }
    return _textLable;
}
-(UIView*)maskView{
    if (!_maskView) {
        _maskView=[[UIView alloc] init];
        _maskView.backgroundColor=[UIColor whiteColor];
        _maskView.alpha=0;
        [_textLable addSubview:_maskView];
    }
    return _maskView;
}
@end
