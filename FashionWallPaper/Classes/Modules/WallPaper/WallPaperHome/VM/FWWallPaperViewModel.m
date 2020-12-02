//
//  FWWallPaperViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperViewModel.h"
#import "FWWallPaperSliderBarTitleCollectionViewCell.h"
#import "FWHomePageSubViewController.h"
#import "FWWallPaperView.h"
#import "FWWallPaperDataTool.h"

static NSString *topSliderBarIndifier = @"FWHomePageSliderBarTitle";

@interface FWWallPaperViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce,FWWallPaperDelegate>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** dataTool */
@property (nonatomic,strong) FWWallPaperDataTool *dataTool;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** paperViewDict */
@property (nonatomic,strong) NSMutableDictionary *paperViewDict;
/** localSource */
@property (nonatomic,strong) NSMutableArray <FWWallPaperModel *>*localSource;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;
/** recordLoadPage */
@property (nonatomic,strong) NSMutableDictionary *recordLoadPage;

@end

@implementation FWWallPaperViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    for (FWWallPaperView *view in self.paperViewDict.allValues) {
        view.wallPaperDelegate = nil;
        [view removeFromSuperview];
    }
    [self.paperViewDict removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadTopPageControl:(UIViewController *)vc {
    [vc addChildViewController:self.pageControlView];
    [vc.view addSubview:self.pageControlView.view];
    [self.pageControlView.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.pageControlView.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:vc.view withOffset:kStatusBarHeight];
    self.pageControlView.delegate = self;
    self.pageControlView.dataSource = self;
    [self.pageControlView registerClass:[FWWallPaperSliderBarTitleCollectionViewCell class] forTitleViewCellWithReuseIdentifier:topSliderBarIndifier];
    self.pageControlView.selectedIndex = self.selectedItemIndex;
    [self.paperViewDict.allValues.firstObject wallPaperStartRefresh];
}

#pragma mark - XLPageViewControllerDelegate & XLPageViewControllerDataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    FWHomePageSubViewController *subVC = [[FWHomePageSubViewController alloc] initWithNibName:@"FWHomePageSubViewController" bundle:nil];
    [subVC addHomePageSubView:[self createWallPaperView:index]];
    return subVC;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    FWWallPaperSliderBarTitleCollectionViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:topSliderBarIndifier forIndex:index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    // 页面滑动即删除数据源
    [self.localSource removeAllObjects];
    self.selectedItemIndex = index;
    NSArray <FWWallPaperModel *>* cacheSource = [self.totalSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
    if (cacheSource.count) {
        // 滑动已创建的页面,从缓存中取出数据和已加载的页数
        [self.localSource addObjectsFromArray:cacheSource];
        self.dataTool.page = [[self.recordLoadPage objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]] integerValue];
        FWWallPaperView *tempView = (FWWallPaperView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
        self.dataTool.page < MAXDATA ? [tempView resetFooterStatus:MJRefreshStateIdle] : nil;
        [tempView resetWallPaperSource:self.localSource];
        FLOG(@"切换到已缓存的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    } else {
        // 滑动至新页面
        [[self findPaperView:[pageViewController cellVCForRowAtIndex:index]] wallPaperStartRefresh];
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

- (void)didSelectedWallPaper:(FWWallPaperModel *)paperModel {
    [self.pageControlView.parentViewController.navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"thumblink":paperModel.thumblink,@"downloadUrl":paperModel.link} vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"最热",@"最新",@"原创",@"情侣头像",@"高清",@"可爱",@"星空",@"情侣",@"你想要的"];
    self.selectedItemIndex = 0;
    [self.dataTool resetRequestDataCount:30];
}

- (void)requestLoadData:(FWLoadingType)loadType {
    WeakSelf;
    [self.dataTool requestLocalPaperData:self.selectedItemIndex dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        [weakSelf.localSource removeAllObjects];
        [weakSelf.localSource addObjectsFromArray:(NSArray <FWWallPaperModel *>*)responseObject];
        // 数据更新时，同时更新数据缓存中的数据和已加载的页数
        [weakSelf.totalSource setValue:[weakSelf.localSource copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        [weakSelf.recordLoadPage setValue:[@(weakSelf.dataTool.page) copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        FWWallPaperView *tempView = (FWWallPaperView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
        [tempView loadWallPaperSource:weakSelf.localSource];
        isNoMoreData ? [tempView resetFooterStatus:MJRefreshStateNoMoreData]: nil;
        isNoMoreData ? [MBHUDToastManager showBriefAlert:@"没有更多数据了"] : nil;
    } loadingDataType:loadType];
}

- (XLPageViewControllerConfig *)pageControlConfig {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题按钮边缘距离
    config.btnDistanceToEdge = 10;
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
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    
    return config;
}

- (FWWallPaperView *)createWallPaperView:(NSInteger)index {
    FWWallPaperView *paperView = [[FWWallPaperView alloc] initNeedRegisterHeaderView:(index == 0)];
    paperView.wallPaperDelegate = self;
    [self.paperViewDict setValue:paperView forKey:[NSString stringWithFormat:@"%ld",(long)index]];
    return paperView;
}

- (FWWallPaperView *)findPaperView:(FWHomePageSubViewController *)subVC {
    FWWallPaperView *tempView;
    for (UIView *view in subVC.view.subviews) {
        if ([view isKindOfClass:[FWWallPaperView class]]) {
            tempView = (FWWallPaperView *)view;
            break;
        }
    }
    return tempView;
}

#pragma mark - lazy
- (XLPageViewController *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XLPageViewController alloc] initWithConfig:[self pageControlConfig]];
    }
    return _pageControlView;
}

- (FWWallPaperDataTool *)dataTool {
    if (!_dataTool) {
        _dataTool = [[FWWallPaperDataTool alloc] init];
    }
    return _dataTool;
}

- (NSMutableDictionary *)paperViewDict {
    if (!_paperViewDict) {
        _paperViewDict = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _paperViewDict;
}

- (NSMutableArray<FWWallPaperModel *> *)localSource {
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
        _recordLoadPage = [NSMutableDictionary dictionary];
    }
    return _recordLoadPage;
}

@end
