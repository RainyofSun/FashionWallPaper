//
//  FWHelperMainView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHelperMainView.h"
#import "FWHelperSliderBar.h"
#import "FWHelperSubView.h"

@interface FWHelperMainView ()<UIScrollViewDelegate>

/** topBar */
@property (nonatomic,strong) FWHelperSliderBar *topBar;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray;
/**mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** viewSource */
@property (nonatomic,strong) NSMutableDictionary *viewSource;
/** selectedIndex */
@property (nonatomic,assign) NSInteger selectedIndex;

@end

@implementation FWHelperMainView

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.mainScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topBar];
    
    FWHelperSubView *tempView = (FWHelperSubView *)[self.viewSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
    tempView.frame = CGRectMake(0, 8, CGRectGetWidth(self.bounds), (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.topBar.bounds)));
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 消息透传
- (void)switchTopSliderBarItem:(NSNumber *)senderTag {
    self.selectedIndex = senderTag.integerValue;
    FWHelperSubView *tempView = (FWHelperSubView *)[self.viewSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
    if (!tempView) {
        FWHelperSubView *subView = [self createSubView:senderTag.integerValue];
        [self.mainScrollView addSubview:subView];
        subView.frame = CGRectMake(ScreenWidth * senderTag.integerValue, 0, ScreenWidth, (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.topBar.bounds)));
        [subView loadWebSource:self.fileNameArray[senderTag.integerValue]];
    }
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

/**
*  滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    FLOG(@"不是人为拖拽scrollView导致滚动完毕");
    
}

/**
 *  滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    FLOG(@"人为拖拽scrollView导致滚动完毕");
    self.selectedIndex = scrollView.contentOffset.x / ScreenWidth;
    [self.topBar switchSliderIndex:self.selectedIndex];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"设置壁纸",@"保存壁纸",@"编辑封面",@"常见问题"];
    self.fileNameArray = @[@"setting_1_8_0",@"help_1_8_0",@"edit_cover_1_8_0",@"qa_help_1_8_0"];
    self.selectedIndex = 0;
}

- (void)setupUI {
    
    self.mainScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * self.titleArray.count, 0);
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mainScrollView];
    
    [self addSubview:self.topBar];
    [self.topBar loadSliderBarTitleSource:self.titleArray];
    FWHelperSubView *firstView = [self createSubView:self.selectedIndex];
    [self.mainScrollView addSubview:firstView];
    [firstView loadWebSource:self.fileNameArray[self.selectedIndex]];
}

- (FWHelperSubView *)createSubView:(NSInteger)index {
    FWHelperSubView *subView = [[FWHelperSubView alloc] init];
    [self.viewSource setValue:subView forKey:[NSString stringWithFormat:@"%ld",(long)index]];
    return subView;
}

#pragma mark - lazy
- (FWHelperSliderBar *)topBar {
    if (!_topBar) {
        _topBar = [[FWHelperSliderBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    }
    return _topBar;
}

- (NSMutableDictionary *)viewSource {
    if (!_viewSource) {
        _viewSource = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _viewSource;
}

@end
