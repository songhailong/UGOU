//
//  UGOfferPresentationController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/26.
//

#import "UGOfferPresentationController.h"
#import "UGHeader.h"
//负责专场动画对象
@implementation UGOfferPresentationController
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
    self.presentedView.frame=CGRectMake(0, HEIGHT-200*KIphoneWH, WIDTH, 200*KIphoneWH);
    self.presentedView.backgroundColor=[UIColor whiteColor];
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
