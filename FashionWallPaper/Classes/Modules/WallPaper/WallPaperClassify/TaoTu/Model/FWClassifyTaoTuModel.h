//
//  FWClassifyTaoTuModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWClassifyTaoTuModel : FWBaseModel

/** name */
@property (nonatomic,strong) NSString *name;
/** uploader */
@property (nonatomic,strong) NSString *uploader;
/** date */
@property (nonatomic,strong) NSString *date;
/** thumb1 */
@property (nonatomic,strong) NSString *thumb1;
/** thumb2 */
@property (nonatomic,strong) NSString *thumb2;
/** thumb3 */
@property (nonatomic,strong) NSString *thumb3;
/** thumb4 */
@property (nonatomic,strong) NSString *thumb4;
/** thumb5 */
@property (nonatomic,strong) NSString *thumb5;
/** thumb6 */
@property (nonatomic,strong) NSString *thumb6;
/** upic */
@property (nonatomic,strong) NSString *upic;

@end

NS_ASSUME_NONNULL_END
