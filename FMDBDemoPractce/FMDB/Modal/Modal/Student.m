//
//  Student.m
//  FMDBSingle
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (Student *)createStudetnWith:(NSDictionary *)dic {
    Student *stu = [[Student alloc] init];
    [stu setValuesForKeysWithDictionary:dic];
    return stu;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n%@\n%@\n%@", _stuName, _stuAge, _stuSex];
}

@end
