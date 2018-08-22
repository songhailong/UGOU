//
//  VideoStudyViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/3/30.
//
//

#import <UIKit/UIKit.h>
@protocol VideoIsHideBarDelegate <NSObject>

-(void)prefersVideoStatusBarHidden:(BOOL)ishiden;

@optional
-(void)changeStatusBarHidden:(BOOL)ishiden;
@end
@interface VideoStudyViewController : UIViewController

@property(nonatomic,weak)id<VideoIsHideBarDelegate>Delegate;
@end
