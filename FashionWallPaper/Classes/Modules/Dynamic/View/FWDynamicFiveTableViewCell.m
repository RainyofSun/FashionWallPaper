//
//  FWDynamicFiveTableViewCell.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicFiveTableViewCell.h"

@interface FWDynamicFiveTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *userHeadBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *dynamicLab;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn1;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn2;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn3;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn4;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnContainerViewH;

/** btnArray */
@property (nonatomic,strong) NSArray <UIButton *>*btnArray;
/** mediaArray */
@property (nonatomic,strong) NSArray <FWDynamicMediaModel *>*mediaArray;

@end

@implementation FWDynamicFiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnArray = @[self.dynamicBtn1,self.dynamicBtn2,self.dynamicBtn3,
                      self.dynamicBtn4,self.dynamicBtn5];
    self.userHeadBtn.layer.cornerRadius = CGRectGetWidth(self.userHeadBtn.bounds)/2;
    self.userHeadBtn.clipsToBounds = YES;
    self.btnContainerViewH.constant = (ScreenWidth - 1)/2;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)loadDynamicFiveCellModel:(FWDynamicModel *)modelSource {
    [self.userHeadBtn loadNetworkImg:modelSource.user.pic bigPlaceHolder:NO];
    self.userNameLab.text = modelSource.user.name;
    self.nameLab.text = modelSource.text;
    self.dateLab.text = modelSource.time;
    self.dynamicLab.text = modelSource.labelStr;
    self.mediaArray = modelSource.media;
    for (NSInteger i = 0; i < modelSource.media.count; i ++) {
        [self.btnArray[i] loadNetworkImg:modelSource.media[i].thumb bigPlaceHolder:NO];
        self.btnArray[i].imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

- (IBAction)selectedDynamicBtn:(UIButton *)sender {
    [FLModuleMsgSend sendCumtomMethodMsg:self.superview.superview methodName:@selector(selectedWallPaper:) params:self.mediaArray[sender.tag]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
