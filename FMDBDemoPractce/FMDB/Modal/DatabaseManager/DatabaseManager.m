//
//  DatabaseManager.m
//  FMDBSingle
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDB.h"

#define DATABASE_NAME @"TestData.db"
//数据库文件名
#define TABLE_NAME @"Student"
//表格名

@interface DatabaseManager ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation DatabaseManager
#pragma mark -- 单利方法
+ (DatabaseManager *)shareManager {
    static DatabaseManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[DatabaseManager alloc] init];
        //创建数据和表格
        [shareManager createDataBaseAndTable];
    });
    return shareManager;
}

#pragma mark -- 创建
- (void)createDataBaseAndTable {
    //1.数据库创建
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), DATABASE_NAME];
    NSLog(@"%@", path);
    _dataBase = [[FMDatabase alloc] initWithPath:path];
    if ([_dataBase open]) {
        //如果数据库打开 继续创建表格
        //2.创建表格
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(stuName varchar(20), stuAge int, stuSex varchar(2))", TABLE_NAME];
        if ([_dataBase executeUpdate:sql]) {
            NSLog(@"创建表格成功");
        } else {
            NSLog(@"创建表格失败");
        }
    }
}

#pragma mark -- add
- (void)insertDataWithArray:(NSArray *)array {
    if (array == nil) {
        return ;
    }
    for (int i = 0; i < array.count; i++) {
        Student *stu = array[i];
        NSString *sql = [NSString stringWithFormat:@"insert into %@ values('%@', '%@', '%@')", TABLE_NAME, stu.stuName, stu.stuAge, stu.stuSex];
        [_dataBase executeUpdate:sql];
    }
}

#pragma mark -- delete
- (void)deleteDataWithArray:(NSArray *)array {
    if (!array) {
        return;
    }
    
    for (int i = 0; i < array.count; i++) {
        Student *stu = array[i];
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where stuName='%@' and stuAge='%@' and stuSex='%@'", TABLE_NAME, stu.stuName, stu.stuAge, stu.stuSex];
        [_dataBase executeUpdate:sql];
    }
}

#pragma mark -- update
//isEqual 比较内容和地址
- (void)updateDataWithOld:(Student *)oldStud andNew:(Student *)newStu {
    if (!oldStud || !newStu || [oldStud isEqual:newStu]) {
        return ;
    }
    NSString *sql = [NSString stringWithFormat:@"update %@ set stuName='%@', stuAge=%@, stuSex='%@' where stuName='%@' and stuAge=%@ and stuSex='%@'", TABLE_NAME, newStu.stuName, newStu.stuAge, newStu.stuSex, oldStud.stuName, oldStud.stuAge, oldStud.stuSex];
    [_dataBase executeUpdate:sql];
}

#pragma mark -- 查
- (NSArray *)selectAllDatas {
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select * from %@", TABLE_NAME];
    FMResultSet *set = [_dataBase executeQuery:sql];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"stuName"];
        NSString *age = [set stringForColumn:@"stuAge"];
        NSString *sex = [set stringForColumn:@"stuSex"];
        
        NSDictionary *dic = @{@"stuName":name, @"stuAge":age, @"stuSex":sex};
        Student *stu = [Student createStudetnWith:dic];
        [dataArr addObject:stu];
    }
    return dataArr;
}

- (void)dealloc {
    [_dataBase close];
}

@end
