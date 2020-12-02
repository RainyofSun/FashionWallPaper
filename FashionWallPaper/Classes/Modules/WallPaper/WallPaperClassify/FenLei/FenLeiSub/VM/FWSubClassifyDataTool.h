//
//  FWSubClassifyDataTool.h
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWSubClassifyDataTool : FWBaseViewModel

- (void)requestSubClassifyData:(NSDictionary *)params dataBlock:(void(^)(id responseObject,BOOL isNoMoreData))valueBlock loadingType:(FWLoadingType)loadType;

@end

NS_ASSUME_NONNULL_END
