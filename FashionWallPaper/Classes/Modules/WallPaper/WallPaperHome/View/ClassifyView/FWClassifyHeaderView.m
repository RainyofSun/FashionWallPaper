//
//  FWClassifyHeaderView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifyHeaderView.h"
#import "FWClassifyBtn.h"

@interface FWClassifyHeaderView ()

/** headerH */
@property (nonatomic,assign,readwrite) CGFloat headerH;

@end

@implementation FWClassifyHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.headerH = 100;
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - Target
- (void)selectedPaperClass:(UIButton *)sender {
    [FLModuleMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedClassify:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - private methods
- (void)setupUI {
    NSArray *titles = @[@"精选",@"原创",@"套图",@"分类"];
    NSArray *imgs   = @[@"livephote_header_chosen_icon",@"livephote_header_original_icon",@"livephote_header_image_set_icon",@"livephote_header_category_icon"];
    CGFloat Padding = 30;
    CGFloat W = (ScreenWidth - Padding * 5)/titles.count;
    for (NSInteger i = 0; i < titles.count; i ++) {
        FWClassifyBtn *item = [FWClassifyBtn buttonWithType:UIButtonTypeCustom];
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        item.tag = 100 + i;
        item.frame = CGRectMake(Padding + (W + Padding) * i, 0, W, self.headerH);
        [self addSubview:item];
        [item addTarget:self action:@selector(selectedPaperClass:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
