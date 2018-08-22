//
//  MainHearCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/2/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "MainHearCell.h"
#import "Uikility.h"
@implementation MainHearCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;

}
-(void)creatUI{
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150*KIphoneWH)];
    [self.contentView addSubview:_imageview];


}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
