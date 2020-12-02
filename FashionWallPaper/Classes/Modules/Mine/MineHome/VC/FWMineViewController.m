//
//  FWMineViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMineViewController.h"
#import "FWMineViewModel.h"

@interface FWMineViewController ()

/** mineVM */
@property (nonatomic,strong) FWMineViewModel *mineVM;

@end

@implementation FWMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mineVM loadMineView:self.view];
}

#pragma mark - lazy
- (FWMineViewModel *)mineVM {
    if (!_mineVM) {
        _mineVM = [[FWMineViewModel alloc] init];
    }
    return _mineVM;
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
