//
//  CouponsModel.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/3/1.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "CouponsModel.h"

@implementation CouponsModel

+(instancetype)initWithModeldic:(NSDictionary *)dic{
    CouponsModel *model=[[CouponsModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];

    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.brandName forKey:@"brandName"];
    [aCoder encodeObject:self.days forKey:@"days"];
    [aCoder encodeObject:self.preid forKey:@"preid"];
    [aCoder encodeObject:self.flag forKey:@"flag"];
    [aCoder encodeObject:self.money01 forKey:@"money01"];
    [aCoder encodeObject:self.money02 forKey:@"money02"];
    [aCoder encodeObject:self.come forKey:@"come"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.validity forKey:@"validity"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.regulation forKey:@"regulation"];
    [aCoder encodeObject:self.buttag forKey:@"buttag"];
       [aCoder encodeObject:self.brandids forKey:@"brandids"];
    [aCoder encodeObject:self.userVoucherId forKey:@"userVoucherId"];
    [aCoder encodeObject:self.banner forKey:@"banner"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
    [aCoder encodeObject:self.intro forKey:@"intro"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeBool:self.receiveFlag forKey:@"receiveFlag"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super init];
    if (self) {
        self.brandName=[aDecoder decodeObjectForKey:@"brandName"];
        self.days=[aDecoder decodeObjectForKey:@"days"];
        self.preid=[aDecoder decodeObjectForKey:@"preid"];
        self.flag=[aDecoder decodeObjectForKey:@"flag"];
        self.money01=[aDecoder decodeObjectForKey:@"money01"];
        self.money02=[aDecoder decodeObjectForKey:@"money02"];
        self.come=[aDecoder decodeObjectForKey:@"come"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.validity=[aDecoder decodeObjectForKey:@"validity"];
        self.id=[aDecoder decodeObjectForKey:@"id"];
        self.flag=[aDecoder decodeObjectForKey:@"flag"];
        self.regulation=[aDecoder decodeObjectForKey:@"regulation"];
        self.buttag=[aDecoder decodeObjectForKey:@"buttag"];
        self.brandids=[aDecoder decodeObjectForKey:@"brandids"];
        self.userVoucherId=[aDecoder decodeObjectForKey:@"userVoucherId"];
        self.banner=[aDecoder decodeObjectForKey:@"banner"];
        self.img=[aDecoder decodeObjectForKey:@"img"];
        self.imgUrl=[aDecoder decodeObjectForKey:@"imgUrl"];
        self.intro=[aDecoder decodeObjectForKey:@"intro"];
        self.title=[aDecoder decodeObjectForKey:@"title"];
        self.receiveFlag=[aDecoder decodeBoolForKey:@"receiveFlag"];
    }
    return self;
}

@end
