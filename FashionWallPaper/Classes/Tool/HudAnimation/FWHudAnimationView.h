//
//  FWHudAnimationView.h
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWHudAnimationView : UIView

- (instancetype)showWithSuperView:(UIView *)view;
- (void)hideAnimation;

@end

NS_ASSUME_NONNULL_END
