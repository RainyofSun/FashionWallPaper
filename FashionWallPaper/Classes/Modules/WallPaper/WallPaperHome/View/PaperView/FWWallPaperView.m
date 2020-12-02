//
//  FWWallPaperView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperView.h"
#import "FWClassifyHeaderView.h"
#import "FWWallPaperCollectionViewCell.h"

static NSString *WallPaperCell = @"WallPaperCell";
static NSString *ClassifyHeader = @"ClassifyHeader";

@interface FWWallPaperView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** headerView */
@property (nonatomic,strong) FWClassifyHeaderView *headerView;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <FWWallPaperModel *>*dataSource;
/** needRegisterHeader */
@property (nonatomic,assign) BOOL needRegisterHeader;

@end

@implementation FWWallPaperView

- (instancetype)initNeedRegisterHeaderView:(BOOL)registerHeader {
    if (self = [super init]) {
        self.needRegisterHeader = registerHeader;
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadWallPaperSource:(NSArray<FWWallPaperModel *> *)papaerSource {
    self.dataSource = papaerSource;
    [self.collectionView reloadData];
    if (self.collectionView.mj_header.refreshing) {
        [self.collectionView.mj_header endRefreshing];
        if (self.needRegisterHeader) {
            [UIView animateWithDuration:0.3 animations:^{
                self.collectionView.contentInset = UIEdgeInsetsMake(self.headerView.headerH + 10, 0, 0, 0);
            }];
        }
    }
    if (self.collectionView.mj_footer.refreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)resetWallPaperSource:(NSArray<FWWallPaperModel *> *)paperSource {
    self.dataSource = paperSource;
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    self.collectionView.mj_footer.hidden = !self.needRegisterHeader;
    self.collectionView.mj_footer.state = status;
}

- (void)wallPaperStartRefresh {
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 刷新
- (void)refreshMoreData {
    NSLog(@"刷新");
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        [self.wallPaperDelegate pullRefreshPage];
    }
}

- (void)loadMoreData {
    NSLog(@"加载更多");
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(dragLoadMore)]) {
        [self.wallPaperDelegate dragLoadMore];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FWWallPaperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WallPaperCell forIndexPath:indexPath];
    [cell resetWallPaperImg:self.dataSource[indexPath.item].thumblink];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(didSelectedWallPaper:)]) {
        [self.wallPaperDelegate didSelectedWallPaper:self.dataSource[indexPath.item]];
    }
}

#pragma mark - private methods
- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = (ScreenWidth - 32)/3;
    layout.itemSize = CGSizeMake(W, W * 2);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.collectionView registerNib:[UINib nibWithNibName:@"FWWallPaperCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WallPaperCell];
    if (self.needRegisterHeader) {
        self.collectionView.contentInset = UIEdgeInsetsMake(self.headerView.headerH + 10, 0, 0, 0);
        self.headerView.frame = CGRectMake(0, -self.headerView.headerH, ScreenWidth, self.headerView.headerH);
        [self.collectionView addSubview:self.headerView];
    }
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    self.collectionView.mj_header = header;
    self.collectionView.mj_header.hidden = self.needRegisterHeader;
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer = footer;
}

#pragma mark - lazy
- (FWClassifyHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[FWClassifyHeaderView alloc] init];
    }
    return _headerView;
}

@end
