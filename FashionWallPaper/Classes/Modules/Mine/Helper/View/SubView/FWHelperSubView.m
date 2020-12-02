//
//  FWHelperSubView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHelperSubView.h"
#import <WebKit/WKWebView.h>

@interface FWHelperSubView ()

/** wkWebView */
@property (nonatomic,strong) WKWebView *wkWebView;

@end

@implementation FWHelperSubView

- (instancetype)init {
    if (self = [super init]) {
        [self setupWebView];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadWebSource:(NSString *)fileName {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.html",fileName] withExtension:nil];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
}

#pragma mark - private methods
- (void)setupWebView {
    [self addSubview:self.wkWebView];
    [self.wkWebView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - lazy
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] init];
    }
    return _wkWebView;
}

@end
