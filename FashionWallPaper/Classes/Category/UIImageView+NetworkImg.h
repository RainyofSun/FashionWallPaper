//
//  UIImageView+NetworkImg.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (NetworkImg)

- (void)loadNetworkImg:(NSString *)imgUrl bigPlaceHolder:(BOOL)big;

@end

NS_ASSUME_NONNULL_END
