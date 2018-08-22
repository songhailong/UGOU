//
//  UIButton+UGBtnCategory.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/5/10.
//

#import "UIButton+UGBtnCategory.h"

@implementation UIButton (UGBtnCategory)
-(void)setTitle:(NSString *)title forState:(UIControlState)state image:(UIImage*)iamge{
    [self setTitle:title forState:state];
    [self setImage:iamge forState:UIControlStateNormal];
    /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
//    CGFloat    space = 5;// 图片和文字的间距
//    NSString    * titleString = [NSString stringWithFormat:@"%@", title];
//    UIFont *font=self.titleLabel.font;
//    CGFloat    titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:font}].width;
//    CGFloat    titleHeight = [titleString sizeWithAttributes:@{NSFontAttributeName:font}].height;
//    UIImage    * btnImage = iamge;// 11*6
//    CGFloat    imageWidth = btnImage.size.width;
//    //[self setTitleEdgeInsets:UIEdgeInsetsMake(titleHeight*0.5 + space*0.5, -imageWidth*0.5, -(titleHeight*0.5 + space*0.5), imageWidth*0.5)];
//    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth, -(titleHeight*0.5 + space*0.5), 0)];
//    CGFloat    imageHeight = btnImage.size.height;
//    [self setImageEdgeInsets:UIEdgeInsetsMake(-(imageHeight*0.5 + space*0.5), titleWidth*0.5, imageHeight*0.5 + space*0.5, -titleWidth*0.5)];
    
     CGFloat offset =5.0f;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, -self.imageView.frame.size.height-offset/2, 0);
    
    
    //  self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, 0);
    self.titleLabel.backgroundColor=[UIColor greenColor];
    self.imageView.backgroundColor=[UIColor blueColor];
    NSLog(@"%@",NSStringFromCGRect(self.titleLabel.frame));
    // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height-offset/2, 0, 0, -button.titleLabel.frame.size.width);
    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
    //intrinsicContentSize  是自动计算size 当约束改变时需要手动更新
    self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -self.titleLabel.intrinsicContentSize.width);
    
}
@end
