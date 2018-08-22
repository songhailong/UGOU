//
//  DgTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/15.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DgTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *goodsimv;
@property(nonatomic,strong)UILabel *goodsname;
@property(nonatomic,strong)UILabel *attlabel;
@property(nonatomic,strong)UILabel *pircelabel;
@property(nonatomic,strong)UILabel *qulable;
@property(nonatomic,strong)UIButton *deletebut;
//评价
@property(nonatomic,strong)UIButton *pjbut;
//退货
@property(nonatomic,strong)UIButton *thbut;
@property(nonatomic,copy)void(^block)(NSInteger text);
@end
