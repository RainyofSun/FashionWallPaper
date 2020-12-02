//
//  FWFenLeiSubClassifyViewController.m
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFenLeiSubClassifyViewController.h"
#import "FWFenLeiSubClassifyViewModel.h"

@interface FWFenLeiSubClassifyViewController ()

/** subClassifyVM */
@property (nonatomic,strong) FWFenLeiSubClassifyViewModel *subClassifyVM;

@end

@implementation FWFenLeiSubClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.subClassifyVM loadFenLeiSubClassifyView:self.view];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSDictionary class]]) {
        self.title = [params objectForKey:@"title"];
        self.subClassifyVM.subClassifyParams = (NSDictionary *)params;
    }
}

#pragma mark - lazy
- (FWFenLeiSubClassifyViewModel *)subClassifyVM {
    if (!_subClassifyVM) {
        _subClassifyVM = [[FWFenLeiSubClassifyViewModel alloc] init];
    }
    return _subClassifyVM;
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
