//
//  FWDynamicMediaModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWDynamicMediaModel : FWBaseModel

/** thumb */
@property (nonatomic,strong) NSString *thumb;
/** url */
@property (nonatomic,strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
