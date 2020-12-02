//
//  FWWallPaperViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperViewController.h"
#import "FWWallPaperViewModel.h"

@interface FWWallPaperViewController ()

/** wallPaperVM */
@property (nonatomic,strong) FWWallPaperViewModel *wallPaperVM;

@end

@implementation FWWallPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.wallPaperVM loadTopPageControl:self];
}

#pragma mark - lazy
- (FWWallPaperViewModel *)wallPaperVM {
    if (!_wallPaperVM) {
        _wallPaperVM = [[FWWallPaperViewModel alloc] init];
    }
    return _wallPaperVM;
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
