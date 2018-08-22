//
//  RetureView.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/22.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RetureView : UIView   <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,assign)NSMutableArray *array;
@property(nonatomic,copy)void(^returnblock)(NSInteger text,NSInteger index);
-(void)reloacollectionview;

@end
