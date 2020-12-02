//
//  FWWallPaperDetailView.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperDetailView.h"

@interface FWWallPaperDetailView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroudImgView;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end

@implementation FWWallPaperDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.downloadBtn.layer.cornerRadius = CGRectGetHeight(self.downloadBtn.bounds)/2;
    self.downloadBtn.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)showDetailPaper:(NSString *)img_url {
    [self.backgroudImgView loadNetworkImg:img_url bigPlaceHolder:YES];
}

#pragma mark - Target
- (IBAction)clickDownloadBtn:(UIButton *)sender {
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(downloadWallPaper)]) {
        [self.wallPaperDelegate downloadWallPaper];
    }
}

- (IBAction)clickBackBtn:(UIButton *)sender {
    [[self nearsetViewController].navigationController popViewControllerAnimated:YES];
}

#pragma mark - private methods

@end
