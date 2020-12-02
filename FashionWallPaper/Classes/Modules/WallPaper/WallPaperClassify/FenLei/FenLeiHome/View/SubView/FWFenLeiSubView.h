//
//  FWFenLeiSubView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FWFenLeiModel;

@protocol FenLeiSubViewDelegate <NSObject>

- (void)didSelectedWallPaper:(FWFenLeiModel *)paperModel;

@end

@interface FWFenLeiSubView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<FenLeiSubViewDelegate> wallPaperDelegate;

- (void)reloadFenLeiSource:(NSArray <FWFenLeiModel *>*)source;

@end

NS_ASSUME_NONNULL_END
