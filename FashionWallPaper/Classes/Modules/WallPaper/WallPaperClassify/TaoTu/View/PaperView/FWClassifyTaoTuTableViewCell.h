//
//  FWClassifyTaoTuTableViewCell.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWClassifyTaoTuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWClassifyTaoTuTableViewCell : UITableViewCell

- (void)loadTaoTuCellSource:(FWClassifyTaoTuModel *)modelSource;

@end

NS_ASSUME_NONNULL_END
