//
//  Student.m
//  BaseModelTest
//
//  Created by feng jia on 15-3-20.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        self.name = [self strForKey:@"name"];
        self.age = [[self strForKey:@"age"] intValue];
        self.className = [self strForKey:@"classname"];
        self.score = [[self strForKey:@"score"] intValue];
        self.bMale = [[self strForKey:@"bmale"] boolValue];
    }
    return self;
}

- (void)toString {
    NSLog(@"name: %@, classname: %@, age: %d, score: %f, bMale: %d", self.name, self.className, self.age, self.score, self.bMale);
}
@end
