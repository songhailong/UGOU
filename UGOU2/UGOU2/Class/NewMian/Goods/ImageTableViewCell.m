//
//  ImageTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/5/12.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "Uikility.h"
@implementation ImageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatuUI];
    }

    return self;
}
-(void)creatuUI{
    
    _imageview1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    //_imageview.backgroundColor=[UIColor redColor];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    //view.backgroundColor=[UIColor greenColor];
    [view addSubview:_imageview1];
    
    [self addSubview:view];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
