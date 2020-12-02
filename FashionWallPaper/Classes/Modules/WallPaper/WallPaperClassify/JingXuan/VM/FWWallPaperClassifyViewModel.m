//
//  FWWallPaperClassifyViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperClassifyViewModel.h"
#import "FWWallPaperView.h"
#import "FWWallPaperDataTool.h"

@interface FWWallPaperClassifyViewModel ()<FWWallPaperDelegate>

/** paperView */
@property (nonatomic,strong) FWWallPaperView *paperView;
/** dataTool */
@property (nonatomic,strong) FWWallPaperDataTool *dataTool;
/** localSource */
@property (nonatomic,strong) NSMutableArray <FWWallPaperModel *>*localSource;

@end

@implementation FWWallPaperClassifyViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadWallPaperClassifyView:(UIView *)view {
    [view addSubview:self.paperView];
    self.paperView.wallPaperDelegate = self;
    [self.paperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.paperView wallPaperStartRefresh];
}

#pragma mark - FWWallPaperDelegate
- (void)pullRefreshPage {
    [self requestLoadData:FWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestLoadData:FWLoadingType_More];
}

- (void)didSelectedWallPaper:(FWWallPaperModel *)paperModel {
    [[self.paperView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"thumblink":paperModel.thumblink,@"downloadUrl":paperModel.link} vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)requestLoadData:(FWLoadingType)loadType {
    WeakSelf;
    [self.dataTool requestLocalPaperDataName:self.localDataName dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        [weakSelf.localSource removeAllObjects];
        [weakSelf.localSource addObjectsFromArray:(NSArray <FWWallPaperModel *>*)responseObject];
        [weakSelf.paperView loadWallPaperSource:weakSelf.localSource];
        isNoMoreData ? [weakSelf.paperView resetFooterStatus:MJRefreshStateNoMoreData]: nil;
        isNoMoreData ? [MBHUDToastManager showBriefAlert:@"没有更多数据了"] : nil;
    } loadingDataType:loadType];
}

#pragma mark - lazy
- (FWWallPaperView *)paperView {
    if (!_paperView) {
        _paperView = [[FWWallPaperView alloc] initNeedRegisterHeaderView:NO];
    }
    return _paperView;
}

- (FWWallPaperDataTool *)dataTool {
    if (!_dataTool) {
        _dataTool = [[FWWallPaperDataTool alloc] init];
    }
    return _dataTool;
}

- (NSMutableArray<FWWallPaperModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
