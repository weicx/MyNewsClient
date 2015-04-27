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
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo57"]];
//    self.navigationItem.titleView.frame = CGRectMake(0, 0, 0, 90);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**
 *  此方法在所有子视图布局完成，大小已经确定
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
    
    // 判断当前 cell 的视图控制器是否是 homeViewController 的子控制器
    // 如果不是，需要添加;如果已经添加，就不需要再次添加
    // 以下代码非常非常非常重要！如果没有加入子视图控制器，会打断响应者链条
    // 后续如果再开发复杂的功能，有可能会出现让人困惑的问题！
    // *** 一定记住：做多视图控制器开发时，一定要添加子视图控制器！
    if (![self.childViewControllers containsObject:cell.newsVC]) {//不在子控制器数组，需要添加
        [self addChildViewController:(UIViewController *)cell.newsVC];
    }
    Channel *channel = self.channels[indexPath.item];
    
    cell.urlString = channel.urlString;//这一句很厉害，将模型里保存的urlString一路上传，先传给ChannelCell，再传给 NewsTableViewController，直接联网刷新数据！进而刷新表格！
    
    return cell;
}

#pragma mark - 滚动视图代理方法
//只要滚动视图发生滚动，就会立即执行该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    //当前的标签
    ChannelLabel *currentLabel = self.channelView.subviews[self.currentIndex];
    //下一个标签
    ChannelLabel *nextLabel = nil;
    //遍历数组，查找下一个标签.在所有当前可见的Items数组中寻找，这个是关键！
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        if (indexPath.item != self.currentIndex) {//因为当前可见的item最多有两个，一个还是当前标签，另外一个必定是下一个标签！
            nextLabel = self.channelView.subviews[indexPath.item];
            //已经找到了就退出循环
            break;
        }
    }
    
    //如果没有下一个标签，直接返回。针对的是滚动到两端的情况！
    if (nextLabel == nil) {//遍历完依然为空，说明下一个标签不存在！
        return;
    }
    
    
    //当前标签逐渐变小，下一个标签逐渐变大，计算缩放的比例
    //下一个标签的缩放比例
    CGFloat nextScale = ABS((float)scrollView.contentOffset.x / scrollView.bounds.size.width - self.currentIndex);//ABS作用是取绝对值，因为往回滚动计算出来是负值。缩放比例在[0,1]，且在不断变大！
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
        ChannelLabel *label = [ChannelLabel channelLabelWithTitle:channel.tname];//这句话将label的文字和size都确定了
        
        //设置frame
        label.frame = CGRectMake(x, 0, label.bounds.size.width, h);
        x += label.bounds.size.width;//这个是下一个label的x值
        
        [self.channelView addSubview:label];
    }
    
    self.channelView.contentSize = CGSizeMake(x + margin, h);//滚动范围，宽度是最后一个label的x值加上间距
    
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
