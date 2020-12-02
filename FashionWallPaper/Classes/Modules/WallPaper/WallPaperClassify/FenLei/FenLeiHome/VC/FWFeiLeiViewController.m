//
//  FWFeiLeiViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFeiLeiViewController.h"
#import "FWFenLeiViewModel.h"

@interface FWFeiLeiViewController ()

/** feiLeiVM */
@property (nonatomic,strong) FWFenLeiViewModel *feiLeiVM;

@end

@implementation FWFeiLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"分类";
    [self.feiLeiVM loadFenLeiView:self.view];
}

#pragma mark - lazy
- (FWFenLeiViewModel *)feiLeiVM {
    if (!_feiLeiVM) {
        _feiLeiVM = [[FWFenLeiViewModel alloc] init];
    }
    return _feiLeiVM;
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
