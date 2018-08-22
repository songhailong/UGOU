//
//  UGBidSePriceTableViewCell.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/27.
//

#import "UGBidSePriceTableViewCell.h"
#import "UGHeader.h"
@implementation UGBidSePriceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self ug_creatUI];
        
    }
    return self;
}
-(void)ug_creatUI{
    _userNameLable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 100*KIphoneWH, 34*KIphoneWH)];
    _userNameLable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    
    [self.contentView addSubview:_userNameLable];
    _maxSellable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-150*KIphoneWH, 5*KIphoneWH, 100*KIphoneWH, 34*KIphoneWH)];
    _maxSellable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _pricelable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-50*KIphoneWH, 5*KIphoneWH, 50*KIphoneWH, 34*KIphoneWH)];
    _pricelable.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _pricelable.textColor=[UIColor redColor];
    [self.contentView addSubview:_pricelable];
    [self.contentView addSubview:_maxSellable];
}
@end
