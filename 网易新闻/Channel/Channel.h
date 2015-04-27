//
//  Channel.h
//  网易新闻
//
//  Created by WR on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (copy, nonatomic) NSString *tname;
@property (copy, nonatomic) NSString *tid;
@property (copy, nonatomic, readonly) NSString *urlString;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)channelWithDict:(NSDictionary *)dict;

/**
 *  返回频道数组
 */
+ (NSArray *)channels;
@end
