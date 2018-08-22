//
//  UGVoucherPresentationController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/5/7.
//

#import "UGVoucherPresentationController.h"
#import "Uikility.h"
@implementation UGVoucherPresentationController
-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    /**
     presentedView  被展现视图
     presenting    发起试图
     */
    return [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}
-(void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    //展现视图 大小
    self.presentedView.frame=CGRectMake(0, HEIGHT-500*KIphoneWH, WIDTH, 500*KIphoneWH);
    //self.presentedView.backgroundColor=[UIColor whiteColor];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.4;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseTapAction)];
    [view addGestureRecognizer:tap];
    [self.containerView insertSubview:view atIndex:0];
}
-(void)CloseTapAction{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
