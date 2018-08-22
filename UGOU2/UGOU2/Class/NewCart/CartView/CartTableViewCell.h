//
//  CartTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/5.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imview;
@property(nonatomic,strong)UILabel *  imlabel;
@property(nonatomic,strong)UILabel * qtlabel;
@property(nonatomic,strong)UILabel * jglabel;
@property(nonatomic,strong)UILabel *lplabel;
@property(nonatomic,strong)UILabel *gslabel;
@property(nonatomic,strong)UIButton *deleteBut;
@property(nonatomic,copy)void(^block)(NSString *text);
@end
