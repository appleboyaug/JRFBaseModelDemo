//
//  JRFArchiverModel.m
//  JRFProject
//
//  Created by feng jia on 15-2-28.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "JRFArchiverModel.h"
#import <objc/runtime.h>

@implementation JRFArchiverModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    //遍历该类的属性值
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        //根据属性值和属性名进行necode
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    free(properties);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        //遍历该类的属性值
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (i = 0; i < outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            //decode取出属性值
            id propertyValue = [aDecoder decodeObjectForKey:propertyName];
            //给变量赋值
            NSString *ivarName = [NSString stringWithFormat:@"_%@", propertyName];
            Ivar ivar = class_getInstanceVariable([self class], [ivarName UTF8String]);
            //如果属性是int，float，double，bool需要做特殊处理
            if ([propertyValue isKindOfClass:[NSNumber class]]) {
                NSLog(@"number");
                
                ptrdiff_t ageOffset = ivar_getOffset(ivar);
                char *agePtr = ((char *)(__bridge void *)self) + ageOffset;
                [self memcpy:agePtr value:propertyValue];
            } else {
                
                //通过属性名获取到变量，并给新类的该变量赋值
                object_setIvar(self, ivar, propertyValue);
            }
            
        }
        free(properties);
    }
    return self;
}

@end
