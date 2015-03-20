//
//  Student.h
//  BaseModelTest
//
//  Created by feng jia on 15-3-20.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRFArchiverModel.h"
@interface Student : JRFArchiverModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *className;
@property int age;
@property float score;
@property BOOL bMale;

- (void)toString;
@end
