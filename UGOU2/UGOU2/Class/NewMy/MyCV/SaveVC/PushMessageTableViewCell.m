//
//  PushMessageTableViewCell.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/20.
//

#import "PushMessageTableViewCell.h"
#import "UGHeader.h"
@implementation PushMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView.backgroundColor=[UIColor clearColor];
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI{
   
    _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 0, 60*KIphoneWH, 60*KIphoneWH)];

    [self.contentView addSubview:_titleLable];
    _textLable=[[UILabel alloc] initWithFrame:CGRectMake(60*KIphoneWH, 0, WIDTH-130*KIphoneWH, 60*KIphoneWH)];
    [self.contentView addSubview:_textLable];
    _timeLable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-70*KIphoneWH, 0, 65*KIphoneWH, 60*KIphoneWH)];
    [self.contentView addSubview:_timeLable];
    _textLable.numberOfLines=0;
    _titleLable.numberOfLines=2;
    _timeLable.numberOfLines=2;
    _textLable.textColor=[UIColor blackColor];
    _textLable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    //_textLable.backgroundColor=[UIColor redColor];
    _timeLable.font=[UIFont systemFontOfSize:12*KIphoneWH];
    _titleLable.font=[UIFont systemFontOfSize:18*KIphoneWH];
}
@end
