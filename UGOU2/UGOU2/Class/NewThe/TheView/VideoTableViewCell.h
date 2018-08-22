//
//  VideoTableViewCell.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/4/1.
//
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VideoTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *iamgeView;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)UILabel *timeDurationLable;
@property(nonatomic,strong)UILabel *countLable;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *playBtn;
@property(nonatomic,strong)VideoModel *model;
@end
