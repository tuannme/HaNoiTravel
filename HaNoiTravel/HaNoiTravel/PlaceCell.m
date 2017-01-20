//
//  PlaceCell.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/20/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceCell.h"

@implementation PlaceCell

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
