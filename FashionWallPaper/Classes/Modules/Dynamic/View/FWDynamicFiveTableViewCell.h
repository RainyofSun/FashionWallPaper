//
//  FWDynamicFiveTableViewCell.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWDynamicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWDynamicFiveTableViewCell : UITableViewCell

- (void)loadDynamicFiveCellModel:(FWDynamicModel *)modelSource;

@end

NS_ASSUME_NONNULL_END