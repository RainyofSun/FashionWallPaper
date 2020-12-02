//
//  FWMineViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMineViewModel.h"
#import "FWMineView.h"

@interface FWMineViewModel ()

/** mineView */
@property (nonatomic,strong) FWMineView *mineView;

@end

@implementation FWMineViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMineView:(UIView *)view {
    [view addSubview:self.mineView];
    [self.mineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self collectionChange];
}

- (void)collectionChange {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FWCommonCache UserGlobalCache] willChangeValueForKey:@"collectionArray"];
        [[FWCommonCache UserGlobalCache] didChangeValueForKey:@"collectionArray"];
    });
}

#pragma mark - lazy
- (FWMineView *)mineView {
    if (!_mineView) {
        _mineView = [[[NSBundle mainBundle] loadNibNamed:@"FWMineView" owner:nil options:nil] firstObject];
    }
    return _mineView;
}

@end
