//
//  NetworkTools.m
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

//单例
+ (instancetype)sharedNetworkTools {
    
    static NetworkTools *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        NSURL *URL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        
        //网络配置
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        tools = [[self alloc] initWithBaseURL:URL sessionConfiguration:config];
        
        //添加支持html的解析
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return tools;
}
@end
