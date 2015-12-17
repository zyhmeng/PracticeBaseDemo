//
//  FMDBViewController.m
//  功能Demo
//
//  Created by 123 on 15/10/22.
//  Copyright (c) 2015年 张育豪. All rights reserved.
//

#import "FMDBViewController.h"



@interface FMDBViewController ()
@property (nonatomic, strong) FMDatabase *db;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UILabel *selectName;
@property (weak, nonatomic) IBOutlet UILabel *selectPrice;

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //拼接文件名
    NSString *filePath = [path stringByAppendingPathComponent:@"shop.sqlite"];
    
    //打开数据库
    _db = [FMDatabase databaseWithPath:filePath];
    
    
    if ([_db open]) {
        NSLog(@"打开成功");
        }else
        {
        NSLog(@"打开失败");
        }
    
    //创表
     BOOL flag = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, name text NOT NULL, price real);"];
    if (flag) {
        NSLog(@"创建成功");
    }else
    {
        NSLog(@"创建失败");
    }
    
    [self insert];
}

- (IBAction)addShop:(id)sender {
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_shop(name, price) VALUES (%@, %@);", self.name.text, self.price.text];
    
}
- (IBAction)selectShop:(id)sender {
    
    FMResultSet *result =  [_db executeQuery:@"SELECT * FROM t_shop"];
    // 从结果集里面往下找
    while ([result next]) {
        
        
//        NSString *name = [result stringForColumn:@"name"];
        NSString *name = [result stringForColumn:[NSString stringWithFormat:@"%@",self.name.text]];
//        NSString *price = [result stringForColumn:@"price"];
        self.selectName.text = name;
        
        
        
        
    }
}
- (IBAction)delete:(id)sender {
    
    [_db executeUpdate:@"DELETE FROM t_shop WHERE name = %@ price = %@",self.name.text,self.price.text];
}

- (void)insert
{
        for (int i = 0; i<100; i++) {
            NSString *name = [NSString stringWithFormat:@"shouji-%d", i];
            NSLog(@"%@",name);
            [self.db executeUpdateWithFormat:@"INSERT INTO t_shop(name, price) VALUES (%@, %d);", name, 66];
        }
    
}




@end
