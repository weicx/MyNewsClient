//
//  Headline.h
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Headline : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *imgsrc;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)headlineWithDict:(NSDictionary *)dict;

/**
 *  返回模型数组  因为是去网络异步加载图片，所以不能直接返回数组，很有可能为空。要通过把数组保存在block里的方式来获取数组
 */
+ (void)headlineWithCompletion:(void (^)(NSArray *))completion;
@end
