//
//  MainCollectionViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/6.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *textlable;
//现价
@property(nonatomic,strong)UILabel *pricelable;
//原价
@property(nonatomic,strong)UILabel *procelable;
@property(nonatomic,strong)UIImageView *imv;
@property(nonatomic,strong)UILabel *Uprice;
//销量
@property(nonatomic,strong)UILabel *salesLable;
@end
