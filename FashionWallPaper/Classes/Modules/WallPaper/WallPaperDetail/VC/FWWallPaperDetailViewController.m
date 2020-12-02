//
//  FWWallPaperDetailViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperDetailViewController.h"
#import "FWWallPaperDetailViewModel.h"

@interface FWWallPaperDetailViewController ()

/** detailVM */
@property (nonatomic,strong) FWWallPaperDetailViewModel *detailVM;

@end

@implementation FWWallPaperDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.detailVM loadWallPaperDetailView:self.view];
    [self setNavHiden:YES];
}

#pragma mark - 消息传递
- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSDictionary class]]) {
        self.detailVM.wallPaperSource = (NSDictionary *)params;
    }
}

#pragma mark - lazy
- (FWWallPaperDetailViewModel *)detailVM {
    if (!_detailVM) {
        _detailVM = [[FWWallPaperDetailViewModel alloc] init];
    }
    return _detailVM;
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
