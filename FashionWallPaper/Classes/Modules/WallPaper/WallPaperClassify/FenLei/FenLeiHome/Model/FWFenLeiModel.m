//
//  FWFenLeiModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFenLeiModel.h"

@implementation FWFenLeiModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"labelId":@"id"};
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
