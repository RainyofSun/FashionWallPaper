//
//  FWCommonCache.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWCommonCache.h"

static FWCommonCache *cache = nil;

@implementation FWCommonCache

+ (instancetype)UserGlobalCache {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!cache) {
            cache = [[FWCommonCache alloc] init];
            cache.collectionArray = [NSMutableArray array];
        }
    });
    return cache;
}

- (void)removeCollectionCache {
    [cache.collectionArray removeAllObjects];
}

@end
