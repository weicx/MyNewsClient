//
//  ChannelCell.h
//  网易新闻
//
//  Created by apple on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

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
