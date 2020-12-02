//
//  FWWallPaperDetailViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperDetailViewModel.h"
#import "FWWallPaperDetailView.h"

@interface FWWallPaperDetailViewModel ()<FWWallPaperDetailDelegate>

/** detailView */
@property (nonatomic,strong) FWWallPaperDetailView *detailView;

@end

@implementation FWWallPaperDetailViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadWallPaperDetailView:(UIView *)view {
    [view addSubview:self.detailView];
    self.detailView.wallPaperDelegate = self;
    [self.detailView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.detailView showDetailPaper:[self.wallPaperSource objectForKey:@"thumblink"]];
}

#pragma mark - FWWallPaperDetailDelegate
- (void)downloadWallPaper {
    WeakSelf;
    [[[FWCommonCache UserGlobalCache] mutableArrayValueForKey:@"collectionArray"] addObject:self.wallPaperSource];
    [FWNetworkTool downLoadWithURLString:[self.wallPaperSource objectForKey:@"downloadUrl"] progerss:^(CGFloat progress) {
        // TODO 下载进度
    } success:^(NSURL * _Nonnull targetPath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf saveImageToPhotos:[UIImage imageWithData:[NSData dataWithContentsOfURL:targetPath]]];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - lazy
- (FWWallPaperDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"FWWallPaperDetailView" owner:nil options:nil] firstObject];
    }
    return _detailView;
}

@end
