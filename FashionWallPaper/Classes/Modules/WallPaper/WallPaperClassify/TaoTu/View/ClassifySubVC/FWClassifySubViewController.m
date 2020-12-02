//
//  FWClassifySubViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifySubViewController.h"

@interface FWClassifySubViewController ()

@end

@implementation FWClassifySubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 消息透传
- (void)selectedPaper:(NSString *)thumbUrl {
    FLOG(@"选择地址 %@",thumbUrl);
    NSString *subStr = @"@w_400,q_90";
    NSString *tempStr = thumbUrl;
    if ([thumbUrl hasSuffix:@"@w_400,q_90"]) {
        tempStr = [thumbUrl substringToIndex:(thumbUrl.length - subStr.length)];
    }
    [self.navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"thumblink":thumbUrl,@"downloadUrl":tempStr} vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - public methods
- (void)addClassifyPageSubView:(UIView *)subView {
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
