//
//  PushModle.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2017/10/18.
//

#import <Foundation/Foundation.h>

@interface PushModle : NSObject
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSNumber *reTime;
@property(nonatomic,strong)NSString *title;
+(PushModle*)initWithDic:(NSDictionary *)dic;
@end
