//
//  FWFenLeiModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWFenLeiModel : FWBaseModel

/** labelId */
@property (nonatomic,strong) NSNumber *labelId;
/** class_id */
@property (nonatomic,strong) NSNumber *class_id;
/** name */
@property (nonatomic,strong) NSString *name;
/** pic */
@property (nonatomic,strong) NSString *pic;

@end

NS_ASSUME_NONNULL_END
