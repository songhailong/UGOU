//
//  PlaceTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/16.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *conslabel;
@property(nonatomic,strong)UILabel *mobilelabel;
@property(nonatomic,strong)UILabel *deaddlabel;
@property(nonatomic,strong)UILabel *ziplabel;
@property(nonatomic,strong)UILabel *arealabel;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,copy)void(^myblock)(NSInteger text);
@end
//consignee  mobile area deaddress zipcode