//
//  FWMinePaperViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMinePaperViewController.h"
#import "FWMinePaperViewModel.h"

@interface FWMinePaperViewController ()

/** minePaperVM */
@property (nonatomic,strong) FWMinePaperViewModel *minePaperVM;

@end

@implementation FWMinePaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的壁纸";
    [self.minePaperVM loadMinePaperView:self.view];
}

#pragma mark - lazy
- (FWMinePaperViewModel *)minePaperVM {
    if (!_minePaperVM) {
        _minePaperVM = [[FWMinePaperViewModel alloc] init];
    }
    return _minePaperVM;
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
