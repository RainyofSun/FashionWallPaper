//
//  FWDynamicPaperModel.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWDynamicPaperModel : FWBaseModel

/** name */
@property (nonatomic,strong) NSString *name;
/** thumb */
@property (nonatomic,strong) NSString *thumb;
/** url --> mp4 播放地址 */
@property (nonatomic,strong) NSString *url;
/** preview_url */
@property (nonatomic,strong) NSString *preview_url;
/** date */
@property (nonatomic,strong) NSString *date;
/** uid */
@property (nonatomic,strong) NSString *uid;
/** upic */
@property (nonatomic,strong) NSString *upic;

@end

NS_ASSUME_NONNULL_END
