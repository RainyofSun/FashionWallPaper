//
//  FWClassifyBtn.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifyBtn.h"

@implementation FWClassifyBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:RGB(80, 80, 87) forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 10, CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds));
    self.titleLabel.frame = CGRectMake(0, CGRectGetWidth(self.bounds) + 8, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetWidth(self.bounds) - 8);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
