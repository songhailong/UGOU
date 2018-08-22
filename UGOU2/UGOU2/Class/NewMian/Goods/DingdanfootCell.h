//
//  DingdanfootCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/7.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DingdanfootCell : UITableViewCell
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)UIButton *uhbutton;
@property(nonatomic,strong)UILabel *lables;
@property(nonatomic,copy)void(^mycellbloick)(NSInteger number);
@end
