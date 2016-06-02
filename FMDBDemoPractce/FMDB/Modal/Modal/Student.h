//
//  Student.h
//  FMDBSingle
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *stuName;
@property (nonatomic, copy) NSString *stuAge;
@property (nonatomic, copy) NSString *stuSex;

+ (Student *)createStudetnWith:(NSDictionary *)dic;

@end
