//
//  ViewController.m
//  BaseModelTest
//
//  Created by feng jia on 15-3-20.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *jsonDict = @{@"name": @"xiaoli",
                               @"introduction": @"希望你都好",
                               @"age": [NSNumber numberWithInt:20],
                               @"price": [NSNumber numberWithFloat:12.33],
                               @"bmale": [NSNumber numberWithBool:YES]};
    
    
    Person *p1 = [[Person alloc] initWithDictionary:jsonDict];
    [p1 toString];
    
    Person *p2 = [p1 copy];
    [p2 toString];
    
    //华丽的分割线------------------------------------------
    //-----------------------------------------------------
    
    
    jsonDict = @{@"name": @"lilei",
                 @"classname": @"一班",
                 @"age": [NSNumber numberWithInt:18],
                 @"scrore": [NSNumber numberWithFloat:98.33],
                 @"bmale": [NSNumber numberWithBool:NO]};
    Student *s1 = [[Student alloc] initWithDictionary:jsonDict];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"student.archiver"];
    NSLog(@"%@", filePath);
    //归档操作
    [NSKeyedArchiver archiveRootObject:s1 toFile:filePath];
    //从归档文件中读取数据
    Student *s2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [s2 toString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
