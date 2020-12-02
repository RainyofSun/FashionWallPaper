//
//  FWClassifyTaoTuView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifyTaoTuView.h"
#import "FWClassifyTaoTuTableViewCell.h"

static NSString *TaoTuCell = @"ClassifyTaoTuCell";

@interface FWClassifyTaoTuView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *paperTableView;
/** dataSource */
@property (nonatomic,strong) NSArray <FWClassifyTaoTuModel *>*dataSource;

@end

@implementation FWClassifyTaoTuView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTableView];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadClassifyTaoTuSource:(NSArray<FWClassifyTaoTuModel *> *)source {
    self.dataSource = source;
    [self.paperTableView reloadData];
    if (self.paperTableView.mj_header.refreshing) {
        [self.paperTableView.mj_header endRefreshing];
    }
    if (self.paperTableView.mj_footer.refreshing) {
        [self.paperTableView.mj_footer endRefreshing];
    }
}

- (void)resetWallPaperSource:(NSArray<FWClassifyTaoTuModel *> *)paperSource {
    self.dataSource = paperSource;
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.paperTableView.mj_footer endRefreshingWithNoMoreData];
    }
    self.paperTableView.mj_footer.state = status;
}

- (void)wallPaperStartRefresh {
    [self.paperTableView.mj_header beginRefreshing];
}

#pragma mark - 刷新
- (void)refreshMoreData {
    NSLog(@"刷新");
    if (self.taoTuDelegate != nil && [self.taoTuDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        [self.taoTuDelegate pullRefreshPage];
    }
}

- (void)loadMoreData {
    NSLog(@"加载更多");
    if (self.taoTuDelegate != nil && [self.taoTuDelegate respondsToSelector:@selector(dragLoadMore)]) {
        [self.taoTuDelegate dragLoadMore];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FWClassifyTaoTuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TaoTuCell];
    [cell loadTaoTuCellSource:self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark - private methods
- (void)setupTableView {
    self.paperTableView.delegate = self;
    self.paperTableView.dataSource = self;
    [self.paperTableView registerNib:[UINib nibWithNibName:@"FWClassifyTaoTuTableViewCell" bundle:nil] forCellReuseIdentifier:TaoTuCell];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    self.paperTableView.mj_header = header;
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.paperTableView.mj_footer = footer;
}

@end
