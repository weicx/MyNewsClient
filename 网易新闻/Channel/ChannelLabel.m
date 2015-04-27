//
//  ChannelLabel.m
//  网易新闻
//
//  Created by WR on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChannelLabel.h"


#define SelectedFontSize   18.0
#define NormalFontSize     14.0
@implementation ChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {

    ChannelLabel *label = [[self alloc] init];
    label.text = title;
    
    //设置大字体
    label.font = [UIFont systemFontOfSize:SelectedFontSize];
    label.textAlignment = NSTextAlignmentCenter;
    //按照大字体设置Label的大小
    [label sizeToFit];
    //设置小字体
    label.font = [UIFont systemFontOfSize:NormalFontSize];
    
    return label;
}

- (void)setScale:(CGFloat)scale {
    
    CGFloat max = SelectedFontSize / NormalFontSize - 1;
    
    // scale 的比例
    CGFloat percent = max * scale + 1;
    self.transform = CGAffineTransformMakeScale(percent, percent);
    
    //颜色渐变为红色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}
@end
