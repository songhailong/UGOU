//
//  TwobrandTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/20.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwobrandTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *fistbutton;
@property(nonatomic,strong)UIButton *secondbutton;
@property(nonatomic,strong)UIButton *threedbutton;
@property(nonatomic,copy)void(^myblock)(NSInteger text);
@end
