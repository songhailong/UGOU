//
//  UGMarginModel.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/26.
//

#import <Foundation/Foundation.h>

@interface UGMarginModel : NSObject
@property(nonatomic,copy)NSString *staus;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSNumber *maxSePrice;
@property(nonatomic,copy)NSString *Price;
@property(nonatomic,strong)NSNumber *reTime;
@property(nonatomic,strong)NSNumber *seprice;
+(UGMarginModel*)initModelWithDic:(NSDictionary *)dic;
@end
