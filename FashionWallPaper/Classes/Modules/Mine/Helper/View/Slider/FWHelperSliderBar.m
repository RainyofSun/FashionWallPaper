//
//  FWHelperSliderBar.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHelperSliderBar.h"

@interface FWHelperSliderBar ()

/** btnArray */
@property (nonatomic,strong) NSMutableArray <UIButton *>*btnArray;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation FWHelperSliderBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    for (UIButton *item in _btnArray) {
        [item removeFromSuperview];
    }
    [self.btnArray removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadSliderBarTitleSource:(NSArray<NSString *> *)titleSource {
    self.btnArray = [NSMutableArray arrayWithCapacity:titleSource.count];
    [self setupSliderbarItems:titleSource];
}

- (void)switchSliderIndex:(NSInteger)index {
    [self touchTopSliderBar:self.btnArray[index]];
}

- (void)touchTopSliderBar:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self resetTopSliderItemStatus];
    sender.titleLabel.alpha = 1;
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [sender setTitleColor:RGB(45, 213, 118) forState:UIControlStateNormal];
    sender.selected = !sender.selected;
    [FLModuleMsgSend sendCumtomMethodMsg:self.superview methodName:@selector(switchTopSliderBarItem:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - private methods
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.lineLayer.backgroundColor = RGB(45, 213, 118).CGColor;
    
    [self.layer addSublayer:self.lineLayer];
}

- (void)setupSliderbarItems:(NSArray<NSString *> *)titleSource {
    CGFloat distance = 10;
    CGFloat itemW = (CGRectGetWidth(self.bounds) - distance *(titleSource.count + 1))/titleSource.count;
    CGFloat itemH = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < titleSource.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i;
        i != 0 ? item.titleLabel.alpha = 0.8 : 1;
        item.selected = (i == 0);
        [item setTitle:titleSource[i] forState:UIControlStateNormal];
        [item setTitleColor:(item.selected ? RGB(45, 213, 118) : RGB(31, 31, 31)) forState:UIControlStateNormal];
        item.selected ? item.titleLabel.font = [UIFont boldSystemFontOfSize:17] : nil;
        [item addTarget:self action:@selector(touchTopSliderBar:) forControlEvents:UIControlEventTouchUpInside];
        item.frame = CGRectMake((itemW + distance) * i + distance, 0, itemW, itemH);
        [self addSubview:item];
        [self.btnArray addObject:item];
    }
    
    self.lineLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 0.5, CGRectGetWidth(self.bounds), 0.5);
}

// 重置状态
- (void)resetTopSliderItemStatus {
    for (UIButton *item in self.btnArray) {
        if (item.selected) {
            item.titleLabel.font = [UIFont systemFontOfSize:17];
            item.titleLabel.alpha = 0.8;
            [item setTitleColor:RGB(31, 31, 31) forState:UIControlStateNormal];
            item.selected = NO;
            break;
        }
    }
}

#pragma mark - lazy
- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    return _lineLayer;
}

@end
