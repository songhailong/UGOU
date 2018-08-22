//
//  SearchCollectionViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/27.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#import "Uikility.h"
@implementation SearchCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        _titlelable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 10*KIphoneWH, (WIDTH-20*KIphoneWH)/2, 30*KIphoneWH)];
        _titlelable.font=[UIFont systemFontOfSize:18*KIphoneWH];
        _titlelable.textAlignment=  NSTextAlignmentLeft;
        UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, (WIDTH-20*KIphoneWH)/2, 40*KIphoneWH)];
        UIImage *image=[UIImage imageNamed:@"圆角矩形-14@2x.png"];
        imageview.image=image;
        [self.contentView addSubview:imageview];
        [self.contentView addSubview:_titlelable];
        
    }
    return self;
}
@end
