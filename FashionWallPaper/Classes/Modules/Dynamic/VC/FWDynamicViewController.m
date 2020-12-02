//
//  FWDynamicViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicViewController.h"
#import "FWDynamicViewModel.h"

@interface FWDynamicViewController ()

/** dynamicVM */
@property (nonatomic,strong) FWDynamicViewModel *dynamicVM;

@end

@implementation FWDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavHiden:NO];
    self.title = @"动态专区";
    [self.dynamicVM loadDynamicView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *lastItem = self.navigationItem.leftBarButtonItems.lastObject;
    lastItem.customView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIBarButtonItem *lastItem = self.navigationItem.leftBarButtonItems.lastObject;
    lastItem.customView.hidden = NO;
}

#pragma mark - lazy
- (FWDynamicViewModel *)dynamicVM {
    if (!_dynamicVM) {
        _dynamicVM = [[FWDynamicViewModel alloc] init];
    }
    return _dynamicVM;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
