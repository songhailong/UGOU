//
//  UGShareViewController.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/5/10.
//

#import <UIKit/UIKit.h>
@protocol UGShareDelegate <NSObject>
-(void)shareBtnClick:(NSInteger)index shareImage:(NSData *)shareImage shareUrl:(NSString *)shareUrl;
@end
@interface UGShareViewController : UIViewController
@property(nonatomic,weak)id <UGShareDelegate>Delegate;
@end
