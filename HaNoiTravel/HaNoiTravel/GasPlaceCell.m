//
//  GasPlaceCell.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "GasPlaceCell.h"

@implementation GasPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.masksToBounds = NO;
    _containerView.layer.shadowOpacity = 1.f;
    _containerView.layer.shadowOffset = CGSizeMake(0, 3);
    _containerView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
