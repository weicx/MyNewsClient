//
//  NewsCell.m
//  网易新闻
//
//  Created by WR on 15-4-20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+AFNetworking.h"
#import "News.h"

#define NORMAL_CELL_HEIGHT       80
#define IMAGES_CELL_HEIGHT      120
#define BIG_IMAGE_CELL_HEIGHT   180

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
// 连线数组，可以把一类 UIImageView 统一放在一个数组中
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImages;

@end
@implementation NewsCell

- (void)setNews:(News *)news {
    _news = news;
    
    //常规属性
    [self.iconView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    self.titleLabel.text = news.title;
    self.digestLabel.text = news.digest;
    self.replyLabel.text = [NSString stringWithFormat:@"%d跟帖", news.replyCount];
    //额外配图
    if (news.imgextra.count == 2) {
        for (int i = 0; i < 2; i++) {
            NSURL *url = [NSURL URLWithString:news.imgextra[i][@"imgsrc"]];
            [self.extraImages[i] setImageWithURL:url];
        }
    }
}
//设置 digestLabel 的最大换行宽度
- (void)awakeFromNib {
    CGFloat margin = 10;
    self.digestLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 3 * margin - 80;
}

+ (NSString *)cellIdentifier:(News *)news {

    if (news.imgextra.count == 2) {
        
        return @"ImagesCell";
        
    } else if (news.imgType) {
    
        return @"BigImageCell";
    }
    return @"NewsCell";
}

+ (CGFloat)rowHeight:(News *)news {

    if (news.imgextra.count == 2) {
        
        return IMAGES_CELL_HEIGHT;
        
    } else if (news.imgType) {
        
        return BIG_IMAGE_CELL_HEIGHT;
    }
    return NORMAL_CELL_HEIGHT;
}
@end
