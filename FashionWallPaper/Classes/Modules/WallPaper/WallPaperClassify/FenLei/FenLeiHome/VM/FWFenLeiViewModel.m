//
//  FWFenLeiViewModel.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFenLeiViewModel.h"
#import "FWFenLeiSubView.h"
#import "FWFenLeiModel.h"
#import "ZXCategorySliderBar.h"
#import "ZXPageCollectionView.h"

@interface FWFenLeiViewModel ()<ZXCategorySliderBarDelegate,ZXPageCollectionViewDelegate,ZXPageCollectionViewDataSource,FenLeiSubViewDelegate>

/** pageCollectionView */
@property (nonatomic,strong) ZXPageCollectionView *pageCollectionView;
/** topSliderBar */
@property (nonatomic,strong) ZXCategorySliderBar *topSliderBar;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;

@end

@implementation FWFenLeiViewModel

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
- (void)loadFenLeiView:(UIView *)view {
    self.topSliderBar.delegate = self;
    self.pageCollectionView.delegate = self;
    self.pageCollectionView.dataSource = self;
    
    self.topSliderBar.originIndex = self.selectedItemIndex;
    self.topSliderBar.itemArray = self.titleArray;
    self.topSliderBar.moniterScrollView = self.pageCollectionView.mainScrollView;
    self.pageCollectionView.mainScrollView.bounces = NO;
    
    [view addSubview:self.topSliderBar];
    [view addSubview:self.pageCollectionView];
    
    [self getLocalData:self.selectedItemIndex];
}

#pragma mark - ZXCategorySliderBarDelegate
- (void)didSelectedIndex:(NSInteger)index {
    self.selectedItemIndex = index;
    [self.pageCollectionView moveToIndex:index animation:YES];
}

#pragma mark - ZXPageCollectionViewDelegate
- (NSInteger)numberOfItemsInZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView {
    return self.titleArray.count;
}

- (void)ZXPageViewDidScroll:(UIScrollView *)scrollView direction:(NSString *)direction {
    [self.topSliderBar adjustIndicateViewX:scrollView direction:direction];
}

- (UIView *)ZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView viewForItemAtIndex:(NSInteger)index {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"fenLeiView%ld",(long)index];
    FWFenLeiSubView *fenLeiView = (FWFenLeiSubView *)[ZXPageCollectionView dequeueReuseViewWithReuseIdentifier:reuseIdentifier forIndex:index];
    if (!fenLeiView) {
        fenLeiView = [[FWFenLeiSubView alloc] init];
        fenLeiView.wallPaperDelegate = self;
        fenLeiView.reuseIdentifier = reuseIdentifier;
    }
    return fenLeiView;
}

- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view {
    NSLog(@"===== %s =====",__func__);
    self.selectedItemIndex = pageView.currentIndex;
    [self.topSliderBar setSelectIndex:pageView.currentIndex];
    NSArray <FWFenLeiModel *>*cacheArray = (NSArray <FWFenLeiModel *>*)[self.totalSource valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
    if (cacheArray.count) {
        FWFenLeiSubView *subView = (FWFenLeiSubView *)view;
        [subView reloadFenLeiSource:cacheArray];
    } else {
        [self getLocalData:self.selectedItemIndex];
    }
}

- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView {
    self.topSliderBar.isMoniteScroll = YES;
    self.topSliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}

#pragma mark - FenLeiSubViewDelegate
- (void)didSelectedWallPaper:(FWFenLeiModel *)paperModel {
    FLOG(@"paper %@ %@",paperModel.class_id,paperModel.labelId);
    [[self.pageCollectionView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"class_id":paperModel.class_id,@"labelId":paperModel.labelId,@"title":self.titleArray[self.selectedItemIndex]} vcName:@"FWFenLeiSubClassifyViewController"] animated:YES];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"热门",@"动漫卡通",@"游戏天地",@"情感文字",@"唯美风景",@"美女达人",
                        @"明星名人",@"动物萌宠",@"设计创意",@"影视娱乐",@"汽车机械",@"logo物语",
                        @"节日节气",@"体育运动",@"头像",];
    
    self.fileNameArray = @[@"Hot",@"DongMan",@"Game",@"QingGan",@"FengJing",
                           @"MeiNv",@"MingXing",@"Animal",@"Design",
                           @"Movie",@"Car",@"Logo",@"JieRi",@"TiYu",@"TouXiang",];
    self.selectedItemIndex = 0;
}

- (void)getLocalData:(NSInteger)fenLeiIndex {
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:self.fileNameArray[fenLeiIndex] localData:^(id  _Nonnull responseObject) {
        NSArray <FWFenLeiModel *>*tempModelArray = [FWFenLeiModel modelArrayWithDictArray:(NSArray *)responseObject];
        [weakSelf.totalSource setValue:tempModelArray forKey:[NSString stringWithFormat:@"%ld",(long)fenLeiIndex]];
        [weakSelf didSelectedIndex:weakSelf.selectedItemIndex];
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - lazy
- (ZXPageCollectionView *)pageCollectionView {
    if (!_pageCollectionView) {
        CGFloat top = IPHONEXAbove ? 88 : 64;
        _pageCollectionView = [[ZXPageCollectionView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight - 40 - top)];
    }
    return _pageCollectionView;
}

- (ZXCategorySliderBar *)topSliderBar {
    if (!_topSliderBar) {
        _topSliderBar = [[ZXCategorySliderBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40) itemInterval:(ScreenWidth == 414 ? 24 : 18.5)];
    }
    return _topSliderBar;
}

- (NSMutableDictionary *)totalSource {
    if (!_totalSource) {
        _totalSource = [NSMutableDictionary dictionaryWithCapacity:self.fileNameArray.count];
    }
    return _totalSource;
}

@end
