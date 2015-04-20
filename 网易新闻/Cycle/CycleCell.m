//
//  CycleCell.m
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CycleCell.h"
#import "Headline.h"
#import "UIImageView+AFNetworking.h"

@interface CycleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation CycleCell

- (void)setHeadline:(Headline *)headline {
    _headline = headline;
    
    //给控件赋值
    [self.imageView setImageWithURL:[NSURL URLWithString:headline.imgsrc]];
}
@end
