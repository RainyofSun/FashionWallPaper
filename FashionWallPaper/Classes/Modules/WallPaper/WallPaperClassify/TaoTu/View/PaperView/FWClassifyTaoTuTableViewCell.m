//
//  FWClassifyTaoTuTableViewCell.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWClassifyTaoTuTableViewCell.h"

@interface FWClassifyTaoTuTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *userHeadBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** thumbScrollView */
@property (nonatomic,strong) UIScrollView *thumbScrollView;
/** thumbArray */
@property (nonatomic,strong) NSMutableArray <NSString *> *thumbArray;

@end

@implementation FWClassifyTaoTuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userHeadBtn.layer.cornerRadius = CGRectGetWidth(self.userHeadBtn.bounds)/2;
    self.userHeadBtn.clipsToBounds = YES;
    [self addScrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.thumbScrollView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.userHeadBtn];
    [self.thumbScrollView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.bgView withOffset:-15];
    [self.thumbScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLab withOffset:3];
    [self.thumbScrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.bgView withOffset:-3];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)loadTaoTuCellSource:(FWClassifyTaoTuModel *)modelSource {
    [self.thumbArray removeAllObjects];
    [self.userHeadBtn loadNetworkImg:modelSource.upic bigPlaceHolder:NO];
    self.userNameLab.text = modelSource.uploader;
    self.dateLab.text = modelSource.date;
    self.titleLab.text = modelSource.name;
    [self.thumbArray addObject:modelSource.thumb1];
    [self.thumbArray addObject:modelSource.thumb2];
    [self.thumbArray addObject:modelSource.thumb3];
    [self.thumbArray addObject:modelSource.thumb4];
    [self.thumbArray addObject:modelSource.thumb5];
    [self.thumbArray addObject:modelSource.thumb6];
    [self addThumbBtn];
}

#pragma mark - Target
- (void)selectedWallPaper:(UIButton *)sender {
    [FLModuleMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedPaper:) params:self.thumbArray[(sender.tag - 200)]];
}

#pragma mark - private methods
- (void)addScrollView {
    if (@available(iOS 11.0, *)) {
        self.thumbScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.thumbScrollView = [[UIScrollView alloc] init];
    self.thumbScrollView.backgroundColor = HexColor(0xF7F7F7);
    self.thumbScrollView.showsHorizontalScrollIndicator = NO;
    self.thumbScrollView.showsVerticalScrollIndicator = NO;
    [self.bgView addSubview:self.thumbScrollView];
}

- (void)addThumbBtn {
    CGFloat Padding = 3;
    CGFloat W = 80;
    self.thumbScrollView.contentSize = CGSizeMake((W + Padding) * self.thumbArray.count + Padding, 0);
    for (NSInteger i = 0; i < self.thumbArray.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item loadNetworkImg:self.thumbArray[i] bigPlaceHolder:YES];
        item.imageView.contentMode = UIViewContentModeScaleAspectFill;
        item.tag = 200 + i;
        item.frame = CGRectMake(Padding + (W + Padding) * i, 2, W, W * 2.6);
        item.layer.cornerRadius = 5.f;
        [item addTarget:self action:@selector(selectedWallPaper:) forControlEvents:UIControlEventTouchUpInside];
        [self.thumbScrollView addSubview:item];
    }
}

#pragma mark - lazy
- (NSMutableArray<NSString *> *)thumbArray {
    if (!_thumbArray) {
        _thumbArray = [NSMutableArray array];
    }
    return _thumbArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
