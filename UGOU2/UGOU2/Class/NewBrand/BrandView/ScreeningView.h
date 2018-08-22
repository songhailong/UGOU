//
//  ScreeningView.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/17.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableDictionary *jsondic;
@property(nonatomic,strong)UICollectionView *colectionview;
@property(nonatomic,strong)NSMutableArray *dataarray;
@property(nonatomic,copy)void (^secreeblock)(NSMutableDictionary *dic);
@end
