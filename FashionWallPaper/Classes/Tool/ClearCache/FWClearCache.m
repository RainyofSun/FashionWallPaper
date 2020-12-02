//
//  FWClearCache.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClearCache.h"

static FWClearCache *_cachesManager = nil;

@implementation FWClearCache
{
    NSString *_cachesDirPath;
}

+ (FWClearCache *)sharedManager {
    if (_cachesManager == nil) {
        @synchronized(self) {
            if (_cachesManager == nil) {
                _cachesManager = [[[self class] alloc] init];
            }
        }
    }
    return _cachesManager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *cachesPath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        _cachesDirPath = [cachesPath copy];
    }
    return self;
}

- (NSString *)getAllTheCacheFileSize {
    return [NSString stringWithFormat:@"%.2f MB",[self requestCachesFileSize]];
}

- (BOOL)clearCaches {
    if([self requestCachesFileSize] > 0) {
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:_cachesDirPath];
        for (NSString *file in files) {
            NSString *path = [_cachesDirPath stringByAppendingPathComponent:file];
            if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            }
        }
        return YES;
    } else {
        return NO;
    }
}

- (float)requestCachesFileSize {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:_cachesDirPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:_cachesDirPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [_cachesDirPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
