//
//  ThemeCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/21.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ThemeCell.h"
#import "Uikility.h"
@implementation ThemeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    if (self) {
        [self creatViews];
    }
    return self;
}
-(void)creatViews{
    _titileimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WIDTH , 140*KIphoneWH)];
    //_titileimageview.frame=self.contentView.bounds ;
    [self.contentView addSubview:_titileimageview];

}
@end
