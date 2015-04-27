//
//  ChannelCell.m
//  网易新闻
//
//  Created by apple on 15-4-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChannelCell.h"
#import "NewsTableViewController.h"

@implementation ChannelCell

- (void)awakeFromNib {
    
    //1.加载storyboard，拿到新闻视图控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsVC = sb.instantiateInitialViewController;//箭头所指控制器
    
    //2.保证代码添加的视图大小和 Cell 的大小一致
    self.newsVC.view.frame = self.bounds;
    
    //3.把新闻控制器的根视图加到Cell上
    [self addSubview:self.newsVC.view];
}

- (void)setUrlString:(NSString *)urlString {

    _urlString = urlString;
    
    //给新闻的视图控制器的频道 URL 设置数值
    self.newsVC.urlString = urlString;
}
@end
