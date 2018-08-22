//
//  VideoTableViewCell.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/4/1.
//
//

#import "VideoTableViewCell.h"
#import "Uikility.h"
@implementation VideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView.backgroundColor=[UIColor whiteColor];
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI{
//    _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, WIDTH-5*KIphoneWH, 20*KIphoneWH)];
//    _titleLable.font=[UIFont systemFontOfSize:17*KIphoneWH];
//    _titleLable.textColor=[UIColor blackColor];
    _descriptionLable=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-20*KIphoneWH, 30*KIphoneWH)];
    _descriptionLable.textColor=[UIColor colorWithRed:118/255.0 green:118/255.0 blue:118/255.0 alpha:1];
    //_descriptionLable.textColor=[UIColor blackColor];
    _descriptionLable.numberOfLines=2;
  
        _descriptionLable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    _iamgeView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180*KIphoneWH)];
    _iamgeView.userInteractionEnabled=YES;
    _playBtn=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2-30*KIphoneWH, 60*KIphoneWH, 60*KIphoneWH, 60*KIphoneWH)];
    [_playBtn setImage:[UIImage imageNamed:@"video_play_btn"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_iamgeView];
    //[_iamgeView addSubview:_titleLable];
    [_iamgeView addSubview:_descriptionLable];
    [_iamgeView addSubview:_playBtn];
}
@end
