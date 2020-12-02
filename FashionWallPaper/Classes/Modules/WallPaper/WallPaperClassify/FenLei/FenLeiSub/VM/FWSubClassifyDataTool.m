//
//  FWSubClassifyDataTool.m
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWSubClassifyDataTool.h"
#import "FWSubClassifyPicModel.h"

@interface FWSubClassifyDataTool ()

/** localSource */
@property (nonatomic,strong) NSMutableArray <FWSubClassifyPicModel *>*localSource;

@end

@implementation FWSubClassifyDataTool

- (instancetype)init{
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)requestSubClassifyData:(NSDictionary *)params dataBlock:(void (^)(id _Nonnull, BOOL))valueBlock loadingType:(FWLoadingType)loadType {
    NSInteger page = 0;
    if (loadType == FWLoadingType_More) {
        page = self.page + 1;
    } else {
        [self setDefaultData];
    }
    FLOG(@"加载页数 %ld 记录页数 %ld ",(long)page,(long)self.page);
    self.loadingType = loadType;
    __block NSArray <FWSubClassifyPicModel *>*tempArray = nil;
    WeakSelf;
    [FWNetworkTool getWithURLString:Classify_more([params objectForKey:@"class_id"], [params objectForKey:@"labelId"],page) success:^(id  _Nonnull responseObject) {
        NSDictionary *temDict = [responseObject objectForKey:@"pic"];
        tempArray = [FWSubClassifyPicModel modelArrayWithDictArray:temDict[@"res"]];
        weakSelf.loadingType == FWLoadingType_More ? weakSelf.page ++ : [weakSelf.localSource removeAllObjects];
        weakSelf.isResetNoMoreData = ![[temDict objectForKey:@"hasmore"] boolValue];
        [weakSelf.localSource addObjectsFromArray:tempArray];
        if (valueBlock) {
            valueBlock(weakSelf.localSource,weakSelf.isResetNoMoreData);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.page = 0;
    self.pageCount = 20;
}

#pragma mark - lazy
- (NSMutableArray<FWSubClassifyPicModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
