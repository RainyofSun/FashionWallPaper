//
//  FWWallPaperClassifyViewModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWWallPaperClassifyViewModel : FWBaseViewModel

/** localDataName */
@property (nonatomic,strong) NSString *localDataName;

- (void)loadWallPaperClassifyView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
