//
//  FWMinePaperCollectionView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FWMinePaperCollectionDelegate <NSObject>

/// 选中图片
- (void)didSelectedWallPaper:(NSDictionary *)paperModel;

@end

@interface FWMinePaperCollectionView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<FWMinePaperCollectionDelegate> wallPaperDelegate;

- (void)reloadCollectionDataSource:(NSArray <NSDictionary *>*)collectionSource;

@end

NS_ASSUME_NONNULL_END
