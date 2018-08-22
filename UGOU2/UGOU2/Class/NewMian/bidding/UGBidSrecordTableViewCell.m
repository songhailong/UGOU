//
//  UGBidSrecordTableViewCell.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/28.
//

#import "UGBidSrecordTableViewCell.h"
#import "UGHeader.h"
@implementation UGBidSrecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self ug_loadUI];
    }
    return self;
}
-(void)ug_loadUI{
//    CGRect frame=self.contentView.frame;
//    CGFloat with=frame.size.width;
//    CGFloat height=frame.size.height;
    _stateLable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 0, WIDTH/8, 30*KIphoneWH)];
    _stateLable.font=[UIFont systemFontOfSize:13*KIphoneWH];
    
    _numberLable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/8+5*KIphoneWH, 0, WIDTH/4, 30*KIphoneWH)];
    _numberLable.font=[UIFont systemFontOfSize:13*KIphoneWH];
    _priceLable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/8+WIDTH/4+5*KIphoneWH, 0, WIDTH/4-10*KIphoneWH, 30*KIphoneWH)];
    _priceLable.font=[UIFont systemFontOfSize:13*KIphoneWH];
    _timeLable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/8+WIDTH/2+5*KIphoneWH-10*KIphoneWH, 0, WIDTH/8*3-5*KIphoneWH+10*KIphoneWH, 30*KIphoneWH)];
    _timeLable.font=[UIFont systemFontOfSize:13*KIphoneWH];
    _stateLable.textColor=UGColor(63, 63, 63);
    _priceLable.textColor=UGColor(63, 63, 63);
    _numberLable.textColor=UGColor(63, 63, 63);
    _timeLable.textColor=UGColor(63, 63, 63);
    [self.contentView addSubview:_stateLable];
    [self.contentView addSubview:_numberLable];
    [self.contentView addSubview:_priceLable];
    [self.contentView addSubview:_timeLable];
}
@end
