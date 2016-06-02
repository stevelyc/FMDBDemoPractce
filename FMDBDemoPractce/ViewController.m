//
//  ViewController.m
//  FMDBDemoPractce
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@property (nonatomic, strong) FMDatabase *db;

@property (weak, nonatomic) IBOutlet UITextField *stuName;
@property (weak, nonatomic) IBOutlet UITextField *perName;
@property (weak, nonatomic) IBOutlet UITextField *petAge;

- (IBAction)Add:(UIButton *)sender;
- (IBAction)delete:(UIButton *)sender;
- (IBAction)updata:(UIButton *)sender;
- (IBAction)search:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createDB];
    [self createTable];
}

#pragma mark -- 创建数据库
- (void)createDB {
    NSString *path = [NSString stringWithFormat:@"%@/Documents/class.db", NSHomeDirectory()];
    NSLog(@"%@", path);
    _db = [[FMDatabase alloc] initWithPath:path];
    if ([_db open]) {
        NSLog(@"创建数据库成功");
    } else {
        NSLog(@"创建数据库失败");
    }
}

- (void)createTable {
    if ([_db open]) {
        NSString *sql = @"create table if not exists class (stuName varchar(20), petName varchar(20), petAge int)";
        if([_db executeUpdate:sql]) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Add:(UIButton *)sender {
    NSString *stuName = self.stuName.text;
    NSString *petName = self.perName.text;
    NSString *petAge = self.petAge.text;
    NSString *sql = [NSString stringWithFormat:@"insert into class values('%@', '%@', '%@')", stuName, petName, petAge];
    if ([_db executeUpdate:sql]) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}

- (IBAction)delete:(UIButton *)sender {
    NSString *sql = [NSString stringWithFormat:@"delete from class where stuName = '%@'", self.stuName.text];
    if ([_db executeUpdate:sql]) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

- (IBAction)updata:(UIButton *)sender {
    NSString *sql = [NSString stringWithFormat:@"update class set stuName = '%@' where stuName = 'chic'", self.stuName.text];
    if ([_db executeUpdate:sql]) {
        NSLog(@"更新成功");
    } else {
        NSLog(@"跟新失败");
    }
}

- (IBAction)search:(UIButton *)sender {
    NSString *sql = [NSString stringWithFormat:@"select * from class"];
    FMResultSet *rs = [_db executeQuery:sql];
    if ([_db executeQuery:sql]) {
        while ([rs next]) {
            NSLog(@"%@", [rs stringForColumn:@"stuName"]);
        }
    }
}

- (void)dealloc {
    [_db close];
}
@end
