//
//  FWFenLeiSubClassifyViewModel.h
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWFenLeiSubClassifyViewModel : FWBaseViewModel

/** subClassifyParams */
@property (nonatomic,strong) NSDictionary *subClassifyParams;

- (void)loadFenLeiSubClassifyView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
