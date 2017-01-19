//
//  PlaceMapCell.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceMapCell.h"

@implementation PlaceMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_mapView startLoadMap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)searchAction:(id)sender {
}

- (IBAction)voiceAction:(id)sender {
}

@end
