//
//  News.m
//  网易新闻
//
//  Created by WR on 15-4-20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "News.h"
#import <objc/runtime.h>
#import "NetworkTools.h"

@implementation News

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        NSArray *properties = [self.class loadProperties];
        
        for (NSString *key in properties) {
            if (dict[key]) {
                [self setValue:dict[key] forKey:key];
            }
        }
    }
    return self;
}

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

+ (void)newsWithURLString:(NSString *)urlString completion:(void(^)(NSArray *))completion {
    // 断言！针对开发调试的校验，提示程序员某一个参数必须要符合条件！
    NSAssert(completion != nil, @"必须传入回调参数");
    
    [[NetworkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //获取第一个键值对应的字典数组
        NSArray *array = responseObject[[responseObject keyEnumerator].nextObject];
        //字典转模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [arrayM addObject:[self newsWithDict:dict]];
        }
        //将模型数组保存在block块代码中
        completion(arrayM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        });
    }];
}

+ (NSArray *)loadProperties {
    unsigned int count = 0;
    
    //返回值是所有属性的数组
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        //1.从数组中获取属性
        objc_property_t pty = properties[i];
        //2.拿到属性名称
        const char *cname = property_getName(pty);
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    //因为运行时是C语言的，所以要释放属性数组
    free(properties);
    
    return arrayM;
}
@end
