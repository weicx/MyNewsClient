//
//  Headline.m
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Headline.h"
#import "NetworkTools.h"

@implementation Headline

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //定义属性数组
        NSArray *properties = @[@"title", @"imgsrc"];
        //遍历 赋值
        for (NSString *key in properties) {
            if (dict[key]) {
                [self setValue:dict[key] forKey:key];
            }
        }
    }
    return self;
}

+ (instancetype)headlineWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (void)headlineWithCompletion:(void (^)(NSArray *))completion {
    
    // 断言，提前预判某一个条件必须符合
    // 要求程序必须传入 completion，如果不，会崩溃
    // 断言是 C/C++ 程序员的最爱！主要用在调试过程中，提前预判条件，能够在实际过程中，
    // 如果传递的参数有误，会直接崩溃，提醒程序员检查传递参数！
    // 在发布的版本中，断言不会有任何影响！
    NSAssert(completion != nil, @"没有传入 completion 参数");
    
    //网络加载数据
    [[NetworkTools sharedNetworkTools] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //获取字典中的数组，得到数据的字典数组
        NSArray *array = responseObject[@"head_ad"];
        //字典转模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [arrayM addObject:[self headlineWithDict:dict]];
        }
        
        //将模型数组保存在block块代码中
        completion(arrayM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@", error);
            //弹窗提示网络加载错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络加载错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        });
    }];
}
@end
