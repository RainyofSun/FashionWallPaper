//
//  FWHelperViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHelperViewController.h"
#import "FWHelperViewModel.h"

@interface FWHelperViewController ()

/** helperVM */
@property (nonatomic,strong) FWHelperViewModel *helperVM;

@end

@implementation FWHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帮助文档";
    [self.helperVM loadHelperView:self.view];
}

#pragma mark - lazy
- (FWHelperViewModel *)helperVM {
    if (!_helperVM) {
        _helperVM = [[FWHelperViewModel alloc] init];
    }
    return _helperVM;
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
