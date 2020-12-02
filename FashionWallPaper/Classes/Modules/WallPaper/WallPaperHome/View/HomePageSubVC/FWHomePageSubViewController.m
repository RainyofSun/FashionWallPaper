//
//  FWHomePageSubViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHomePageSubViewController.h"

@interface FWHomePageSubViewController ()

@end

@implementation FWHomePageSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 消息透传
- (void)selectedClassify:(NSNumber *)senderTag {
    if ([senderTag isEqualToNumber:@(100)] || [senderTag isEqualToNumber:@(101)]) {
        [self.navigationController pushViewController:[FLModuleMsgSend sendMsg:senderTag vcName:@"FWWallPaperClassifyViewController"] animated:YES];
    } else if ([senderTag isEqualToNumber:@(102)]) {
        [self.navigationController pushViewController:[FLModuleMsgSend sendMsg:senderTag vcName:@"FWClassifyTaoTuViewController"] animated:YES];
    } else if ([senderTag isEqualToNumber:@(103)]) {
        [self.navigationController pushViewController:[FLModuleMsgSend sendMsg:senderTag vcName:@"FWFeiLeiViewController"] animated:YES];
    }
}

#pragma mark - public methods
- (void)addHomePageSubView:(UIView *)subView {
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
