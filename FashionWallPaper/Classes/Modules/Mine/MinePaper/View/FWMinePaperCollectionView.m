//
//  FWMinePaperCollectionView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMinePaperCollectionView.h"
#import "FWWallPaperCollectionViewCell.h"

static NSString *CollectionWallPaperCell = @"WallPaperCell";

@interface FWMinePaperCollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <NSDictionary *>*dataSource;

@end

@implementation FWMinePaperCollectionView

- (instancetype)init {
    if (self = [super init]) {
        [self setupCollectionView];
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
- (void)reloadCollectionDataSource:(NSArray<NSDictionary *> *)collectionSource {
    self.dataSource = collectionSource;
    [self.collectionView reloadData];
    if (!collectionSource.count) {
        self.collectionView.emptyDataSetDelegate = self;
        self.collectionView.emptyDataSetSource = self;
        [self.collectionView reloadEmptyDataSet];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FWWallPaperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionWallPaperCell forIndexPath:indexPath];
    [cell resetWallPaperImg:[self.dataSource[indexPath.item] objectForKey:@"thumblink"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(didSelectedWallPaper:)]) {
        [self.wallPaperDelegate didSelectedWallPaper:self.dataSource[indexPath.item]];
    }
}

#pragma mark - DZNEmptyDataSetDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无相关内容";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName:HexColor(0x656565),
                                 };
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title attributes:attributes];
    return attributeStr;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"wp_loaddata_nodata"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    // 处理视图点击事件...
    NSLog(@"touch view");
    
}

#pragma mark - private methods
- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = (ScreenWidth - 32)/3;
    layout.itemSize = CGSizeMake(W, W * 2);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.collectionView registerNib:[UINib nibWithNibName:@"FWWallPaperCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CollectionWallPaperCell];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
}

@end
