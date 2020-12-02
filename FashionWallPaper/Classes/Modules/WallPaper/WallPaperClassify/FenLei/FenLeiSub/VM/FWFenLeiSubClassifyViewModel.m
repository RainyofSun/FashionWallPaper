//
//  FWFenLeiSubClassifyViewModel.m
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFenLeiSubClassifyViewModel.h"
#import "FWSubClassifyDataTool.h"
#import "FWSubClassifyView.h"

@interface FWFenLeiSubClassifyViewModel ()<FWSubClassifyDelegate>

/** dataTool */
@property (nonatomic,strong) FWSubClassifyDataTool *dataTool;
/** subClassifyView */
@property (nonatomic,strong) FWSubClassifyView *subClassifyView;

@end

@implementation FWFenLeiSubClassifyViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)loadFenLeiSubClassifyView:(UIView *)view {
    [view addSubview:self.subClassifyView];
    self.subClassifyView.wallPaperDelegate = self;
    [self.subClassifyView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.subClassifyView wallPaperStartRefresh];
}

#pragma mark - FWSubClassifyDelegate
- (void)pullRefreshPage {
    [self requestLoadData:FWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestLoadData:FWLoadingType_More];
}

- (void)didSelectedWallPaper:(FWSubClassifyPicModel *)paperModel {
    NSString *downloadUrl = [paperModel.url hasSuffix:@"mp4"] ? paperModel.thumb : paperModel.url;
    [[self.subClassifyView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"thumblink":paperModel.thumb,@"downloadUrl":downloadUrl} vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)requestLoadData:(FWLoadingType)loadType {
    WeakSelf;
    [self.dataTool requestSubClassifyData:self.subClassifyParams dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        [weakSelf.subClassifyView loadSubClassifyPicSource:(NSArray <FWSubClassifyPicModel *>*)responseObject];
        if (isNoMoreData) {
            [MBHUDToastManager showBriefAlert:@"没有更多数据了"];
            [weakSelf.subClassifyView resetFooterStatus:MJRefreshStateNoMoreData];
        }
    } loadingType:loadType];
}

#pragma mark - lazy
- (FWSubClassifyDataTool *)dataTool {
    if (!_dataTool) {
        _dataTool = [[FWSubClassifyDataTool alloc] init];
    }
    return _dataTool;
}

- (FWSubClassifyView *)subClassifyView {
    if (!_subClassifyView) {
        _subClassifyView = [[FWSubClassifyView alloc] init];
    }
    return _subClassifyView;
}

@end
