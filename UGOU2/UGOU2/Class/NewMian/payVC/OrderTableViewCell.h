//
//  OrderTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/4.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *slabel;
//@property(nonatomic,strong) UIButton *uhbutton;
//@property(nonatomic,strong)UILabel *lastlable;
//@property(nonatomic,strong)UITextField *flide;
@property(nonatomic,strong)UIImageView *iconimagview;
@property(nonatomic,strong)UIButton *iconbtn;
@property(nonatomic,strong)UIImageView *titleimgview;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *attlabel;
@property(nonatomic,strong)UILabel *priclelabel;
@property(nonatomic,strong)UILabel *quartlabel;
//@property(nonatomic,strong)UIButton *uhbutton;
@property(nonatomic,copy)void(^orderblock)(NSInteger text);
@end
