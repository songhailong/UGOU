//
//  ProductTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/30.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Uikility.h"
@implementation ProductTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc]init];
        //从黑色到白色的渐变色，0 - 1;越接近0越黑，越接近1越白
        //view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.selectedBackgroundView = view;
        
    }
    return self;
}
-(void)createSubViews{
    _textlable=[[UILabel alloc] initWithFrame:CGRectMake(20*KIphoneWH, 5*KIphoneWH, WIDTH/2, 34*KIphoneWH)];
    //_textlable.text=@"产品参数";
    [self.contentView addSubview:_textlable];
    
    
    //cell.textLabel.text=@"产品参数";
    _titlable=[[UILabel alloc] initWithFrame:CGRectMake(15*KIphoneWH, 44*KIphoneWH, WIDTH-30*KIphoneWH, 176*KIphoneWH)];
    _titlable.numberOfLines=0;
    _titlable.font=[UIFont systemFontOfSize:14*KIphoneWH];
   // NSString *canshu=[[_dictionary objectForKey:@"goods"]objectForKey:@"goodsIntro"];
    //_titlable.text=canshu;
    _titlable.alpha=0;
    [self.contentView addSubview:_titlable];


}

@end
