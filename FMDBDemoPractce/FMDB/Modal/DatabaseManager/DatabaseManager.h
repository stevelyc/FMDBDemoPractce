//
//  DatabaseManager.h
//  FMDBSingle
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
//导入模型头文件

@interface DatabaseManager : NSObject

//1.声明单利方法
+ (DatabaseManager *)shareManager;

//2.声明数据库操作方法

//（1）增
- (void)insertDataWithArray:(NSArray *)array;
//传入一组模型 插入数据库

//（2）删
- (void)deleteDataWithArray:(NSArray *)array;
//传入一组模型 将模型的数据从数据库中删除

//（3）改
- (void)updateDataWithOld:(Student *)oldStud andNew:(Student *)newStu;
//传入旧的模型和新的模型 数据库中用新的替代旧的

//（4）查
- (NSArray *)selectAllDatas;
//查询数据库中所有数据 数组中都是数据模型对象

@end
