//
//  FWClassifyTaoTuViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifyTaoTuViewModel.h"
#import "FWWallPaperSliderBarTitleCollectionViewCell.h"
#import "FWClassifySubViewController.h"
#import "FWClassifyTaoTuView.h"
#import "FWClassifyTaoTuViewModel.h"
#import "FWTaoTuDataTool.h"

static NSString *ClassifyTopSliderBarIndifier = @"ClassifyTopSliderBarIndifier";

@interface FWClassifyTaoTuViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce,FWClassifyTaoTuDelegate>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** taoTuHotView */
@property (nonatomic,strong) FWClassifyTaoTuView *taoTuHotView;
/** taoTuNewView */
@property (nonatomic,strong) FWClassifyTaoTuView *taoTuNewView;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** dataTool */
@property (nonatomic,strong) FWTaoTuDataTool *dataTool;
/** localSource */
@property (nonatomic,strong) NSMutableArray <FWClassifyTaoTuModel *>*localSource;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;
/** recordLoadPage */
@property (nonatomic,strong) NSMutableDictionary *recordLoadPage;

@end

@implementation FWClassifyTaoTuViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadClassifyTaoTuView:(UIViewController *)vc {
    [vc addChildViewController:self.pageControlView];
    [vc.view addSubview:self.pageControlView.view];
    [self.pageControlView.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.pageControlView.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:vc.view withOffset:3];
    self.pageControlView.delegate = self;
    self.pageControlView.dataSource = self;
    [self.pageControlView registerClass:[FWWallPaperSliderBarTitleCollectionViewCell class] forTitleViewCellWithReuseIdentifier:ClassifyTopSliderBarIndifier];
    self.pageControlView.selectedIndex = self.selectedItemIndex;
    [self.taoTuHotView wallPaperStartRefresh];
}

#pragma mark - XLPageViewControllerDelegate & XLPageViewControllerDataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    FWClassifySubViewController *subVC = [[FWClassifySubViewController alloc] initWithNibName:@"FWClassifySubViewController" bundle:nil];
    if (index == 0) {
        self.taoTuHotView.taoTuDelegate = self;
        [subVC addClassifyPageSubView:self.taoTuHotView];
    } else {
        self.taoTuNewView.taoTuDelegate = self;
        [subVC addClassifyPageSubView:self.taoTuNewView];
    }
    return subVC;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    FWWallPaperSliderBarTitleCollectionViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:ClassifyTopSliderBarIndifier forIndex:index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    // 页面滑动即删除数据源
    [self.localSource removeAllObjects];
    self.selectedItemIndex = index;
    
    NSArray <FWClassifyTaoTuModel *>* cacheSource = [self.totalSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
    if (cacheSource.count) {
        // 滑动已创建的页面,从缓存中取出数据和已加载的页数
        [self.localSource addObjectsFromArray:cacheSource];
        self.dataTool.page = [[self.recordLoadPage objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]] integerValue];
        if (index == 0) {
            self.dataTool.page < MAXDATA ? [self.taoTuHotView resetFooterStatus:MJRefreshStateIdle] : nil;
            [self.taoTuHotView resetWallPaperSource:self.localSource];
        } else {
            self.dataTool.page < MAXDATA ? [self.taoTuNewView resetFooterStatus:MJRefreshStateIdle] : nil;
            [self.taoTuNewView resetWallPaperSource:self.localSource];
        }
        FLOG(@"切换到已缓存的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    } else {
        // 滑动至新页面
        [self.taoTuNewView wallPaperStartRefresh];
        [self.dataTool resetDefaultPage];
        FLOG(@"切换到新创建的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    }
}

#pragma mark - FWWallPaperDelegate
- (void)pullRefreshPage {
    [self requestLoadData:FWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestLoadData:FWLoadingType_More];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"最热",@"最新"];
    self.selectedItemIndex = 0;
    [self.dataTool resetRequestDataCount:20];
}

- (void)requestLoadData:(FWLoadingType)loadType {
    NSString *dataName = self.selectedItemIndex == 0 ? @"TaoTuHot" : @"TaoTuNew";
    WeakSelf;
    [self.dataTool requestLocalPaperDataName:dataName dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        [weakSelf.localSource removeAllObjects];
        [weakSelf.localSource addObjectsFromArray:(NSArray <FWClassifyTaoTuModel *>*)responseObject];
        // 数据更新时，同时更新数据缓存中的数据和已加载的页数
        [weakSelf.totalSource setValue:[weakSelf.localSource copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        [weakSelf.recordLoadPage setValue:[@(weakSelf.dataTool.page) copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        FWClassifyTaoTuView *tempView = weakSelf.selectedItemIndex == 0 ? weakSelf.taoTuHotView : weakSelf.taoTuNewView;
        [tempView reloadClassifyTaoTuSource:weakSelf.localSource];
        isNoMoreData ? [tempView resetFooterStatus:MJRefreshStateNoMoreData]: nil;
        isNoMoreData ? [MBHUDToastManager showBriefAlert:@"没有更多数据了"] : nil;
    } loadingDataType:loadType];
}

- (XLPageViewControllerConfig *)pageControlConfig {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题按钮边缘距离
    config.btnDistanceToEdge = 20;
    //标题间距
    config.titleSpace = 20;
    //标题高度
    config.titleViewHeight = 45;
    //标题选中颜色
    config.titleSelectedColor = RGB(34, 34, 34);
    //标题选中字体
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
    //标题正常颜色
    config.titleNormalColor = RGBA(0, 0, 0, 0.8);
    //标题正常字体
    config.titleNormalFont = [UIFont systemFontOfSize:17];
    //阴影颜色
    config.shadowLineColor = RGB(45, 213, 118);
    //阴影宽度
    config.shadowLineWidth = 27;
    //阴影距离边缘位置
    config.shadowLineDistanceToEdge = 5;
    //分割线颜色
    config.separatorLineColor = RGB(238, 238, 238);
    //标题位置
    config.titleViewAlignment = XLPageTitleViewAlignmentLeft;
    
    return config;
}

#pragma mark - lazy
- (XLPageViewController *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XLPageViewController alloc] initWithConfig:[self pageControlConfig]];
    }
    return _pageControlView;
}

- (FWClassifyTaoTuView *)taoTuHotView {
    if (!_taoTuHotView) {
        _taoTuHotView = [[[NSBundle mainBundle] loadNibNamed:@"FWClassifyTaoTuView" owner:nil options:nil] firstObject];
    }
    return _taoTuHotView;
}

- (FWClassifyTaoTuView *)taoTuNewView {
    if (!_taoTuNewView) {
        _taoTuNewView = [[[NSBundle mainBundle] loadNibNamed:@"FWClassifyTaoTuView" owner:nil options:nil] firstObject];
    }
    return _taoTuNewView;
}

- (FWTaoTuDataTool *)dataTool {
    if (!_dataTool) {
        _dataTool = [[FWTaoTuDataTool alloc] init];
    }
    return _dataTool;
}

- (NSMutableArray<FWClassifyTaoTuModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

- (NSMutableDictionary *)totalSource {
    if (!_totalSource) {
        _totalSource = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _totalSource;
}

- (NSMutableDictionary *)recordLoadPage {
    if (!_recordLoadPage) {
        _recordLoadPage = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _recordLoadPage;
}

@end
