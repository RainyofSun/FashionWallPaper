//
//  FWDynamicViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicViewModel.h"
#import "FWDynamicView.h"
#import "FWDynamicModel.h"

@interface FWDynamicViewModel ()<FWDynamicDelegate>

/** dynamicView */
@property (nonatomic,strong) FWDynamicView *dynamicView;
/** localSource */
@property (nonatomic,strong) NSMutableArray <FWDynamicModel *>*localSource;

@end

@implementation FWDynamicViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultCount];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadDynamicView:(UIView *)view {
    self.dynamicView.dynamicDelegate = self;
    [view addSubview:self.dynamicView];
    [self.dynamicView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.dynamicView dynamicWallPaperStartRefresh];
}

#pragma mark - FWDynamicDelegate
- (void)pullRefreshPage {
    [self requestLocalData:FWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestLocalData:FWLoadingType_More];
}

- (void)didSelectedWallPaper:(FWDynamicMediaModel *)paperModel {
    FLOG(@"选择 %@",paperModel);
    [[self.dynamicView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"thumblink":paperModel.thumb,@"downloadUrl":paperModel.url} vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)requestLocalData:(FWLoadingType)loadType {
    NSInteger page = 0;
    if (loadType == FWLoadingType_More) {
        page = self.page + 1;
    } else {
        [self setDefaultCount];
    }
    FLOG(@"加载页数 %ld 记录页数 %ld",(long)page,(long)self.page);
    self.loadingType = loadType;
    __block NSArray <FWDynamicModel *>*tempArray = nil;
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"DongTai%ld",(long)page] localData:^(id  _Nonnull responseObject) {
        tempArray = [FWDynamicModel modelArrayWithDictArray:(NSArray *)responseObject];
        weakSelf.loadingType == FWLoadingType_More ? weakSelf.page ++ : [weakSelf.localSource removeAllObjects];
        if (weakSelf.page == MAXDATA || tempArray.count < weakSelf.pageCount) {
            weakSelf.isResetNoMoreData = YES;
            [MBHUDToastManager showBriefAlert:@"没有更多数据了"];
            [weakSelf.dynamicView resetFooterStatus:MJRefreshStateNoMoreData];
        }
        [weakSelf.localSource addObjectsFromArray:tempArray];
        [weakSelf.dynamicView reloadDynamicSource:weakSelf.localSource];
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

- (void)setDefaultCount {
    self.page = 0;
    self.pageCount = 20;
}

#pragma mark - lazy
- (FWDynamicView *)dynamicView {
    if (!_dynamicView) {
        _dynamicView = [[[NSBundle mainBundle] loadNibNamed:@"FWDynamicView" owner:nil options:nil] firstObject];
    }
    return _dynamicView;
}

- (NSMutableArray<FWDynamicModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
