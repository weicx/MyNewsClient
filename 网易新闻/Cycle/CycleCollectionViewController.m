//
//  CycleCollectionViewController.m
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CycleCollectionViewController.h"
#import "Headline.h"
#import "CycleCell.h"

@interface CycleCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
//保存模型的数组
@property (strong, nonatomic) NSArray *dataList;
//记录图片数据的索引
@property (assign, nonatomic) NSInteger currentImgIndex;
@end

@implementation CycleCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据模型保存在数组中
    [Headline headlineWithCompletion:^(NSArray *headlines) {
        self.dataList = headlines;
    }];
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    
    [self.collectionView reloadData];
    
    self.currentImgIndex = 0;
    //滚动到索引为1的item，确保向左右都能滚动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
//视图即将出现，其本身的大小已经确定
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.collectionView.pagingEnabled = YES;//分页
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
//视图停止滚动时调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //停止滚动时的页码
    int offset = scrollView.contentOffset.x / scrollView.bounds.size.width - 1;//一共有三个item，所以offset取值只能是-1，0，1。如果停下是刚好在中间那个，offset值为0，不需要调整位置；如果停下的地方不是中间那个，就需要调整位置，将显示的那个item换成中间那个，这样才能保证向左、向右都能滚动
    
    if (offset != 0) {//需要调整
        //计算要显示的图片的索引
        self.currentImgIndex = (self.currentImgIndex + offset + self.dataList.count) % self.dataList.count;//取模的目的是确保数组不会越界，self.currentImgIndex取值为0，1，2，3
        
        //滚动回中间那一个  也是索引为1的那一个
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
        // 快速拖拽的时候，有的时候会出现图片错位的错误！原因是动画造成的时间差
        // 关闭视图动画
        [UIView setAnimationsEnabled:NO];
        //重新刷新中间那一页
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        //恢复视图动画
        [UIView setAnimationsEnabled:YES];
    }
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    //计算真实的索引
    NSInteger index = (indexPath.item + self.currentImgIndex - 1 + self.dataList.count) % self.dataList.count;//取模是为了防止越界
    
    cell.headline = self.dataList[index];
    
    return cell;
}

@end
