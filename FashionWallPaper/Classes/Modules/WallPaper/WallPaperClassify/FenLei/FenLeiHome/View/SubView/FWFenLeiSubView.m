//
//  FWFenLeiSubView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFenLeiSubView.h"
#import "FWFenLeiCollectionViewCell.h"

static NSString *FenLeiCell = @"FenLeiCell";

@interface FWFenLeiSubView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** fenLeiCollectionView */
@property (nonatomic,strong) UICollectionView *fenLeiCollectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <FWFenLeiModel *>*dataSource;

@end

@implementation FWFenLeiSubView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.fenLeiCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)reloadFenLeiSource:(NSArray<FWFenLeiModel *> *)source {
    self.dataSource = source;
    [self.fenLeiCollectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FWFenLeiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FenLeiCell forIndexPath:indexPath];
    [cell loadFenLeiCellSource:self.dataSource[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(didSelectedWallPaper:)]) {
        [self.wallPaperDelegate didSelectedWallPaper:self.dataSource[indexPath.item]];
    }
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat Padding = 10;
    CGFloat W = (ScreenWidth - Padding * 5)/4;
    layout.itemSize = CGSizeMake(W, W);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.fenLeiCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.fenLeiCollectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.fenLeiCollectionView registerNib:[UINib nibWithNibName:@"FWFenLeiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:FenLeiCell];
    self.fenLeiCollectionView.dataSource = self;
    self.fenLeiCollectionView.delegate = self;
    [self addSubview:self.fenLeiCollectionView];
}

@end
