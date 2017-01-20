//
//  PlaceCell.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/20/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
