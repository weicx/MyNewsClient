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
 *  返回模型数组 
 */
+ (void)headlineWithCompletion:(void (^)(NSArray *))completion;
@end
