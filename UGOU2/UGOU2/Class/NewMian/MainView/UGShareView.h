//
//  UGShareView.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/6/28.
//
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,shareType) {
    UGShareTypeWX=0,
    UGShareTypeWeChat=1,
    UGShareTypeQQZone=2,
    UGShareTypeSina=3
};

@protocol UGShareViewDelegate
-(void)UGShareViewHide;
-(void)UGShareViewDidSelect:(shareType)shareType;
@end

@interface UGShareView : UIView
@property(nonatomic,assign)id delegate;
@end
