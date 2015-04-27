//
//  Channel.m
//  网易新闻
//
//  Created by WR on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Channel.h"

@implementation Channel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        NSArray *properties = @[@"tname", @"tid", @"urlString"];
        [properties enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            if (dict[key]) {
                [self setValue:dict[key] forKey:key];
            }
        }];
    }
    return self;
}
+ (instancetype)channelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)channels {
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"topic_news" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //获取字典数组
    NSArray *dictArray = dict[@"tList"];
    //字典转模型
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArray.count];
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[self channelWithDict:dict]];
    }];
    
    //需要对模型进行排序，确保“头条”等频道顺序正确.按照tid的大小排序
    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(Channel *obj1, Channel *obj2) {
        return [obj1.tid compare:obj2.tid];//该方法是按升序排序的
    }];
}
    
- (void)setTid:(NSString *)tid {
    
    _tid = tid;
    
    _urlString = [NSString stringWithFormat:@"article/headline/%@/0-50.html", tid];
}
@end
