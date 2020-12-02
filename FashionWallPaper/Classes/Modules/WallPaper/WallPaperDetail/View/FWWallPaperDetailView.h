//
//  FWWallPaperDetailView.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FWWallPaperDetailDelegate <NSObject>

- (void)downloadWallPaper;

@end

@interface FWWallPaperDetailView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<FWWallPaperDetailDelegate> wallPaperDelegate;

- (void)showDetailPaper:(NSString *)img_url;

@end

NS_ASSUME_NONNULL_END
