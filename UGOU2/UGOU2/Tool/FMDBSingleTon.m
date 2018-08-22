//
//  FMDBSingleTon.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/1/19.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "FMDBSingleTon.h"
#import "FMDB.h"
static FMDatabase *_db;
@implementation FMDBSingleTon

+(FMDBSingleTon*)shareSinglotn{
    static FMDBSingleTon *singleTon;
    @synchronized(self) {
        if (singleTon==nil) {
            singleTon=[[FMDBSingleTon alloc] init];
            NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"goods.sqlite"];
            //创建数据库
            _db=[FMDatabase databaseWithPath:path];
            [_db open];
            //创建表格
            [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, shop blob NOT NULL)"];

        }
    }
    return singleTon;
}
-(void)addshop:(CartModel *)model{
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:model ];
    [_db executeUpdate:@"INSERT INTO t_shop(shop) VALUES (?)",data];
    
}
-(NSArray *)selectshop{
    FMResultSet *set=[_db executeQuery:@"SELECT *FROM t_shop"];
    NSMutableArray *array=[NSMutableArray array];
    while (set.next) {
        NSData *data=[set objectForColumnName:@"shop"];
        CartModel *model=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:model];
    }
    return array;
}

@end
