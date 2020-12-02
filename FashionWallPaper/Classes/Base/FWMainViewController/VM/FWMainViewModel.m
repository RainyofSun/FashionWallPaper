//
//  FWMainViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMainViewModel.h"
#import "FWTabBarViewController.h"

@implementation FWMainViewModel

#pragma mark - public methods
// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc {
    FWTabBarViewController *tabBar = [[FWTabBarViewController alloc] init];
    [vc.view addSubview:tabBar.view];
    [vc addChildViewController:tabBar];
    tabBar.view.translatesAutoresizingMaskIntoConstraints = NO;
    [tabBar.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

@end
