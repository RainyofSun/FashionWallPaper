//
//  FWTaoTuDataTool.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWTaoTuDataTool.h"
#import "FWClassifyTaoTuModel.h"

@interface FWTaoTuDataTool ()

/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray;
/** localSource */
@property (nonatomic,strong) NSMutableArray <FWClassifyTaoTuModel *>*localSource;

@end

@implementation FWTaoTuDataTool

- (instancetype)init {
    if (self = [super init]) {
        [self resetDefaultPage];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)requestLocalPaperDataName:(NSString *)dataName dataBlock:(void (^)(id _Nonnull, BOOL))valueBlock loadingDataType:(FWLoadingType)loadType {
    NSInteger page = 0;
    if (loadType == FWLoadingType_More) {
        page = self.page + 1;
    } else {
        [self resetDefaultPage];
    }
    FLOG(@"加载页数 %ld 记录页数 %ld 加载类目 %@",(long)page,(long)self.page,dataName);
    self.loadingType = loadType;
    __block NSArray <FWClassifyTaoTuModel *>*tempArray = nil;
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"%@%ld",dataName,(long)page] localData:^(id  _Nonnull responseObject) {
        tempArray = [FWClassifyTaoTuModel modelArrayWithDictArray:(NSArray *)[responseObject objectForKey:@"img"]];
        weakSelf.loadingType == FWLoadingType_More ? weakSelf.page ++ : [weakSelf.localSource removeAllObjects];
        if (weakSelf.page == MAXDATA || tempArray.count < weakSelf.pageCount) {
            weakSelf.isResetNoMoreData = YES;
        }
        [weakSelf.localSource addObjectsFromArray:tempArray];
        if (valueBlock) {
            valueBlock(weakSelf.localSource,weakSelf.isResetNoMoreData);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

- (void)resetDefaultPage {
    self.page = 0;
    [self.localSource removeAllObjects];
    self.isResetNoMoreData = NO;
}

- (void)resetRequestDataCount:(NSInteger)count {
    self.pageCount = count;
}

#pragma mark - lazy
- (NSMutableArray<FWClassifyTaoTuModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
