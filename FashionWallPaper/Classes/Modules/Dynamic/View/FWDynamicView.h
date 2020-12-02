//
//  FWDynamicView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FWDynamicModel;
@class FWDynamicMediaModel;

@protocol FWDynamicDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(FWDynamicMediaModel *)paperModel;

@end

@interface FWDynamicView : UIView

/** dynamicDelegate */
@property (nonatomic,weak) id<FWDynamicDelegate> dynamicDelegate;

- (void)reloadDynamicSource:(NSArray <FWDynamicModel *>*)source;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)dynamicWallPaperStartRefresh;

@end

NS_ASSUME_NONNULL_END
