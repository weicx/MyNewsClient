//
//  NewsTableViewController.m
//  网易新闻
//
//  Created by apple on 15-4-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NewsTableViewController.h"
#import "News.h"
#import "NewsCell.h"

@interface NewsTableViewController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    
    //刷新表格
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.dataList[indexPath.row];
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsCell cellIdentifier:news] forIndexPath:indexPath];
    cell.news = news;
   
    return cell;
}

- (void)setUrlString:(NSString *)urlString {
    
    _urlString = urlString.copy;
    
    //加载模型数据，保存在模型数组中
    [News newsWithURLString:urlString completion:^(NSArray *newsArray) {
        self.dataList = newsArray;
    }];
}
#pragma mark - TableView delegate
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    News *news = self.dataList[indexPath.row];
    
    return [NewsCell rowHeight:news];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
