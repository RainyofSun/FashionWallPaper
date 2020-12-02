//
//  FWHelperViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHelperViewModel.h"
#import "FWHelperMainView.h"

@interface FWHelperViewModel ()

/** mainView */
@property (nonatomic,strong) FWHelperMainView *mainView;

@end

@implementation FWHelperViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)loadHelperView:(UIView *)view {
    [view addSubview:self.mainView];
    [self.mainView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - lazy
- (FWHelperMainView *)mainView {
    if (!_mainView) {
        _mainView = [[FWHelperMainView alloc] init];
    }
    return _mainView;
}

@end
