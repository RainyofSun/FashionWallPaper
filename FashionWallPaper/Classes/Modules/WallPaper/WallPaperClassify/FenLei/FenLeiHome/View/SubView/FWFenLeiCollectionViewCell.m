//
//  FWFenLeiCollectionViewCell.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWFenLeiCollectionViewCell.h"

@interface FWFenLeiCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation FWFenLeiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.thumbImgView.layer.cornerRadius = 5.f;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)loadFenLeiCellSource:(FWFenLeiModel *)cellSource {
    [self.thumbImgView loadNetworkImg:cellSource.pic bigPlaceHolder:NO];
    self.titleLab.text = cellSource.name;
}

@end
