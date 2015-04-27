//
//  NewsCell.h
//  网易新闻
//
//  Created by WR on 15-4-20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
@interface NewsCell : UITableViewCell

@property (strong, nonatomic) News *news;
/**
 *  根据模型确定可重用表示符号并返回
 */
+ (NSString *)cellIdentifier:(News *)news;
/**
 *  根据模型计算cell行高并返回
 */
+ (CGFloat)rowHeight:(News *)news;
@end
