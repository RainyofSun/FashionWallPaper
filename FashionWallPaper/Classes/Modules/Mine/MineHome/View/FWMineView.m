//
//  FWMineView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWMineView.h"

@interface FWMineView ()

@property (weak, nonatomic) IBOutlet UIImageView *headBtn;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImgView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLab;
@property (weak, nonatomic) IBOutlet UIButton *paperBtn1;
@property (weak, nonatomic) IBOutlet UIButton *paperBtn2;
@property (weak, nonatomic) IBOutlet UIButton *paperBtn3;
@property (weak, nonatomic) IBOutlet UIButton *paperBtn4;

/** btnArray */
@property (nonatomic,strong) NSArray <UIButton *>*btnArray;

@end

@implementation FWMineView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.paperBtn1.layer.cornerRadius = self.paperBtn2.layer.cornerRadius = self.paperBtn3.layer.cornerRadius = self.paperBtn4.layer.cornerRadius = 5.f;
    self.paperBtn1.clipsToBounds = self.paperBtn2.clipsToBounds = self.paperBtn3.clipsToBounds = self.paperBtn4.clipsToBounds = YES;
    [[FWCommonCache UserGlobalCache] addObserver:self forKeyPath:@"collectionArray" options:NSKeyValueObservingOptionNew context:nil];
    self.btnArray = @[self.paperBtn1,self.paperBtn2,self.paperBtn3,self.paperBtn4];
}

- (void)dealloc {
    [[FWCommonCache UserGlobalCache] removeObserver:self forKeyPath:@"collectionArray"];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (IBAction)clickCollectionPaper:(UIButton *)sender {
    NSInteger cacheNum = [FWCommonCache UserGlobalCache].collectionArray.count;
    NSArray <NSDictionary *>*tempArray;
    if (cacheNum <= 4) {
        tempArray = [FWCommonCache UserGlobalCache].collectionArray;
    } else {
        tempArray = [[FWCommonCache UserGlobalCache].collectionArray subarrayWithRange:NSMakeRange(cacheNum - 4, 4)];
    }
    tempArray = [[tempArray reverseObjectEnumerator] allObjects];
    NSDictionary *dict = tempArray[sender.tag];
    [[self nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:dict vcName:@"FWWallPaperDetailViewController"] animated:YES];
}

- (IBAction)showMoreCollection:(UIButton *)sender {
    [[self nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@"" vcName:@"FWMinePaperViewController"] animated:YES];
}

- (IBAction)seakHelp:(UIButton *)sender {
    [[self nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@"" vcName:@"FWHelperViewController"] animated:YES];
}

- (IBAction)clearCache:(UIButton *)sender {
    NSString *size = [[FWClearCache sharedManager] getAllTheCacheFileSize];
    FLOG(@"缓存大小 %@",size);
    if (size.floatValue > 0) {
        FWHudAnimationView *animationView = [[FWHudAnimationView alloc] showWithSuperView:self.superview];
        if ([[FWClearCache sharedManager] clearCaches]) {
            [animationView hideAnimation];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBHUDToastManager showBriefAlert:@"图片缓存已清理"];
            });
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"collectionArray"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.emptyLab.hidden = self.emptyImgView.hidden = [FWCommonCache UserGlobalCache].collectionArray.count;
            NSInteger cacheNum = [FWCommonCache UserGlobalCache].collectionArray.count;
            NSArray <NSDictionary *>*tempArray;
            if (cacheNum <= 4) {
                tempArray = [FWCommonCache UserGlobalCache].collectionArray;
            } else {
                tempArray = [[FWCommonCache UserGlobalCache].collectionArray subarrayWithRange:NSMakeRange(cacheNum - 4, 4)];
            }
            tempArray = [[tempArray reverseObjectEnumerator] allObjects];
            for (NSInteger i = 0; i < tempArray.count; i ++) {
                [self.btnArray[i] loadNetworkImg:[tempArray[i] objectForKey:@"thumblink"] bigPlaceHolder:YES];
                self.btnArray[i].imageView.contentMode = UIViewContentModeScaleAspectFill;
            }
        });
    }
}

@end
