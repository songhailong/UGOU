//
//  AttributeModel.h
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/16.
//

#import <Foundation/Foundation.h>

@interface AttributeModel : NSObject
/**颜色*/
@property(nonatomic,strong)NSString *color ;
/**尺码*/
@property(nonatomic,strong)NSString * size ;
/**库存数量*/
@property(nonatomic,strong)NSNumber * total;
/**尺码 颜色组合id*/
@property(nonatomic,strong)NSNumber *seUid;
/**能否变成不可选*/
@property(nonatomic,assign)BOOL isOptional;
/**是否选择*/
@property(nonatomic,assign)BOOL isSelect;
+(instancetype)initAttributeModelwithdic:(NSDictionary *)dic;
@end
