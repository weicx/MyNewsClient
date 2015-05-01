### MyNewsClient
####仿网易新闻客户端
====================
####基本架构
* 使用 UICollectionViewCell 实现不同频道内容视图的切换复用以及图片轮播
* TableView 加载新闻内容（应注意多图、大图模式）
* 使用 UIScrollView 实现所用频道标签的滚动
* 将频道内容视图和频道标签“联动”，并加入动画
* 加载网络数据并处理成数据模型，展示在相应视图

####关键点
* 利用运行时机制动态获取模型属性
* CollectionViewCell 的复用
* 频道标签滚动位置的计算
* 模型数据的传递

####详情请参考项目中的注释！
