//
//  FWHelperSliderBar.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWHelperSliderBar : UIView

- (void)loadSliderBarTitleSource:(NSArray <NSString *>*)titleSource;
- (void)switchSliderIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
