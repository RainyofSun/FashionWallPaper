//
//  FWDynamicPaperSubViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicPaperSubViewController.h"

@interface FWDynamicPaperSubViewController ()

@end

@implementation FWDynamicPaperSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/// 添加子View
- (void)addDynamicPaperPageSubView:(UIView *)subView {
    [self.view addSubview:subView];
    [subView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
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
