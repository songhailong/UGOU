//
//  VipOrCartTableViewCell.h
//  UgouAppios
//
//  Created by 靓萌服饰靓萌服饰 on 16/10/28.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VipCardDelegate <NSObject>
//删除的代理
-(void)removecellindex:(NSNumber*)cardGoodsId indexPath:(NSIndexPath*)indexPath cellTag:(NSInteger)cellTag;
//选中的代理
-(void)selectCellindexarr:(NSArray *)indexarr indexPath:(NSIndexPath*)indexPath cellTag:(NSInteger)cellTag IsSelect:(BOOL)IsSelect;

//头视图选中的和取消的代理
-(void)heardViewSelectSection:(NSInteger)Section cellTag:(NSInteger)cellTag IsSelect:(BOOL)IsSelect;

@end
@interface VipOrCartTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
//数据源
@property(nonatomic,assign)NSArray *dataarray;
//
@property(nonatomic,copy)void(^block)(NSString *text);

@property(nonatomic,strong)NSDictionary * discountDic;

//删除，选中，操作的代理指针
@property(nonatomic,assign)id<VipCardDelegate>delegate;
//cell标记
@property(nonatomic,assign)NSInteger celltag;
//刷新
-(void)reloadtabview:(NSArray *)array isEidingAll:(BOOL)isEidingAll;
+(void)cellSelectAll;

+(void)IseditorAll:(BOOL)IseditorAll;

@end
