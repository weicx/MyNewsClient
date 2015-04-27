//
//  News.h
//  网易新闻
//
//  Created by WR on 15-4-20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  摘要
 */
@property (copy, nonatomic) NSString *digest;
/**
 *  配图
 */
@property (copy, nonatomic) NSString *imgsrc;
/**
 *  跟帖数
 */
@property (assign, nonatomic) int replyCount;
/**
 *  多张配图
 */
@property (strong, nonatomic) NSArray *imgextra;
/**
 *  大图标记
 */
@property (assign, nonatomic) BOOL imgType;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsWithDict:(NSDictionary *)dict;

/**
 *  根据URL字符串加载新闻模型数组
 */
+ (void)newsWithURLString:(NSString *)urlString completion:(void(^)(NSArray *))completion;
@end
