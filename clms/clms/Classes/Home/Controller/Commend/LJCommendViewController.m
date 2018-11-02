//
//  LJCommendViewController.m
//  clms
//
//  Created by ljkj on 2018/10/31.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJCommendViewController.h"
#import <AFNetworking.h>
#import "LJLeftModel.h"
#import "LeftCell.h"
#import "RightCell.h"


static CGFloat leftTableWith = 90;
static NSString *leftTable = @"leftTable";
static NSString *rightTable = @"rightTable";

@interface LJCommendViewController ()<NSURLSessionDelegate,UITableViewDelegate,UITableViewDataSource>
/**
 左边列表
 */
@property (nonatomic, strong) UITableView *leftTableView;
/**
 右边圆角
 */
@property (nonatomic, strong) UITableView *rightTableView;
/**
 左边类别数据信息
 */
@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LJCommendViewController

/**
 1.重新发送数据  判断有没有数据，有数据不请求，无数据请求
 2.目前发送一条数据
 3.网络慢带来的细节问题
 */

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,leftTableWith, UIScreen.mainScreen.bounds.size.height) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor brownColor];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
    }
    return _leftTableView;
}

-(UITableView *)rightTableView {
    if (!_rightTableView) {
        
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(leftTableWith, 0, UIScreen.mainScreen.bounds.size.width - leftTableWith, UIScreen.mainScreen.bounds.size.height) style:UITableViewStylePlain];
        _rightTableView.rowHeight = 60;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.backgroundColor = [UIColor redColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItem.title = @"推荐关注";
    // 初始化控件
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategory];
    
}

- (void)setupRefresh {
    
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.rightTableView.mj_footer.hidden = YES;
    
}

// 加载新数据
- (void)loadNewUsers {
    
    LJLeftModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    model.currentPage = 1;
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = model.categoryId;
    params[@"page"] = @(model.currentPage);
    self.params = params;
    // 请求右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject===%@",responseObject);

        [self.rightTableView.mj_header endRefreshing];
        NSArray *users = [NSArray yy_modelArrayWithClass:[LJRightModel class] json:responseObject[@"list"]];
        // 清除旧数据
        [model.users removeAllObjects];
        // 添加到当前类别对应的用户数组中
        [model.users addObjectsFromArray:users];
        
        // 总数
        model.total = [responseObject[@"total"] integerValue];
        
        if (self.params != params) {
            
            return;
        }
        [self.rightTableView reloadData];
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        if (self.params != params) {
            
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
        [self.rightTableView.mj_header endRefreshing];
        
    }];
}
// 加载更多数据
- (void)loadMoreUsers {
    
    LJLeftModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    model.currentPage = 1;
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = model.categoryId;
    params[@"page"] = @(++model.currentPage);
    
    // 请求右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"responseObject===%@",responseObject);
        
        [self.rightTableView.mj_header endRefreshing];
        NSArray *users = [NSArray yy_modelArrayWithClass:[LJRightModel class] json:responseObject[@"list"]];
        // 添加到当前类别对应的用户数组中
        [model.users addObjectsFromArray:users];
        
        // 总数
        model.total = [responseObject[@"total"] integerValue];
        if (self.params != params) {
            
            return;
        }
        
        [self.rightTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) {
            
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
        [self.rightTableView.mj_header endRefreshing];
        
    }];
}

- (void)loadCategory {
    
    // 显示指示器
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"category" forKey:@"a"];
    [params setValue:@"subscribe" forKey:@"c"];
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject1===%@",responseObject);
        [SVProgressHUD dismiss];
        NSArray *responArr = responseObject[@"list"];
        self.categories = [NSArray yy_modelArrayWithClass:[LJLeftModel class] json:responArr];
        
        [self.leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.rightTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
    }];
}

- (void)setupTableView {
    
    self.leftTableView.contentInset = UIEdgeInsetsMake(NavBarHeight, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(NavBarHeight, 0, 0, 0);
    [self.view insertSubview:self.leftTableView belowSubview:self.navigationBar];
    [self.view insertSubview:self.rightTableView belowSubview:self.navigationBar];
    
    [self.leftTableView registerClass:[LeftCell class] forCellReuseIdentifier:leftTable];
    [self.rightTableView registerClass:[RightCell class] forCellReuseIdentifier:rightTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _leftTableView) {
        return self.categories.count;
    }else {
        [self checkFooterState];
        LJLeftModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
        return model.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTableView) {
        
        LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftTable forIndexPath:indexPath];
        LJLeftModel *model = self.categories[indexPath.row];
        cell.model = model;
        return cell;
    }else {
        RightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightTable forIndexPath:indexPath];
        LJLeftModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
        cell.model = model.users[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 点击频繁是 刚点击生活 又点击音乐  会触发两个请求，造成数据异常  所以取消当前操作
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    LJLeftModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    if (model.users.count) {
        [self.rightTableView reloadData];
    }else {
        [self.rightTableView reloadData];
        [self.rightTableView.mj_header beginRefreshing];
    }
}

- (void)checkFooterState {
    
    LJLeftModel *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    self.rightTableView.mj_footer.hidden = (model.count == 0);
    
    if (model.users.count == model.total) {

        // 全部加载完成
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        
        [self.rightTableView.mj_footer endRefreshing];
    }
}

- (void)dealloc {
    
    [self.manager.operationQueue cancelAllOperations];
}

@end
