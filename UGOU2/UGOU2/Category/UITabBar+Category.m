//
//  UITabBar+Category.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/17.
//

#import "UITabBar+Category.h"
#define TabbarItemNums 5.0
@implementation UITabBar (Category)
-(void)showBadgeOnItemIdex:(int)index{
    [self removeBadgeOnItemIndex:index];
    UIView *bageView=[[UIView alloc] init];
    bageView.tag=888+index;
    bageView.layer.cornerRadius=5;
    bageView.backgroundColor=[UIColor redColor];
    CGRect tabframe=self.frame;
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabframe.size.width);
    CGFloat y = ceilf(0.1 * tabframe.size.height);
    bageView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:bageView];
}
-(void)hideBadgeOnItemIdex:(int)index{
    
     [self removeBadgeOnItemIndex:index];
}
-(void)removeBadgeOnItemIndex:(int)index{
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
    
}
@end
