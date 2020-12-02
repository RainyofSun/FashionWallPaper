//
//  FWDynamicView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicView.h"
#import "FWDynamicTableViewCell.h"
#import "FWDynamicFiveTableViewCell.h"
#import "FWDynamicTwoTableViewCell.h"

static NSString *DynamicTableCell = @"DynamicTableCell";
static NSString *DynamicFiveCell = @"DynamicFiveCell";
static NSString *DynamicTwoCell = @"DynamicTwoCell";

@interface FWDynamicView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dynamicTableView;
/** dataSource */
@property (nonatomic,strong) NSArray <FWDynamicModel *>*dataSource;

@end

@implementation FWDynamicView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTableView];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadDynamicSource:(NSArray<FWDynamicModel *> *)source {
    self.dataSource = source;
    [self.dynamicTableView reloadData];
    if (self.dynamicTableView.mj_header.refreshing) {
        [self.dynamicTableView.mj_header endRefreshing];
    }
    if (self.dynamicTableView.mj_footer.refreshing) {
        [self.dynamicTableView.mj_footer endRefreshing];
    }
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.dynamicTableView.mj_footer endRefreshingWithNoMoreData];
        self.dynamicTableView.mj_footer.hidden = YES;
    }
    self.dynamicTableView.mj_footer.state = status;
}

- (void)dynamicWallPaperStartRefresh {
    [self.dynamicTableView.mj_header beginRefreshing];
}

#pragma mark - 刷新
- (void)refreshMoreData {
    NSLog(@"刷新");
    if (self.dynamicDelegate != nil && [self.dynamicDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        [self.dynamicDelegate pullRefreshPage];
    }
}

- (void)loadMoreData {
    NSLog(@"加载更多");
    if (self.dynamicDelegate != nil && [self.dynamicDelegate respondsToSelector:@selector(dragLoadMore)]) {
        [self.dynamicDelegate dragLoadMore];
    }
}

#pragma mark - 消息透传
- (void)selectedWallPaper:(FWDynamicMediaModel *)paperSource {
    if (self.dynamicDelegate != nil && [self.dynamicDelegate respondsToSelector:@selector(didSelectedWallPaper:)]) {
        [self.dynamicDelegate didSelectedWallPaper:paperSource];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicCellStyle cellStyle = self.dataSource[indexPath.row].cellStyle;
    if (cellStyle == DynamicCellStyle_Nine) {
        FWDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicTableCell];
        [cell loadDynamicNineCell:self.dataSource[indexPath.row]];
        return cell;
    } else if (cellStyle == DynamicCellStyle_Five) {
        FWDynamicFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicFiveCell];
        [cell loadDynamicFiveCellModel:self.dataSource[indexPath.row]];
        return cell;
    } else if (cellStyle == DynamicCellStyle_Two) {
        FWDynamicTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicTwoCell];
        [cell loadDynamicTwoCellModel:self.dataSource[indexPath.row]];
        return cell;
    } else {
        FWDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicTableCell];
        [cell loadDynamicNineCell:self.dataSource[indexPath.row]];
        return cell;
    }
}

#pragma mark - private methods
- (void)setupTableView {
    self.dynamicTableView.delegate = self;
    self.dynamicTableView.dataSource = self;
    [self.dynamicTableView registerNib:[UINib nibWithNibName:@"FWDynamicTableViewCell" bundle:nil] forCellReuseIdentifier:DynamicTableCell];
    [self.dynamicTableView registerNib:[UINib nibWithNibName:@"FWDynamicFiveTableViewCell" bundle:nil] forCellReuseIdentifier:DynamicFiveCell];
    [self.dynamicTableView registerNib:[UINib nibWithNibName:@"FWDynamicTwoTableViewCell" bundle:nil] forCellReuseIdentifier:DynamicTwoCell];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    self.dynamicTableView.mj_header = header;
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.dynamicTableView.mj_footer = footer;
}

@end
