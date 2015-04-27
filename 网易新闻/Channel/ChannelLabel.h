//
//  ChannelLabel.h
//  网易新闻
//
//  Created by WR on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelLabel : UILabel

+ (instancetype)channelLabelWithTitle:(NSString *)title;

/**
 *  在切换频道过程中比例的变化.scale 变化范围是 0 - 1
 */
@property (assign, nonatomic) CGFloat scale;
@end
