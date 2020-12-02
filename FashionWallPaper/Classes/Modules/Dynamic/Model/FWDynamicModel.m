//
//  FWDynamicModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicModel.h"

@implementation FWDynamicModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"user":@"FWDynamicUserModel",
             @"media":@"FWDynamicMediaModel"
             };
}

- (void)setMedia:(NSArray<FWDynamicMediaModel *> *)media {
    _media = media;
    if (media.count == 9) {
        self.cellStyle = DynamicCellStyle_Nine;
        self.cellHeight = 500;
    } else if (media.count == 5) {
        self.cellStyle = DynamicCellStyle_Five;
        self.cellHeight = 230 + (ScreenWidth - 1)/2;
    } else if (media.count == 2) {
        self.cellStyle = DynamicCellStyle_Two;
        self.cellHeight = 130 + (ScreenWidth - 1)/2;
    } else {
        self.cellStyle = DynamicCellStyle_Default;
        self.cellHeight = 0;
    }
}

- (NSString *)labelStr {
    if (self.labels.count) {
        return [NSString stringWithFormat:@"# %@ #",[self.labels componentsJoinedByString:@" "]];
    }
    return @"";
}

@end
