//
//  SelectColorView.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/19.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SelectObjctType){
    SelectObjctTypeColor,
    SelectObjctTypeSize,
   
};
@protocol SelectColorDelegate <NSObject>
-(void)selectItemIndex:(NSInteger)item view:(UIView*)view;
@end
@interface SelectColorView : UIView
@property(nonatomic,strong)NSArray *msGoodModels;
@property(nonatomic,strong)UICollectionView *collectionview;
@property(nonatomic,weak)id<SelectColorDelegate>delegate;
@property(nonatomic,assign)SelectObjctType selectType;
@end
