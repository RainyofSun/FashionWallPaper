//
//  FWWallPaperDetailViewModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWWallPaperDetailViewModel : FWBaseViewModel

/** wallPaperSource */
@property (nonatomic,strong) NSDictionary *wallPaperSource;

- (void)loadWallPaperDetailView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
