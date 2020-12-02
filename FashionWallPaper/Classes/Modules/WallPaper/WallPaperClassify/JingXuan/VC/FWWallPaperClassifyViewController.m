//
//  FWWallPaperClassifyViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperClassifyViewController.h"
#import "FWWallPaperClassifyViewModel.h"

@interface FWWallPaperClassifyViewController ()

/** classifyVM */
@property (nonatomic,strong) FWWallPaperClassifyViewModel *classifyVM;

@end

@implementation FWWallPaperClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.classifyVM loadWallPaperClassifyView:self.view];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)paprams {
    if ([paprams isKindOfClass:[NSNumber class]]) {
        NSInteger senderTag = [paprams integerValue];
        switch (senderTag) {
            case 100:
                self.title = @"精选专题";
                self.classifyVM.localDataName = @"JingXuan";
                break;
            case 101:
                self.title = @"原创专区";
                self.classifyVM.localDataName = @"YuanChuang";
                break;
            default:
                break;
        }
    }
}

#pragma mark - lazy
- (FWWallPaperClassifyViewModel *)classifyVM {
    if (!_classifyVM) {
        _classifyVM = [[FWWallPaperClassifyViewModel alloc] init];
    }
    return _classifyVM;
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
