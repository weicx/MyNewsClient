//
//  ChannelCell.h
//  网易新闻
//
//  Created by apple on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//
/**
 *  自定义ChannelCell的意义在于，将新闻视图加到collectionCell中来，同时保证新闻视图依然受其控制器控制
 */

#import <UIKit/UIKit.h>
@class NewsTableViewController;

@interface ChannelCell : UICollectionViewCell
/**
 *  新闻视图控制器
 */
@property (strong, nonatomic) NewsTableViewController *newsVC;
/**
 *  频道的 URL 字符串
 */
@property (copy, nonatomic) NSString *urlString;
@end
