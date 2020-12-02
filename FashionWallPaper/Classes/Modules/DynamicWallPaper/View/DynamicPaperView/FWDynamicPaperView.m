//
//  FWDynamicPaperView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicPaperView.h"
#import "FWWallPaperCollectionViewCell.h"

static NSString *DynamicWallPaperCell = @"WallPaperCell";

@interface FWDynamicPaperView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <FWDynamicPaperModel *>*dataSource;

@end

@implementation FWDynamicPaperView

- (instancetype)init {
    if (self = [super init]) {
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
- (void)loadWallPaperSource:(NSArray<FWDynamicPaperModel *> *)papaerSource {
    self.dataSource = papaerSource;
    [self.collectionView reloadData];
    if (self.collectionView.mj_header.refreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    if (self.collectionView.mj_footer.refreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)resetWallPaperSource:(NSArray<FWDynamicPaperModel *> *)paperSource {
    self.dataSource = paperSource;
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        self.collectionView.mj_footer.hidden = YES;
    }
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
    FWWallPaperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DynamicWallPaperCell forIndexPath:indexPath];
    [cell resetWallPaperImg:self.dataSource[indexPath.item].thumb];
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"FWWallPaperCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DynamicWallPaperCell];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    self.collectionView.mj_header = header;
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer = footer;
}

@end
