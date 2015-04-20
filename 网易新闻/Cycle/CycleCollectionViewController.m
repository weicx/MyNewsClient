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
@end

@implementation CycleCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据模型保存在数组中
    [Headline headlineWithCompletion:^(NSArray *headlines) {
        self.dataList = headlines;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
    cell.headline = self.dataList[indexPath.item];
    
    return cell;
}

@end
