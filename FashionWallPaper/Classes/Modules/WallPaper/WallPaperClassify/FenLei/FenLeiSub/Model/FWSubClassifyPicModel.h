//
//  FWSubClassifyPicModel.h
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWSubClassifyPicModel : FWBaseModel

/** thumb */
@property (nonatomic,strong) NSString *thumb;
/** url */
@property (nonatomic,strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
