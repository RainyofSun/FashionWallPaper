//
//  FWWallPaperView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWWallPaperModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FWWallPaperDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(FWWallPaperModel *)paperModel;

@end

@interface FWWallPaperView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<FWWallPaperDelegate> wallPaperDelegate;

- (instancetype)initNeedRegisterHeaderView:(BOOL)registerHeader;
- (void)loadWallPaperSource:(NSArray <FWWallPaperModel *>*)papaerSource;
- (void)resetWallPaperSource:(NSArray <FWWallPaperModel *>*)paperSource;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)wallPaperStartRefresh;

@end

NS_ASSUME_NONNULL_END
