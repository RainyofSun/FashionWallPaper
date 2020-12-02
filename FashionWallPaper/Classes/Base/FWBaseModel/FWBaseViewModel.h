//
//  FWBaseViewModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^_Nullable ReturnValueBlock)(id returnValue);

typedef NS_ENUM(NSInteger, FWLoadingType) {
    FWLoadingType_Normal,//正常加载
    FWLoadingType_Refresh,//下拉刷新
    FWLoadingType_More//上拉加载
};

@interface FWBaseViewModel : NSObject

/** pageCount */
@property (nonatomic,assign) NSInteger pageCount;
/** page */
@property (nonatomic,assign) NSInteger page;
/** loadingType */
@property (nonatomic,assign) FWLoadingType loadingType;
/** 首次加载完成 */
@property (nonatomic, assign) BOOL isListDataCompleted;
/** 下拉刷新加载完成 */
@property (nonatomic, assign) BOOL isPullRefreshComplted;
/** 上拉加载 */
@property (nonatomic, assign) BOOL isLoadMoreComplted;
/** 上拉加载没有更多数据 */
@property (nonatomic, assign) BOOL isResetNoMoreData;

@end

NS_ASSUME_NONNULL_END
