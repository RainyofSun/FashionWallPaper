//
//  FWDynamicTableViewCell.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWDynamicTableViewCell.h"

@interface FWDynamicTableViewCell ()

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
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn6;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn7;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn8;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn9;

/** btnArray */
@property (nonatomic,strong) NSArray <UIButton *>*btnArray;
/** mediaArray */
@property (nonatomic,strong) NSArray <FWDynamicMediaModel *>*mediaArray;

@end

@implementation FWDynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnArray = @[self.dynamicBtn1,self.dynamicBtn2,self.dynamicBtn3,
                      self.dynamicBtn4,self.dynamicBtn5,self.dynamicBtn6,
                      self.dynamicBtn7,self.dynamicBtn8,self.dynamicBtn9];
    self.userHeadBtn.layer.cornerRadius = CGRectGetWidth(self.userHeadBtn.bounds)/2;
    self.userHeadBtn.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)loadDynamicNineCell:(FWDynamicModel *)cellModel {
    [self.userHeadBtn loadNetworkImg:cellModel.user.pic bigPlaceHolder:NO];
    self.userNameLab.text = cellModel.user.name;
    self.nameLab.text = cellModel.text;
    self.dateLab.text = cellModel.time;
    self.dynamicLab.text = cellModel.labelStr;
    self.mediaArray = cellModel.media;
    for (NSInteger i = 0; i < cellModel.media.count; i ++) {
        [self.btnArray[i] loadNetworkImg:cellModel.media[i].thumb bigPlaceHolder:NO];
        self.btnArray[i].imageView.contentMode = UIViewContentModeScaleAspectFill;
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
