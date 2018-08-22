//
//  CountdownVidew.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/14.
//

#import <UIKit/UIKit.h>
//static NSString * const SecondskillEndNotifi=@"SecondskillEndNotifi";
@interface CountdownVidew : UIView
/**结束时间*/
@property(nonatomic,assign)long time;
/**时间框背景色*/
@property(nonatomic,strong)UIColor *timelableBackColor;

@property(nonatomic,strong)UIFont *timeLableFont;

@property(nonatomic,strong)UIColor *timeTextColor;

/**时*/
@property(nonatomic,strong)UILabel *WhenLable;
/**分*/
@property(nonatomic,strong)UILabel *pointsLable;
/**秒*/
@property(nonatomic,strong)UILabel *secondsLable;


@property(nonatomic,strong)UILabel *textOneLable;
@property(nonatomic,strong)UILabel *textTwoLable;
@end
