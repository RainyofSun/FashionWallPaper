//
//  FWDynamicWallPaperViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicWallPaperViewController.h"
#import "FWDynamicWallPaperViewModel.h"

@interface FWDynamicWallPaperViewController ()

/** dynamicWallPaperVM */
@property (nonatomic,strong) FWDynamicWallPaperViewModel *dynamicWallPaperVM;

@end

@implementation FWDynamicWallPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.dynamicWallPaperVM loadTopPageControl:self];
}

#pragma mark - lazy
- (FWDynamicWallPaperViewModel *)dynamicWallPaperVM {
    if (!_dynamicWallPaperVM) {
        _dynamicWallPaperVM = [[FWDynamicWallPaperViewModel alloc] init];
    }
    return _dynamicWallPaperVM;
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
