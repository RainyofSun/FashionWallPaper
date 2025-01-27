//
//  FWClearCache.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWClearCache : NSObject

+ (FWClearCache *)sharedManager;
- (NSString *)getAllTheCacheFileSize;
- (BOOL)clearCaches;

@end

NS_ASSUME_NONNULL_END
