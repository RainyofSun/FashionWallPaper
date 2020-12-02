//
//  FWClassifyTaoTuViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifyTaoTuViewController.h"
#import "FWClassifyTaoTuViewModel.h"

@interface FWClassifyTaoTuViewController ()

/** taoTuVM */
@property (nonatomic,strong) FWClassifyTaoTuViewModel *taoTuVM;

@end

@implementation FWClassifyTaoTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"套图";
    [self.taoTuVM loadClassifyTaoTuView:self];
}

#pragma mark - lazy
- (FWClassifyTaoTuViewModel *)taoTuVM {
    if (!_taoTuVM) {
        _taoTuVM = [[FWClassifyTaoTuViewModel alloc] init];
    }
    return _taoTuVM;
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
