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
        //URL
        NSURL *URL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        //Configuration (全局共享的网络配置)
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        tools = [[self alloc] initWithBaseURL:URL sessionConfiguration:config];
        //因为网易的数据是html格式的，AFN默认的不支持解析，需要手动添加支持html的解析
        // 设置能够解析的 JSON 格式
        /**
         1. 以下方法是官方推荐的方法，直接修改 acceptableContentTypes
         2. 民间的做法，直接修改 AFN 的源代码
         
         提示：如果使用第三方框架，不建议私自修改源程序，用 fork
         - 建立一个分支到自己的 github 空间
         - 自己修改测试
         - pull requst（推送请求，发送给作者）
         - 作者审核代码，接受修改
         - 全世界的使用者共享
         
         * 很多的第三方框架，都是全世界的程序员一起维护的！
         */
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];//数组中是可接收、可识别的数据类型
    });
    return tools;
}
@end
