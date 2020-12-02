//
//  FWMinePaperViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMinePaperViewModel.h"
#import "FWMinePaperCollectionView.h"

@interface FWMinePaperViewModel ()<FWMinePaperCollectionDelegate>

/** collectionView */
@property (nonatomic,strong) FWMinePaperCollectionView *collectionView;

@end

@implementation FWMinePaperViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMinePaperView:(UIView *)view {
    [view addSubview:self.collectionView];
    self.collectionView.wallPaperDelegate = self;
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.collectionView reloadCollectionDataSource:[FWCommonCache UserGlobalCache].collectionArray];
}

#pragma mark - FWMinePaperCollectionDelegate
- (void)didSelectedWallPaper:(NSDictionary *)paperModel {
    FLOG(@"选择 %@",paperModel);
    [[self.collectionView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:paperModel vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - lazy
- (FWMinePaperCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[FWMinePaperCollectionView alloc] init];
    }
    return _collectionView;
}

@end
