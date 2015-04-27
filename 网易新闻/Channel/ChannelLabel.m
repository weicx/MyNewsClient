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
    //设置文字居中
    label.textAlignment = NSTextAlignmentCenter;
    //按照大字体设置Label的大小
    [label sizeToFit];//注意：在Label有不同大小字体状态时，应该先设置大字体把Label“撑大”，然后设置自适应sizeToFit，然后再设置小字体即可，这是一个小技巧
    //设置小字体
    label.font = [UIFont systemFontOfSize:NormalFontSize];
    
    return label;
}

- (void)setScale:(CGFloat)scale {
    
    //scale取值范围是[0,1]
    //0代表字体大小没有变化，还是默认的NormalFontSize；
    //1代表字体放到最大，即SelectedFontSize。缩放的比例对应的是18 / 14
    CGFloat max = SelectedFontSize / NormalFontSize - 1;
    // scale 的比例
    // 0 * max + 1 最小的比例
    // scale * max + 1  中间大小的比例
    // 1 * max + 1 = 最大的比例
    CGFloat percent = max * scale + 1;//即放大为默认大小的多少倍
    self.transform = CGAffineTransformMakeScale(percent, percent);
    
    //颜色渐变为红色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}
@end
