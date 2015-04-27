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
    
    //断言
    NSAssert(completion != nil, @"没有传入 completion 参数");
    
    //网络加载数据
    [[NetworkTools sharedNetworkTools] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //获取字典数组
        NSArray *array = responseObject[@"headline_ad"];
        
        //字典转模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [arrayM addObject:[self headlineWithDict:dict]];
        }
        
        //将模型数组保存在block块代码中
        completion(arrayM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //弹窗提示网络加载错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络加载错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        });
    }];
}
@end
