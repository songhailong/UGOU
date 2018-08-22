//
//  UGCustomNavView.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/12.
//

#import <UIKit/UIKit.h>
@protocol UGCustomnNavViewDelegate<NSObject>
@optional
- (void)LeftItemAction;

- (void)rightItemAction;
@end
@interface UGCustomNavView : UIView
@property(nonatomic,weak)id<UGCustomnNavViewDelegate>Delegate;
@property(nonatomic,strong)UIImageView *backgroundView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *RightButton;
@property(nonatomic,strong)UIView *custemView;
@property(nonatomic,strong)UILabel *titleView;
@property(nonatomic,strong)NSString *title;
-(void)setLeftImage:(UIImage *)image;
-(void)setrightImage:(UIImage *)image;
@end
