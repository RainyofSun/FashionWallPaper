//
//  FWDynamicPaperView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWDynamicPaperModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FWDynamicPaperDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(FWDynamicPaperModel *)paperModel;

@end

@interface FWDynamicPaperView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<FWDynamicPaperDelegate> wallPaperDelegate;

- (void)loadWallPaperSource:(NSArray <FWDynamicPaperModel *>*)papaerSource;
- (void)resetWallPaperSource:(NSArray <FWDynamicPaperModel *>*)paperSource;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)wallPaperStartRefresh;

@end

NS_ASSUME_NONNULL_END
