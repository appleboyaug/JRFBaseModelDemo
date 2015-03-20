//
//  Person.h
//  BaseModelTest
//
//  Created by feng jia on 15-3-20.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRFArchiverModel.h"
@interface Person : JRFBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *introduction;
@property int age;
@property float price;
@property BOOL bMale;

- (void)toString;

@end
