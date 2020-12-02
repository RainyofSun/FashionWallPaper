//
//  FWWallPaperCollectionViewCell.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWWallPaperCollectionViewCell.h"

@interface FWWallPaperCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *paperImgView;

@end

@implementation FWWallPaperCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.paperImgView.layer.cornerRadius = 5.f;
    self.paperImgView.clipsToBounds = YES;
}

- (void)resetWallPaperImg:(NSString *)imgUrl {
    [self.paperImgView loadNetworkImg:imgUrl bigPlaceHolder:YES];
}

@end
