//
//  FWWallPaperModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWWallPaperModel : FWBaseModel

/** thumblink */
@property (nonatomic,strong) NSString *thumblink;
/** link */
@property (nonatomic,strong) NSString *link;
/** sharenum */
@property (nonatomic,strong) NSNumber *sharenum;
/** upnum */
@property (nonatomic,strong) NSNumber *upnum;
/** dissnum */
@property (nonatomic,strong) NSNumber *dissnum;
/** commentnum */
@property (nonatomic,strong) NSNumber *commentnum;
/** downnum */
@property (nonatomic,strong) NSNumber *downnum;
/** date */
@property (nonatomic,strong) NSString *date;
/** original */
@property (nonatomic,strong) NSString *original;
/** watermark_url */
@property (nonatomic,strong) NSString *watermark_url;
/** uname */
@property (nonatomic,strong) NSString *uname;
/** upic */
@property (nonatomic,strong) NSString *upic;
/** suid */
@property (nonatomic,strong) NSString *suid;

@end

NS_ASSUME_NONNULL_END
