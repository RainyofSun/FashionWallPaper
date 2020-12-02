//
//  FWMainViewModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWMainViewModel : FWBaseViewModel

/// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
