//
//  FWHudAnimationView.m
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWHudAnimationView.h"

@interface FWHudAnimationView ()

@property (nonatomic,strong) UIImageView *animationImgView;

@end

@implementation FWHudAnimationView

- (instancetype)showWithSuperView:(UIView *)view {
    FWHudAnimationView *animationView = [[FWHudAnimationView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    animationView.center = view.center;
    [view addSubview:animationView];
    return animationView;
}

- (void)hideAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.animationImgView stopAnimating];
        self.animationImgView.animationImages = nil;
        [self.animationImgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addAnimation];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.animationImgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)addAnimation {
    NSArray *ary = @[[UIImage imageNamed:@"wp_data_loading1"],
                     [UIImage imageNamed:@"wp_data_loading2"],
                     [UIImage imageNamed:@"wp_data_loading3"],
                     [UIImage imageNamed:@"wp_data_loading4"]
                         ];
    self.animationImgView.animationImages = ary;
    self.animationImgView.animationDuration = 2;//动画时间
    self.animationImgView.animationRepeatCount = 0;//动画重复次数，0：无限
    [self.animationImgView startAnimating];//开始动画
    //    [self.animationImageView stopAnimating];//停止动画
    [self addSubview:self.animationImgView];
}

#pragma mark - lazy
- (UIImageView *)animationImgView {
    if (!_animationImgView) {
        _animationImgView = [[UIImageView alloc] init];
    }
    return _animationImgView;
}

@end
