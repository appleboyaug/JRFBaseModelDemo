//
//  Person.m
//  BaseModelTest
//
//  Created by feng jia on 15-3-20.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        self.name = [self strForKey:@"name"];
        self.age = [[self strForKey:@"age"] intValue];
        self.introduction = [self strForKey:@"introduction"];
        self.price = [[self strForKey:@"price"] intValue];
        self.bMale = [[self strForKey:@"bmale"] boolValue];
    }
    return self;
}

- (void)toString {
    NSLog(@"name: %@, introduction: %@, age: %d, price: %f, bMale: %d", self.name, self.introduction, self.age, self.price, self.bMale);
}

@end
