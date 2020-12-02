//
//  FWClassifyTaoTuView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FWClassifyTaoTuModel;
@protocol FWClassifyTaoTuDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;

@end

@interface FWClassifyTaoTuView : UIView

/** taoTuDelegate */
@property (nonatomic,weak) id<FWClassifyTaoTuDelegate> taoTuDelegate;

- (void)reloadClassifyTaoTuSource:(NSArray <FWClassifyTaoTuModel *>*)source;
- (void)resetWallPaperSource:(NSArray <FWClassifyTaoTuModel *>*)paperSource;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)wallPaperStartRefresh;

@end

NS_ASSUME_NONNULL_END
