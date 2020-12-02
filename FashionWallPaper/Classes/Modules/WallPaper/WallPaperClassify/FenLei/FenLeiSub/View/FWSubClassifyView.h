//
//  FWSubClassifyView.h
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWSubClassifyPicModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FWSubClassifyDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(FWSubClassifyPicModel *)paperModel;

@end

@interface FWSubClassifyView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<FWSubClassifyDelegate> wallPaperDelegate;

- (void)loadSubClassifyPicSource:(NSArray <FWSubClassifyPicModel *>*)picSource;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)wallPaperStartRefresh;

@end

NS_ASSUME_NONNULL_END
