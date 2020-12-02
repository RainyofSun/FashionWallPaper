//
//  FWDynamicModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"
#import "FWDynamicUserModel.h"
#import "FWDynamicMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DynamicCellStyle_Default,
    DynamicCellStyle_Nine,
    DynamicCellStyle_Five,
    DynamicCellStyle_Two,
} DynamicCellStyle;

@interface FWDynamicModel : FWBaseModel

/** text */
@property (nonatomic,strong) NSString *text;
/** time */
@property (nonatomic,strong) NSString *time;
/** labels */
@property (nonatomic,strong) NSArray *labels;
/** user */
@property (nonatomic,strong) FWDynamicUserModel *user;
/** media */
@property (nonatomic,strong) NSArray <FWDynamicMediaModel *>*media;

/** labelStr */
@property (nonatomic,strong) NSString *labelStr;
/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;
/** cellStyle */
@property (nonatomic,assign) DynamicCellStyle cellStyle;

@end

NS_ASSUME_NONNULL_END
