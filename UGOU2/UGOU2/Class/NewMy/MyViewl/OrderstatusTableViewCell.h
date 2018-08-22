//
//  OrderstatusTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/25.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderstatusTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftimageview;
//右面背景图片
@property(nonatomic,strong)UIImageView *backimageview;
//物流状态的时间
@property(nonatomic,strong)UILabel *timelable;
//物流状态的名字
@property(nonatomic,strong)UILabel *namelable;
//物流状态详情
@property(nonatomic,strong)UILabel *titlelable;
@end
