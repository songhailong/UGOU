//
//  CardTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/2/26.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^shareBtnBlock) (NSString *strValue);
@interface CardTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *iocnimageviedw;
@property(nonatomic,strong)UILabel *timelable;
@property(nonatomic,strong)UILabel *namelable;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UILabel *propolable;
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)UIView *tovidew;
@property(nonatomic,strong)UIButton *but;
@property(nonatomic,strong)UIButton *shareBt;
@property(nonatomic,strong)UIImageView *shareImageview;
@property(nonatomic, copy) shareBtnBlock shareClickBlock;
@end
