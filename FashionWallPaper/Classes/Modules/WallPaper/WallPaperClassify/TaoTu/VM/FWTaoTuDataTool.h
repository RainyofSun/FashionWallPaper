//
//  FWTaoTuDataTool.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWTaoTuDataTool : FWBaseViewModel

- (void)requestLocalPaperDataName:(NSString *)dataName dataBlock:(void(^)(id responseObject,BOOL isNoMoreData))valueBlock loadingDataType:(FWLoadingType)loadType;
- (void)resetDefaultPage;
- (void)resetRequestDataCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
