//
//  FWDynamicWallPaperViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicWallPaperViewModel.h"
#import "FWWallPaperSliderBarTitleCollectionViewCell.h"
#import "FWDynamicWallPaperDataTool.h"
#import "FWDynamicPaperSubViewController.h"
#import "FWDynamicPaperView.h"

static NSString *DynamicTopSliderBarIndifier = @"DynamicTopSliderBarIndifier";

@interface FWDynamicWallPaperViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce,FWDynamicPaperDelegate>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** dataTool */
@property (nonatomic,strong) FWDynamicWallPaperDataTool *dataTool;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** paperViewDict */
@property (nonatomic,strong) NSMutableDictionary *paperViewDict;
/** localSource */
@property (nonatomic,strong) NSMutableArray <FWDynamicPaperModel*>*localSource;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;
/** recordLoadPage */
@property (nonatomic,strong) NSMutableDictionary *recordLoadPage;

@end

@implementation FWDynamicWallPaperViewModel

- (void)dealloc {
    for (FWDynamicPaperView *view in self.paperViewDict.allValues) {
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
    [self.pageControlView registerClass:[FWWallPaperSliderBarTitleCollectionViewCell class] forTitleViewCellWithReuseIdentifier:DynamicTopSliderBarIndifier];
    self.pageControlView.selectedIndex = self.selectedItemIndex;
    [self.paperViewDict.allValues.firstObject wallPaperStartRefresh];
}

#pragma mark - XLPageViewControllerDelegate & XLPageViewControllerDataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    FWDynamicPaperSubViewController *subVC = [[FWDynamicPaperSubViewController alloc] initWithNibName:@"FWDynamicPaperSubViewController" bundle:nil];
    [subVC addDynamicPaperPageSubView:[self createWallPaperView:index]];
    return subVC;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    FWWallPaperSliderBarTitleCollectionViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:DynamicTopSliderBarIndifier forIndex:index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    // 页面滑动即删除数据源
    [self.localSource removeAllObjects];
    self.selectedItemIndex = index;
    NSArray <FWDynamicPaperModel *>* cacheSource = [self.totalSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
    if (cacheSource.count) {
        // 滑动已创建的页面,从缓存中取出数据和已加载的页数
        [self.localSource addObjectsFromArray:cacheSource];
        self.dataTool.page = [[self.recordLoadPage objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]] integerValue];
        FWDynamicPaperView *tempView = (FWDynamicPaperView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
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

- (void)didSelectedWallPaper:(FWDynamicPaperModel *)paperModel {
    [self.pageControlView.parentViewController.navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"thumblink":paperModel.thumb,@"downloadUrl":paperModel.thumb} vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"最热",@"最新",@"感恩节",@"雪景",@"情侣头像",@"萌芽熊",@"王者荣耀",@"秋意浓",@"文字",@"明星",@"爱情",@"二次元"];
    self.selectedItemIndex = 0;
    [self.dataTool resetRequestDataCount:30];
}

- (void)requestLoadData:(FWLoadingType)loadType {
    WeakSelf;
    [self.dataTool requestLocalPaperData:self.selectedItemIndex dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        [weakSelf.localSource removeAllObjects];
        [weakSelf.localSource addObjectsFromArray:(NSArray <FWDynamicPaperModel *>*)responseObject];
        // 数据更新时，同时更新数据缓存中的数据和已加载的页数
        [weakSelf.totalSource setValue:[weakSelf.localSource copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        [weakSelf.recordLoadPage setValue:[@(weakSelf.dataTool.page) copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        FWDynamicPaperView *tempView = (FWDynamicPaperView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
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

- (FWDynamicPaperView *)createWallPaperView:(NSInteger)index {
    FWDynamicPaperView *paperView = [[FWDynamicPaperView alloc] init];
    paperView.wallPaperDelegate = self;
    [self.paperViewDict setValue:paperView forKey:[NSString stringWithFormat:@"%ld",(long)index]];
    return paperView;
}

- (FWDynamicPaperView *)findPaperView:(FWDynamicPaperSubViewController *)subVC {
    FWDynamicPaperView *tempView;
    for (UIView *view in subVC.view.subviews) {
        if ([view isKindOfClass:[FWDynamicPaperView class]]) {
            tempView = (FWDynamicPaperView *)view;
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

- (FWDynamicWallPaperDataTool *)dataTool {
    if (!_dataTool) {
        _dataTool = [[FWDynamicWallPaperDataTool alloc] init];
    }
    return _dataTool;
}

- (NSMutableDictionary *)paperViewDict {
    if (!_paperViewDict) {
        _paperViewDict = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _paperViewDict;
}

- (NSMutableArray<FWDynamicPaperModel *> *)localSource {
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
