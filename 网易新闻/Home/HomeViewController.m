//
//  HomeViewController.m
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "Channel.h"
#import "ChannelLabel.h"
#import "ChannelCell.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *channelView;
@property (strong, nonatomic) NSArray *channels;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//记录当前的频道标签
@property (assign, nonatomic) NSInteger currentIndex;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChannel];
    
    self.channelView.showsHorizontalScrollIndicator = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"account_logout_button"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**
 *  此方法在所有子视图布局完成时调用，大小已经确定
 */
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    //设置流水布局
    [self setupLayout];
}

- (void)setupLayout {

    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - collectionView 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.channels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    // 添加子视图控制器
    if (![self.childViewControllers containsObject:cell.newsVC]) {//不在子控制器数组，需要添加
        [self addChildViewController:(UIViewController *)cell.newsVC];
    }
    Channel *channel = self.channels[indexPath.item];
    
    cell.urlString = channel.urlString;
    
    return cell;
}

#pragma mark - 滚动视图代理方法
//只要滚动视图发生滚动，就会立即执行该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    //当前的标签
    ChannelLabel *currentLabel = self.channelView.subviews[self.currentIndex];
    //下一个标签
    ChannelLabel *nextLabel = nil;
    
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        
        if (indexPath.item != self.currentIndex) {
            
            nextLabel = self.channelView.subviews[indexPath.item];
            
            break;
        }
    }
    //滚动到两端的情况
    if (nextLabel == nil) {
        return;
    }
    
    //下一个标签的缩放比例  ABS取绝对值
    CGFloat nextScale = ABS((float)scrollView.contentOffset.x / scrollView.bounds.size.width - self.currentIndex);
    //相对应的当前标签的缩放比例
    CGFloat currentScale = 1 - nextScale;
    
    //设置标签比例。设置的同时，标签文字的大小和颜色也随之改变。
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
}
//滚动视图停止滚动，更新一下当前索引
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
}

//设置频道
- (void)setupChannel {
    
    //取消自动设置滚动视图的间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //遍历频道数组，计算每一个 label 位置
    CGFloat margin = 8.0;
    CGFloat x = margin;
    CGFloat h = self.channelView.bounds.size.height;
    
    for (Channel *channel in self.channels) {
        ChannelLabel *label = [ChannelLabel channelLabelWithTitle:channel.tname];
        
        label.frame = CGRectMake(x, 0, label.bounds.size.width, h);
        x += label.bounds.size.width;
        
        [self.channelView addSubview:label];
    }
    
    self.channelView.contentSize = CGSizeMake(x + margin, h);
    
    //默认选中第一条
    self.currentIndex = 0;
    
    //让第一个文字放大并且显示红色
    ChannelLabel *label = self.channelView.subviews[0];
    label.scale = 1.0;
}

//懒加载
- (NSArray *)channels {

    if (!_channels) {
        _channels = [Channel channels];
    }
    return _channels;
}
@end
