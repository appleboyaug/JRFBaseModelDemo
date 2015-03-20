//
//  JRFBaseModel.m
//  JRFProject
//
//  Created by feng jia on 15-2-28.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "JRFBaseModel.h"
#import <objc/runtime.h>

@interface JRFBaseModel ()

@property (nonatomic, strong) NSDictionary *resultDict;

@end

@implementation JRFBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary) {
            self.resultDict = [NSDictionary dictionaryWithDictionary:dictionary];
        } else {
            self.resultDict = [NSDictionary dictionary];
        }
    }
    return self;
}

- (NSString *)strForKey:(NSString *)key {
    if (key) {
        NSString *value = [self.resultDict objectForKey:key];
        if (value && ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])) {
            return [NSString stringWithFormat:@"%@", value];
        } else {
            NSLog(@"key type error (not string or not number)");
        }
    }
    return @"";
}

- (NSArray *)arrForKey:(NSString *)key {
    if (key) {
        NSArray *value = [self.resultDict objectForKey:key];
        if (value && [value isKindOfClass:[NSArray class]]) {
            return value;
        } else {
            NSLog(@"key type error (not array)");
        }
    }
    return nil;
}

- (NSDictionary *)dictForKey:(NSString *)key {
    if (key) {
        NSDictionary *value = [self.resultDict objectForKey:key];
        if (value && [value isKindOfClass:[NSDictionary class]]) {
            return value;
        } else {
            NSLog(@"key type error (not dictionary)");
        }
    }
    return nil;
}

- (NSNumber *)numberForKey:(NSString *)key {
    if (key) {
        NSNumber *value = [self.resultDict objectForKey:key];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            return value;
        } else {
            NSLog(@"key type error (not number)");
        }
    }
    return [NSNumber numberWithInt:0];
}


#define copy

- (id)copyWithZone:(NSZone *)zone {
    //根据类类型创建新类
    Class originClass = [self class];
    id newClass = [[originClass alloc] init];
    
    //遍历类的属性，获取属性名和属性值并给新类赋值
    unsigned int outCount, i;
    //取出所有属性
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        //获取属性名和属性值
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        NSString *ivarName = [NSString stringWithFormat:@"_%@", propertyName];
        Ivar ivar = class_getInstanceVariable([self class], [ivarName UTF8String]);
        //如果属性是int，float，double，bool需要做特殊处理
        if ([propertyValue isKindOfClass:[NSNumber class]]) {
            NSLog(@"number");
            
            ptrdiff_t ageOffset = ivar_getOffset(ivar);
            char *agePtr = ((char *)(__bridge void *)newClass) + ageOffset;
            [self memcpy:agePtr value:propertyValue];
        } else {
        
            //通过属性名获取到变量，并给新类的该变量赋值
            object_setIvar(newClass, ivar, propertyValue);
        }
    }
    free(properties);
    return newClass;
}

- (void)memcpy:(char *)agePtr value:(NSNumber *)value {
    if (strcmp([value objCType], @encode(float)) == 0) {
        float v = [value floatValue];
        memcpy(agePtr, &v, sizeof(v));
    } else if (strcmp([value objCType], @encode(double)) == 0) {
        double v = [value doubleValue];
        memcpy(agePtr, &v, sizeof(v));
    } else if (strcmp([value objCType], @encode(int)) == 0) {
        int v = [value intValue];
        memcpy(agePtr, &v, sizeof(v));
    } else if (strcmp([value objCType], @encode(long)) == 0) {
        long v = [value longValue];
        memcpy(agePtr, &v, sizeof(v));
    } else if (strcmp([value objCType], @encode(long long)) == 0) {
        long long v = [value longLongValue];
        memcpy(agePtr, &v, sizeof(v));
    } else {
        int v = [value intValue];
        memcpy(agePtr, &v, sizeof(v));
    }
}
@end
