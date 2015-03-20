//
//  JRFBaseModel.h
//  JRFProject
//
//  Created by feng jia on 15-2-28.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import <Foundation/Foundation.h>


//TODO: 定义属性时请不要定义nsnumber类型，否则copy时会出现问题

@interface JRFBaseModel : NSObject<NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)strForKey:(NSString *)key;
- (NSArray *)arrForKey:(NSString *)key;
- (NSDictionary *)dictForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;

- (void)memcpy:(char *)agePtr value:(NSNumber *)value;
@end
